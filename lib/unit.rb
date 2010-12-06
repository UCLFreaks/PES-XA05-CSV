# To change this template, choose Tools | Templates
# and open the template in the editor.


class Unit < BasicSprite
  DEPTH_LEVELS = 6
  UNIT_Y = 46
  UNIT_X = 46

  def initialize(unit,team,vizualizer)
    @v = vizualizer
    @unit = unit
    @team = team
    @depth = rand(DEPTH_LEVELS)
    @image = get_image(unit, team,:living)
    @position = [@v.sim_to_vis_x(@unit.position)-UNIT_X/2,depth_to_y]
    @image = @image.zoom_to(UNIT_X, UNIT_Y,true)
    @image = @image.flip(true, false) if @unit.position > 0
    super()
  end

  def update(miliseconds_elapsed)
    @position = [@v.sim_to_vis_x(@unit.position)-UNIT_X/2,@position[1]]
  end
  
  def depth_to_y
    return @v.sky_height - UNIT_Y +  @depth * (@v.world_size[1]-@v.sky_height)/DEPTH_LEVELS 
  end

  def draw(to_surface)

    @image.blit(to_surface,@position)
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
    end

    return Rubygame::Surface.load('./img/'+get_image_base_name+team_suffix+state_suffix+'.png')
  end

  def get_image_base_name
    return "soldier"
  end


end