# To change this template, choose Tools | Templates
# and open the template in the editor.

class BasicSprite
  include Rubygame::Sprites::Sprite
  attr_reader :depth
  
  def initialize
    @groups = []
    @destiination = nil
    @move_timer = 0
    @move_after = 20
  end


  def draw(to_surface)
    @image.blit(to_surface,@position)
  end

  def speed
    raise "Speed for #{self.class} is not defined!"
  end

  def set_position(pos)
    @position = pos
  end

  def move_to(pos)
    @destination = pos
  end

  def move(time_elapsed)
    execute_moving if should_move? and time_to_move?(time_elapsed)
  end

  def should_move?()
    raise "should_move? is not implemented in #{self.class}"
  end

  def time_to_move?(time_elapsed)
    @move_timer += time_elapsed
    if(@move_timer >= @move_after)
      @move_timer -= @move_after
      return true
    else
      return false
    end
  end

  def exectue_moving()

  end

  def sprite_size
    return @image.size
  end

end
