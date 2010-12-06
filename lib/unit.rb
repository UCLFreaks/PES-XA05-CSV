# To change this template, choose Tools | Templates
# and open the template in the editor.


class Unit < BasicSprite


  def initialize(unit)
    @unit = unit
    @image = Rubygame::Surface.load('./img/soldier.png')
    @position = [0,0]
    @image = @image.zoom_to(32, 32,true)
    @step_after = 20
    @current_step_time = 0
  end

  def update(miliseconds_elapsed)
    @current_step_time += miliseconds_elapsed
    if(@step_after <= @current_step_time)
      @position = [@position[0]+1,@position[1]]
      @current_step_time - @step_after
    end
  end

  def draw(to_surface)

    @image.blit(to_surface,@position)
  end

end