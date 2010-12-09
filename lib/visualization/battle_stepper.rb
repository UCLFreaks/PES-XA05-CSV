# To change this template, choose Tools | Templates
# and open the template in the editor.

class BattleStepper

  def initialize(battle,step_after)
    @battle = battle
    @step_after = step_after
    @current_time = 0
    @step = 0
  end

  def update(time_elapsed)
    @current_time += time_elapsed
    if(@current_time >= @step_after and @step < 1)
      @current_time -= @step_after
      @battle.make_step
      @step += 1
    end
  end



end