# To change this template, choose Tools | Templates
# and open the template in the editor.

class Sky

  def initialize
    @sky_sprites = SpriteGroup.new
  end

  def update(miliseconds_elapsed)
    @sky_sprites.update(miliseconds_elapsed)
  end

  def draw(to_screen)
    @sky_sprites.draw(to_screen)
  end


end