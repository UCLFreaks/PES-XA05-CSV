# To change this template, choose Tools | Templates
# and open the template in the editor.

class BasicSprite
  include Rubygame::Sprites::Sprite
  
  


  def draw(to_surface)
    @image.blit(to_surface,@position)
  end

end
