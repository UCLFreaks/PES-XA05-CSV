# To change this template, choose Tools | Templates
# and open the template in the editor.

class BasicSprite
  include Rubygame::Sprites::Sprite
  attr_reader :depth
  
  def initialize
    @groups = []
    @velocity = [0.0,0.0] #Velocity vector is in pixels per second
    @position = [0.0,0.0]
  end


  def draw(to_surface)
    @image.blit(to_surface,[@position[0].round,@position[1].round])
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
  
  def position_x=(x)
    @position = [x,@position[1]]
  end
  def position_y=(y)
    @position = [@position[0],y]
  end

  def move(dt)
    execute_movement(dt) if should_move?
  end

  def should_move?()
    raise "should_move? is not implemented for #{self.class}"
  end


  def get_image(img_name)
    return Rubygame::Surface.load("./visualization/img/" + img_name)
  end
  

  def exectue_movement(dt)
    raise "Execute movement is not implemented for #{self.class}"
  end

  def sprite_size
    return @image.size
  end

end
