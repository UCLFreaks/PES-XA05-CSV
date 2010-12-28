# To change this template, choose Tools | Templates
# and open the template in the editor.
require "./visualization/linear_movement.rb"
class RifleShot < Shot
  include LinearMovement
  def initialize(weapon,source_position,target_position,target)
    super(weapon,source_position,target_position)
    @position = source_position
    @velocity = Vector.from_points(source_position, target_position)
    @velocity.normalize!
    @velocity = [@velocity[0]*200,@velocity[1]*200]
    @hitting = hitting
    @target = target
    @col_rect = Rubygame::Rect.new(@position[0],@position[1],4,4)
    #puts "Tank shot spawned"
  end
  def col_rect
    @col_rect.x=(@position[0])
    @col_rect.y=(@position[1])
    return @col_rect
  end

  def update(dt)

    execute_movement(dt)
    if(@status == :active)
      if(collide_sprite?(@target))
        @status = :inactive
        @weapon.hit_target
        #puts "Colision"
      end
    end
  end

  def should_move?
    return true
  end

  def draw(to_surface)
    to_surface.draw_circle_s(@position, 2, [255,255,0]) if(@status == :active)
  end

end