class Shot < BasicSprite
  attr_reader :status
  def initialize(owner,target)
    super()
    @target  = target
    @owner = owner
    @ttl = 400
    @time = 0
    @status = :active
  end
  
  def update(dt)
    @time += dt
    if(@time > @ttl && @status == :active)
      @status = :inactive
      @target.hit
    end
  end
  
  def draw(to_surface)
    if(@status == :active)
      4.times do |i|
        to_surface.draw_line_a([@owner.position[0],@owner.position[1]+32+i],
          [@target.position[0],@target.position[1]+32+i],
          [255,255,0])
      end

    end
  end
  
  
end