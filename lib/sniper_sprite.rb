# To change this template, choose Tools | Templates
# and open the template in the editor.

class SniperSprite < Unit
  def get_image_base_name(state)
    return "soldier" if state == :dead
    return "sniper"
  end
end
