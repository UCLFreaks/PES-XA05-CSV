# To change this template, choose Tools | Templates
# and open the template in the editor.
require "./visualization/rubygame/lib/rubygame.rb"
module Visualization
require "./visualization/background.rb"
require "./visualization/sprites/sprite_group.rb"
require "./visualization/sprites/basic_sprite.rb"



require "./visualization/battle_stepper.rb"
require "./visualization/battle_visualizer.rb"

class Visualization
  attr_reader :sky_height
	def initialize(battle)
    @battle_stepper = BattleStepper.new(battle,1000)

		Rubygame.init
    maximum_resolution = Rubygame::Screen.get_resolution
    @resolution = [maximum_resolution[0] - 60, 200]
    puts "This display can manage at least " + maximum_resolution.join("x")
    @sky_height = @resolution[1]/2
    @battle_visualizer = BattleVisualizer.new(battle,@resolution,@sky_height)
    @screen = Rubygame::Screen.new [@resolution[0], @resolution[1]], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
		@screen.title = "PES XA05 VISUALIZATION!"

		@queue = Rubygame::EventQueue.new
		@clock = Rubygame::Clock.new
		@clock.target_framerate = 30
    @clock.enable_tick_events
    
    @background = Background.new(@resolution,@sky_height)


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
	end

	def draw
    @background.draw(@screen)
    @battle_visualizer.draw(@screen)
    @screen.flip
    
	end
end
end