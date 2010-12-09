require "./visualization/sprites/basic_sprite.rb"
require "./visualization/linear_movement.rb"
class Cloud < BasicSprite
  include LinearMovement

  def initialize(sky_width,sky_height)
    super()
    @image = get_image("cloud.png")
    @image = @image.flip(true, false) if rand(2) == 1
    @image = @image.zoom(rand,rand)
    @velocity = [rand(7)+1,0.0]
    @position = [rand(sky_width),rand(sky_height/2)]
    @sky_width = sky_width
  end



  def should_move?
    return true
  end

  def update(dt)
    self.position_x = -@image.size[0] if(@position[0] > @sky_width)
    move(dt)
  end


end