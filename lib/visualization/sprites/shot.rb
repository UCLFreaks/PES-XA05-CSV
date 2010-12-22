class Shot < BasicSprite
  attr_reader :status
  def initialize(source_position,target_position)
    super()
    @source_position = source_position
    @target_position = target_position
    @status = :active
  end
  
  def update(dt)
    raise "Not implemented for #{self.class}"
  end
  
  def draw(to_surface)
    raise "Not implemented for #{self.class}"
  end

  def flying?
    return @status == :active
  end
  
end