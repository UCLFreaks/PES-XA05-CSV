# To change this template, choose Tools | Templates
# and open the template in the editor.

require "./visualization/linear_movement.rb"
require "./visualization/sprites/shot.rb"
class UnitSprite < BasicSprite
  attr_reader :state,:unit,:position
  include LinearMovement

  DEPTH_LEVELS = 12
  UNIT_Y = 46
  UNIT_X = 46


  def initialize(unit,team,vizualizer)
    super()
    @v = vizualizer
    @unit = unit
    @team = team
    @depth = -rand(DEPTH_LEVELS)
    @state = :living
    @direction = :left if @unit.position > 0
    @image = get_image(unit, team,@state)
    @position = [@v.sim_to_vis_x(@unit.position),depth_to_y]
    @last_sim_x = unit.position    
    @shot = nil
    @wait = 0
    @state_after_wait = nil
  end
  
  def hit
    if(@unit.lives <= 0)
         @state = :dead
         @image = get_image(@unit, @team, @state)
    end
         @v.busy_units.delete(self)    
  end
  
  def make_busy
    @v.busy_units << (self)
  end

  def wait_for(miliseconds,new_state)
    @wait = miliseconds
    @state_after_wait = new_state
    make_busy
  end

  def react_to_last_action
    if(@unit.last_action == :fire_hit)
      if (@unit.lives >0)
        wait_for(rand(1500),:shoot)
      else
        shoot
      end
    end
    
    if([:move,:retrat,:crawl].include?(@unit.last_action) and @state == :living)
      #@state = :moving
      wait_for(rand(1500),:moving)
      puts "#{self.class} is moving"
      @destination = @v.sim_to_vis_x(@unit.position)
      distance =   @destination - @position[0]
      current_velocity = max_velocity-min_velocity + rand(max_velocity-min_velocity)
      (distance > 0)? @velocity = [current_velocity,0]:@velocity = [-current_velocity,0]
      @v.busy_units.add(self)
    end
  end


  def update(dt)
    #@position = [@v.sim_to_vis_x(@unit.position),@position[1]]
    if(@wait > 0)
      @wait -= dt
      if(@wait <= 0)
        @state = @state_after_wait
        @state_after_wait = nil
        @wait = 0
      end
    end
    new_state = @state

    


    if(@state == :shoot)
      shoot
      new_state = @state = :living
    end
    
    if(@state == :moving)
      x_position_before = @position[0]
      move(dt)
      if((x_position_before-@destination).abs < (@position[0] - @destination).abs or @destination.round == @position[0].round)
        new_state = :living
        @position = [@destination,@position[1]]
        @destination = nil
        @v.busy_units.delete(self)
        
      end
    end
    @last_sim_x = @unit.position
    @state = new_state
    if( @shot != nil)
      @shot.update(dt)
      @shot = nil if @shot.status == :inactive
    end
  end
  
  def depth_to_y
    return @v.sky_height - sprite_size[1] +  - @depth * (@v.world_size[1]-@v.sky_height)/DEPTH_LEVELS
  end

  def should_move?
    return true if @destination != nil
  end

  def draw(to_surface)
    @shot.draw(to_surface) if @shot != nil
    @image.blit(to_surface,[@position[0]-sprite_size[0]/2,@position[1]])
  end

  def shoot()
      @v.busy_units.delete(self)
      target_unit_sprite = @v.get_unit_sprite(@unit.fired_at)
      target_unit_sprite.make_busy
      @shot = Shot.new(self,target_unit_sprite)
  end

  def get_image(unit,team,state)
    if(team == :team1)
      team_suffix = "_r"
    else
      team_suffix = "_b"
    end
    state_suffix = ""
    case state
    when :living
      state_suffix = ""
    when :dead
      state_suffix = "_d"
    else
      state_suffix = ""
    end


    image = super(get_image_base_name(state)+team_suffix+state_suffix+'.png')
    image = image.flip(true, false) if @direction == :left
    image = image.zoom_to(sprite_size[0], sprite_size[1],true)
    return image
  end


  def sprite_size()
    return [UNIT_X,UNIT_Y]
  end
  
  def max_velocity
    return 40
  end

  def min_velocity
    return 20
  end

  def print_busy_units
    puts ""
    @v.busy_units.each do |unit|
      puts "#{unit.id} #{unit.state}"
    end
    puts ""
  end
  
  def get_image_base_name(state)
    return "soldier"
  end


end