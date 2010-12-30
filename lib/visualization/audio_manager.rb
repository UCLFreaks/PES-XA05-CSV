class AudioManager
  @@sounds = {}
  SOUND_PATH = "./visualization/sounds/"

  def AudioManager.get_sound(sound)
    if(@@sounds[sound] == nil)
      load_sound(sound)
    end
    return @@sounds[sound].dup
  end

  def AudioManager.get_music(music)
    if(@@sounds[music] == nil)
      load_music(music)
    end
    return @@sounds[music].dup
  end

  private
  def AudioManager.load_sound(sound_name)
    return @@sounds[sound_name] = Rubygame::Sound.load(SOUND_PATH + sound_name)
  end

  def AudioManager.load_music(music_name)
    return @@sounds[music_name] = Rubygame::Music.load(SOUND_PATH + music_name)
  end





end