class TankShot < BasicSprite
  attr_reader :status
  def initialize(source_position,target_position)
    super(source_position,target_position)
    @ttl = 400
    @time = 0
  end
  
  def update(dt)
    @time += dt
    if(@time > @ttl && @status == :active)
      @status = :inactive
    end
  end
  
  def draw(to_surface)
    if(@status == :active)
      4.times do |i|
        to_surface.draw_line_a([@source_position[0],@source_position.position[1]+i],
          [@target_position[0],@target_position[1]+i],
          [255,255,0])
      end

    end
  end
  
  
end