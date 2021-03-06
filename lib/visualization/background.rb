=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

The blue sky and the green grass.
=end
class Background
  include Rubygame::Sprites::Sprite

  def initialize(size,sky_height)
    @surface = Rubygame::Surface.new(size)
    generate_landscape(sky_height)
  end

  def generate_landscape(sky_height)
    x = @surface.size[0]
    y = @surface.size[1]
    @surface.draw_box_s([0,0], [x,sky_height], [74,188,252])
    @surface.draw_box_s([0,sky_height],[x,y],[0,255,0])

  end


  def update

  end

  def draw(on_surface)
    @surface.blit(on_surface,[0,0])
  end

end