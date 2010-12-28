# To change this template, choose Tools | Templates
# and open the template in the editor.

class SniperSprite < UnitSprite
  def get_image_base_name()
    return "sniper"
  end

  def setup_animation
    @number_of_frames = 8
    add_animation(:dead, 750,false,8)
    add_animation(:idle, 1000,false,1)
    add_animation(:run, 500)
    set_animation(:idle)
  end

  def default_weapon
    return TankGun.new(self)
  end

  def relative_weapon_hardpoint
    return [62,32]
  end

  def react_to_last_action(last_action)
    if(last_action == :prepare_weapon)
      set_animation(:idle,@unit.max_focus_time+1-[@unit.focus_time,3].max)
    end
    super(last_action)
  end

end
