# To change this template, choose Tools | Templates
# and open the template in the editor.

class BasicSprite
  include Rubygame::Sprites::Sprite
  attr_reader :depth
  
  def initialize
    @groups = []
  end


  def draw(to_surface)
    @image.blit(to_surface,@position)
  end

  def speed
    raise "Speed for #{self.class} is not defined!"
  end

  def sprite_size
    return @image.size
  end

end
