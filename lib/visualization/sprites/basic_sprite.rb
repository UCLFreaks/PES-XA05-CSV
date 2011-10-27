=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Class that implements basic sprite needs.
=end
#Class that implements basic sprite needs.
class BasicSprite
  include Rubygame::Sprites::Sprite
  attr_reader :depth
  
  def initialize
    @groups = []
    @velocity = [0.0,0.0] #Velocity vector is in pixels per second
    @position = [0.0,0.0]
    @sounds = {}
    load_sounds
  end



  #Draws the sprite to the surface.
  # []
  def draw(to_surface)
    @image.blit(to_surface,[@position[0].round,@position[1].round])
  end

  #Loads sounds of the sprite
  def load_sounds

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
  
  def position_x
    return @position[0]
  end
  
  def position_x=(x)
    @position = [x,@position[1]]
  end
  
  def position_y
    return @position[1]
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
    img =  Rubygame::Surface.load("./visualization/img/" + img_name)
    return img
  end
  

  def execute_movement(dt)
    raise "Execute movement is not implemented for #{self.class}"
  end

  def sprite_size
    return @image.size
  end

end
