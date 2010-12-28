# To change this template, choose Tools | Templates
# and open the template in the editor.

require "./visualization/linear_movement.rb"
require "./visualization/sprites/shot.rb"
require "./visualization/sprites/tank_shot.rb"
require "./visualization/weapons/weapon.rb"
require "./visualization/weapons/tank_gun.rb"
require "./visualization/weapons/sniper_rifle.rb"
require "./visualization/weapons/machine_gun.rb"
require "./visualization/sprites/rifle_shot.rb"

#Visual representation of unit
class UnitSprite < AnimatedSprite
  attr_reader :state,:unit,:position,:weapon_hardpoint, :busy_reason
  include LinearMovement

  #Number of y lines that units are placed onto.
  DEPTH_LEVELS = 12
  #Size of unit
  UNIT_Y = 64
  UNIT_X = 64

  #Creates the unit sprite.
  #
  #Parameters:
  # - unit unit object of this sprite
  # - team can be :team1 (blue) or :team2 (red)
  # - visualizer the encapsulating BattleVisualizer
  def initialize(unit,team,vizualizer)
    #Encapsulating visualizer
    @v = vizualizer
    #Coresponding unit to the sprite
    @unit = unit
    #Team of the sprite
    @team = team
    #Sets up the @image surface of the animated sprite
    super()
    #Depth level
    @depth = -rand(DEPTH_LEVELS)
    #Current state of the unit. (starting state is :living)
    @state = :living
    #Unit facing direction
    (@unit.position > 0)? @direction = :left : @direction = :right
    #retuns the rotated first frame of the animation according to @direction
    @image = @image.flip(true, false) if @direction == :left
    #Position as an [x,y] array. It corresponds to the center of the sprite
    @position = [@v.sim_to_vis_x(@unit.position),depth_to_y]
    #Last unit's simulation x
    @last_sim_x = unit.position
    #weapon hardpoint - point from which the shots originate
    @weapon_hardpoint = calculate_actual_weapon_hardpoint
    #unit weapon
    @weapon = default_weapon
    #DEPRECATED
    @shot = nil
    #How much wait time is remaining in miliseconds.
    @wait = 0
    #Which state should be set after waiting.
    @state_after_wait = nil
    @busy_reason = ""
  end

  def get_spritesheet
    return get_image(@unit, @team)
  end

  def col_rect
    lcp = left_corner_position
    ss = sprite_size
    return [lcp[0]+10,lcp[1],ss[0]-10,ss[1]]
  end

  def setup_animation
    @number_of_frames = 8
    add_animation(:dead, 750,false,8)
    add_animation(:idle, 1000,false,1)
    add_animation(:run, 500)
    set_animation(:idle)
  end

  #Informs the unit_sprite about hit by a shot. It checks whether the the unit
  #died and removes it from the busy_units list of the encapsulating BattleVisualizer.
  def hit
    if(@unit.lives <= 0)
         if(@state != :dead)
           @state = :dead
           puts "#{@unit.object_id} dies as a sprite"
           set_animation(:dead)
           [@sounds['die3'],@sounds['die2']].sample.play
           make_idle
         end
    end
  end

  #Adds the unit_sprite to the busy_units list of the encapsulating BattleVisualizer
  #thus signalizing that this unit didn't finished yet its action this turn.
  def make_busy(busy_reason)
    @v.busy_units << (self)
    @busy_reason = busy_reason
  end

  #removes the unit sprite from busy_units list of the encapsulating BattleVisualiser
  #thus signalizing that this unit has all its actions this turn.
  def make_idle
    @v.busy_units.delete(self)
    @busy_reason = ""
  end

  def last_action_changed
    react_to_last_action(@unit.last_action)
  end



#Updates the state of the UnitSprite according to current @state of it.
# - _dt_ is number of miliseconds passed since last update call
  def update(dt)
    #@position = [@v.sim_to_vis_x(@unit.position),@position[1]]
    if(@state != :dead)
      if(@wait > 0)
        @wait -= dt
        if(@wait <= 0)
          @state = @state_after_wait
          @state_after_wait = nil
          @wait = 0
        end
      end
    end
    new_state = @state
    if(@state == :shoot)
      shoot
      new_state = @state = :living
    end
    
    if(@state == :moving)
      set_animation(:run) if current_animation['name'] != :run and @unit.last_action != :crawl
      x_position_before = @position[0]
      move(dt)
      if((x_position_before-@destination).abs < (@position[0] - @destination).abs or @destination.round == @position[0].round)
        new_state = :living
        @position = [@destination,@position[1]]
        @destination = nil
        set_animation(:idle)
        @v.busy_units.delete(self)
        
      end
    end
    @last_sim_x = @unit.position
    @state = new_state 
    @weapon.update(dt) if @weapon.firing?
    super(dt)
  end

#Draws the unit to the designated surface
  def draw(to_surface)
    @weapon.draw(to_surface) if @weapon.firing?
    @image = get_current_frame_image
    @image.blit(to_surface,[(@position[0]-sprite_size[0]/2).round,
        (@position[1]-sprite_size[1]/2).round])
    #Drawing bounding box for debuging
#    lcp = left_corner_position
#    to_surface.draw_box(
#      [lcp[0],lcp[1]],
#      [@position[0]+sprite_size[0]/2,@position[1]+sprite_size[1]/2], [255,255,0])
  end

  def left_corner_position
    return [@position[0]-sprite_size[0]/2,@position[1]-sprite_size[1]/2]
  end

private

  def load_sounds
    @sounds['die2'] = AudioManager.get_sound('soldier_die2.wav')
    @sounds['die3'] = AudioManager.get_sound('soldier_die3.wav')
  end

  def react_to_last_action(last_action)
    if(last_action == :fire_hit)
      if (@unit.lives >0)
        if(@v.busy_units.select{|unit| unit.busy_reason == :moving}.count > 0)
          max_waiting_time = 8000
        else
          max_waiting_time = 1500
        end
        wait_for(rand(max_waiting_time),:shoot)
      else
        @state = :shoot
      end
    end

    if([:move,:retrat,:crawl].include?(last_action) and @state == :living)
      #@state = :moving
      wait_for(rand(1500),:moving)
      #puts "#{self.class} is moving"
      @destination = @v.sim_to_vis_x(@unit.position)
      distance =   @destination - @position[0]
      current_velocity = max_velocity-min_velocity + rand(max_velocity-min_velocity)
      (distance > 0)? @velocity = [current_velocity,0]:@velocity = [-current_velocity,0]
      make_busy(:moving)
    end
  end

  def get_current_frame_image
    should_rdrw = should_redraw?
    super
    @image = @image.flip(true, false) if should_rdrw and @direction == :left
    return @image
  end

  def should_move?
    return true if @destination != nil
  end

  def depth_to_y
    return @v.sky_height - sprite_size[1]/2 +  - @depth * (@v.world_size[1]-@v.sky_height)/DEPTH_LEVELS
  end

  def shoot()
      #puts "Shooting at #{@unit.fired_at.object_id}"
      target_unit_sprite = @v.get_unit_sprite(@unit.fired_at)
      @weapon.shoot(target_unit_sprite)
  end

  def get_image(unit,team)
    if(team == :team1)
      team_suffix = "_r"
    else
      team_suffix = "_b"
    end
    image = super(get_image_base_name()+team_suffix+'.png')
    #image = image.flip(true, false) if @direction == :left
    #image = image.zoom_to(sprite_size[0], sprite_size[1],true)
    return image
  end

  #Returns the sprite size as an [x,y] array
  def sprite_size()
    return [UNIT_X,UNIT_Y]
  end

  #Returns the original size of the image.
  #Used for calculating hardpoints.
  def image_original_size
    return [64,64]
  end

  #Returns the maximal velocity of the unit
  def max_velocity
    return 40
  end

  #Returns the minimal velocity of the unit
  def min_velocity
    return 20
  end

  #Returns default weapon of the unit
  def default_weapon
    return MachineGun.new(self)
  end

  #Returns the relative weapon hardpoint coordinates counted from the top left corner for the right facing unit.
  def relative_weapon_hardpoint
    return [53,32]
    #return [0,0]
  end

  #calculates the actual position of the hardpoint after scaling and rotation
  def calculate_actual_weapon_hardpoint
    hc = relative_weapon_hardpoint
    scale_factor = sprite_size[0]/image_original_size[0].to_f
    #puts "Scale factor is: #{scale_factor}"
    hc = [(hc[0]*scale_factor).round,(hc[1]*scale_factor).round]
    if(@direction == :left)
      result =  [sprite_size[0] - hc[0],sprite_size[1] - hc[1]]
    else
      result = hc
    end
    #puts "Hardpoint calculation result: #{result}"
    return result
  end
  
  def get_image_base_name()
    return "soldier_animation"
  end

  #Adds the unit to the busy_list and sets the _new_state_ after _miliseconds_ passed.
  # Important! You have to remove the unit from busy_list yourself!
  def wait_for(miliseconds,new_state)
    if(miliseconds > 0)
      @wait = miliseconds
      @state_after_wait = new_state
      make_busy("Waiting for #{miliseconds} to switch to #{new_state}")
    else
      @state = new_state
      @state_after_wait = nil
    end
 end

end