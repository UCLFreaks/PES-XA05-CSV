=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

This class is responsible for stepping the simulation and reporting from the battle.
=end
class BattleStepper

  def initialize(battle,step_after)
    @battle = battle
    @step_after = step_after
    @current_time = 0
    @step = 1
  end

  def update(time_elapsed)
		if(@battle.army1.lives > 0 and @battle.army2.lives > 0)
			@current_time += time_elapsed
			if(@current_time > @step_after)
				@current_time = 0
        puts "Round: #{@step}"
        @battle.army1.units.each {|unit| unit.clear_last_action}
        @battle.army2.units.each {|unit| unit.clear_last_action}
				@battle.make_step
        @battle.info
				@step += 1
        return :step_made
			end
      return :step_not_made
		else
			#puts "Konec :)"
			#exit

		end
  end



end