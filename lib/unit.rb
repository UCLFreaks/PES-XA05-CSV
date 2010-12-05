# To change this template, choose Tools | Templates
# and open the template in the editor.


class Unit
  include Rubygame::Sprites::Sprite

  def initialize(unit)
    @unit = unit
    @image = Rubygame::Surface.load('./img/soldier.png')
    @position = [0,0]
    @image = @image.zoom_to(32, 32,true)
  end

  def update(seconds_elapsed)
    
  end

  def draw(to_surface)

    @image.blit(to_surface,@position)
  end

end