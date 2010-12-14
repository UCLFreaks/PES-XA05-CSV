# To change this template, choose Tools | Templates
# and open the template in the editor.

class Status < AnimatedSprite
  def initialize
    @position = [0,0]
    @image =  get_image("status_animation.png")
    super()
  end

  private
  def setup_animation
    @number_of_frames = 6
    add_animation(:run, 500)
    set_animation(:run)
    
  end

end