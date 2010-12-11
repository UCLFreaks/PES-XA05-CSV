# To change this template, choose Tools | Templates
# and open the template in the editor.

require "./visualization/linear_movement.rb"
class UnitSprite < BasicSprite
  attr_reader :state
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
    
    

    
  end

  def update(miliseconds_elapsed)
    #@position = [@v.sim_to_vis_x(@unit.position),@position[1]]
    new_state = @state
    if([:living,:moving].include?(@state) and @unit.lives <= 0)
         new_state = :dead
         @image = get_image(@unit, @team, new_state)
         @v.busy_units.delete(self)
         
    end
    if(@state == :living and [:move,:retrat,:crawl].include?(@unit.last_action))
      new_state = :moving
      @destination = @v.sim_to_vis_x(@unit.position)
      @v.busy_units.add(self)
      
    end
    if(@state == :moving)
      distance =   @destination - @position[0]
      (distance > 0)? @velocity = [max_velocity,0]:@velocity = [-max_velocity,0]
      x_position_before = @position[0]
      move(miliseconds_elapsed)
      if((x_position_before-@destination).abs < (@position[0] - @destination).abs or @destination.round == @position[0].round)
        new_state = :living
        @position = [@destination,@position[1]]
        @destination = nil
        @v.busy_units.delete(self)
        
      end
    end
    @last_sim_x = @unit.position
    @state = new_state
    @unit.clear_last_action
  end
  
  def depth_to_y
    return @v.sky_height - sprite_size[1] +  -@depth * (@v.world_size[1]-@v.sky_height)/DEPTH_LEVELS
  end

  def should_move?
    return true if @destination != nil
  end

  def draw(to_surface)
    @image.blit(to_surface,[@position[0]-sprite_size[0]/2,@position[1]])
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