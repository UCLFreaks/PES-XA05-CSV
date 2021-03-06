=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Shot of the machine gun.
=end
require "./visualization/linear_movement.rb"
class RifleShot < Shot
  include LinearMovement
  def initialize(weapon,source_position,target_position,target,hitting)
    super(weapon,source_position,target_position)
    @position = source_position
    @velocity = Vector.from_points(source_position, target_position)
    @velocity.normalize!
    @trail = []
    @trail[0] = [(@velocity[0]*10).round,(@velocity[1]*10).round]
    @trail[1] = [(@velocity[0]*5).round,(@velocity[1]*5).round]
    @trail[2] = [(@velocity[0]*10).round,(@velocity[1]*10).round]
    @velocity = [@velocity[0]*300,@velocity[1]*300]
    @hitting = hitting
    @target = target
    @col_rect = Rubygame::Rect.new(@position[0],@position[1],4,4)
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
        @weapon.hit_target if @hitting
      else
        res = Visualization.get_resolution
        if(@position[0]<0 or @position[1]<0)
          @status = :inactive
        elsif(@position[0]> res[0] or @position[1] > res[1])
          @status = :inactive
        end  
      end

    end
  end

  def should_move?
    return true
  end

  def draw(to_surface)
    if(@status == :active)
      #to_surface.draw_circle_s(@position, 2, [255,255,0])
      to_surface.draw_circle_s(@position, 1, [255,0,0])
      3.times do |i|
        end_point = [@position[0]-@trail[0][0],@position[1]-@trail[0][1]+i]
        to_surface.draw_line_a(end_point, @position, [255,255,0])


        to_surface.draw_line_a(
           [end_point[0]  -@trail[1][0],
            end_point[1]  -@trail[1][1]],
            end_point, [248,77,3,167])
        end_point = [@position[0]-@trail[0][0],@position[1]-@trail[0][1]]
        to_surface.draw_line_a(
           [end_point[0]  -@trail[2][0],
            end_point[1]  -@trail[2][1]],
            end_point, [255,255,0,70])
      end
    end
  end



end