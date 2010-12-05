# To change this template, choose Tools | Templates
# and open the template in the editor.

class Background
  include Rubygame::Sprites::Sprite

  def initialize(size)
    @surface = Rubygame::Surface.new(size)
    generate_landscape
  end

  def generate_landscape
    x = @surface.size[0]
    y = @surface.size[1]
    @surface.draw_box_s([0,0], [x,y/2], [0,0,255])
    @surface.draw_box_s([0,y/2],[x,y],[0,255,0])

  end


  def update

  end

  def draw(on_surface)
    @surface.blit(on_surface,[0,0])
  end

end