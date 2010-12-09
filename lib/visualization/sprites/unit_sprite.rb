# To change this template, choose Tools | Templates
# and open the template in the editor.


class UnitSprite < BasicSprite
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
    

    
  end

  def update(miliseconds_elapsed)
    @position = [@v.sim_to_vis_x(@unit.position),@position[1]]
    new_state = @state
    if(@state == :living and @unit.lives <= 0)
         new_state = :dead
         @image = get_image(@unit, @team, new_state)
    end
    @state = new_state
  end
  
  def depth_to_y
    return @v.sky_height - sprite_size[1] +  -@depth * (@v.world_size[1]-@v.sky_height)/DEPTH_LEVELS
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
  def get_image_base_name(state)
    return "soldier"
  end


end