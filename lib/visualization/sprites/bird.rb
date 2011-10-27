=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Status arrow showing that the visualization is running.
I will probably remove it soon.
=end
class Bird < AnimatedSprite
  include LinearMovement
  def initialize
    super()
    @position = [0,0]
    @velocity = [20,0.0]
  end

 def should_move?
    true
  end

  def update(dt)
    move(dt)
    super(dt)
  end

  private
  def setup_animation
    @number_of_frames = 8
    add_animation(:run, 500)
    set_animation(:run)
    
  end

  def get_spritesheet
    return get_image("bird.png")
  end

 



end