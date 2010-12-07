# To change this template, choose Tools | Templates
# and open the template in the editor.

class TankSprite < Unit

  def get_image_base_name(state)
    return "tank"
  end

  def sprite_size
    return [128,64]
  end
end