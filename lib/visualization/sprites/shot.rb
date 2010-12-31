=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Generic shot.
=end
class Shot < BasicSprite
  attr_reader :status,:hitting
  def initialize(weapon,source_position,target_position)
    super()
    @source_position = source_position
    @target_position = target_position
    @status = :active
    @weapon = weapon
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