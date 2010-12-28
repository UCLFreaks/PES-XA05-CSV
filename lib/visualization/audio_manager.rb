class AudioManager
  @@sounds = {}
  SOUND_PATH = "./visualization/sounds/"

  def AudioManager.get_sound(sound)
    if(@@sounds[sound] == nil)
      load_sound(sound)
    end
    return @@sounds[sound].dup
  end

  private
  def AudioManager.load_sound(sound_name)
    @@sounds[sound_name] = Rubygame::Sound.load(SOUND_PATH + sound_name)
  end





end