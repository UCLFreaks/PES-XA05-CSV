# To change this template, choose Tools | Templates
# and open the template in the editor.

class BasicSprite
  include Rubygame::Sprites::Sprite
  attr_reader :depth
  
  def initialize
    @groups = []
    @velocity = [0.0,0.0]
    @position = [0.0,0.0]
  end


  def draw(to_surface)
    @image.blit(to_surface,@position)
  end

  def velocity
    return @velocity
  end
  def velocity=(vel)
    @velocity = vel
  end

  def position=(pos)
    @position = pos
  end

  def move(dt)
    execute_moving(dt) if should_move?
  end

  def should_move?()
    raise "should_move? is not implemented in #{self.class}"
  end


  def get_image(img_name)
    return Rubygame::Surface.load("./visualization/img/" + img_name)
  end
  def exectue_moving(dt)

  end

  def sprite_size
    return @image.size
  end

end
