# To change this template, choose Tools | Templates
# and open the template in the editor.
require "./rubygame/lib/rubygame.rb"
require "./background.rb"
require "./basic_sprite.rb"
require "./unit.rb"

require "./battle_stepper.rb"
require "./battle_visualizer.rb"

class Visualization
	def initialize(battle)
    @battle_stepper = BattleStepper.new(battle,5000)

		Rubygame.init
    maximum_resolution = Rubygame::Screen.get_resolution
    @resolution = [maximum_resolution[0] - 60, 200]
    puts "This display can manage at least " + maximum_resolution.join("x")
    @battle_visualizer = BattleVisualizer.new(battle,@resolution)
    @screen = Rubygame::Screen.new [@resolution[0], @resolution[1]], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
		@screen.title = "PES XA05 VISUALIZATION!"

		@queue = Rubygame::EventQueue.new
		@clock = Rubygame::Clock.new
		@clock.target_framerate = 30
    @clock.enable_tick_events

    @background = Background.new(@resolution)
    @unit = Unit.new(nil)


	end
 
	def run
		loop do
      time_elapsed = @clock.tick.milliseconds()
			update(time_elapsed)
			draw
		
		end
	end

	def update(time_elapsed)

    @queue.each do |ev|
			case ev
				when Rubygame::QuitEvent
					Rubygame.quit
					exit
			end
		end
    @battle_stepper.update(time_elapsed)
    @battle_visualizer.update(time_elapsed)
    @unit.update(time_elapsed)
	end

	def draw
    @background.draw(@screen)
    @battle_visualizer.draw(@screen)
		@unit.draw(@screen)
    @screen.flip
    
	end
end