=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Status arrow showing that the visualization is running.
I will probably remove it soon.
=end
class Status < AnimatedSprite
  def initialize
    @position = [0,0]
    super()
  end

  private
  def setup_animation
    @number_of_frames = 6
    add_animation(:run, 500)
    set_animation(:run)
    
  end

  def get_spritesheet
    return get_image("status_animation.png")
  end

end