=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Sniper rifle weapon implementation.
=end
class SniperRifle < TankGun
  def load_sounds
    @sounds['fire'] = AudioManager.get_sound("sniper_fire.wav")
  end
end