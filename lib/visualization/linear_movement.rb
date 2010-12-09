# To change this template, choose Tools | Templates
# and open the template in the editor.

module LinearMovement
  def execute_movement(dt)
    time_shift = dt / 1000.0
    dx = time_shift * @velocity[0]
    dy = time_shift * @velocity[1]
    @position = [@position[0] + dx, @position[1] + dy]
  end
end
