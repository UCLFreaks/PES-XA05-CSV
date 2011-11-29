=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Clouds are here.
=end
require "./visualization/sprites/basic_sprite.rb"
require "./visualization/linear_movement.rb"
class Cloud < BasicSprite
  include LinearMovement

  def initialize(sky_width,sky_height)
    super()
    @image = get_image("cloud.png")
    @image = @image.flip(true, false) if rand(2) == 1
    @image = @image.zoom([0.2,rand()*1.5].max,[0.2,rand].max)
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