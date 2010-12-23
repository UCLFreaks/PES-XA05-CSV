# To change this template, choose Tools | Templates
# and open the template in the editor.

class AnimatedSoldierTest < AnimatedSprite
  def initialize
    
    @image =  get_image("soldier_animation_r.png")
    super()
    @position = [128,0]
  end

  private
  def setup_animation
    @number_of_frames = 8
    add_animation(:dead, 500,false,1)
    add_animation(:idle, 500,false,1)
    add_animation(:run, 500)
    set_animation(:run)
  end

end