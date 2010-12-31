=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Module for linear movement of sprites.
=end
module LinearMovement
  def execute_movement(dt)
    time_shift = dt / 1000.0
    dx = time_shift * @velocity[0]
    dy = time_shift * @velocity[1]
    @position = [@position[0] + dx, @position[1] + dy]
  end
end
