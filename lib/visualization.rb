# To change this template, choose Tools | Templates
# and open the template in the editor.
require "./rubygame/lib/rubygame.rb"
require "./background.rb"
require "./unit.rb"

class Visualization
	def initialize
		Rubygame.init
    maximum_resolution = Rubygame::Screen.get_resolution
    @resolution = [maximum_resolution[0] - 60, 200]
    puts "This display can manage at least " + maximum_resolution.join("x")
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
			update
			draw
			@clock.tick
		end
	end

	def update
		@queue.each do |ev|
			case ev
				when Rubygame::QuitEvent
					Rubygame.quit
					exit
			end
		end
	end

	def draw
    @background.draw(@screen)
		@unit.draw(@screen)
    @screen.flip
    
	end
end