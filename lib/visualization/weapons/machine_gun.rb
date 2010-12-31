=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Machine gun weapon implementation.
=end
class MachineGun < Weapon
  attr_reader :hit_delivered
  def initialize(owner)
    super(owner)
    @hit_delivered = false
  end

  def spawn_shot
    y_offset = @target.position[1] + rand(64) - 32
    hitting = true if @shots_fired == 0
    @sounds['fire'].play
    return RifleShot.new(self,
      shot_source_position,
      [@target.position[0],y_offset],
      @target,hitting)
  end

  def min_number_of_shots
    return 1
  end

  def max_number_of_shots
    return 4
  end

  def time_between_shots
    return 300
  end

  def shoot(target)
    @hit_delivered = false
    super(target)
  end

  def hit_target
    super
    @hit_delivered = true
  end

  def shooting_finished
    puts "#{@owner.object_id}: Shooting finished"
    if not @hit_delivered
      hit_target
      puts "#{@owner.object_id}: Hitting becouse there was not a hit"
    end
    @hit_delivered = false
  end

  private

  def load_sounds
    @sounds['fire'] = AudioManager.get_sound("soldier_fire2.wav")
  end

end