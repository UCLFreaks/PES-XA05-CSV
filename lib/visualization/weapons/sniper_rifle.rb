# To change this template, choose Tools | Templates
# and open the template in the editor.

class SniperRifle < TankGun
  def load_sounds
    @sounds['fire'] = AudioManager.get_sound("sniper_fire.wav")
  end
end