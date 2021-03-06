=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Main class responsible for starting and maintaining the visualization.
=end
require "rubygems"
if(RUBY_PLATFORM == "i386-mingw32" and RUBY_VERSION =~ /^1\.8\../ )
  begin
    puts "Loading ffi gem 0.6.3. for compatibility."
    gem 'ffi', '= 0.6.3'
  rescue Exception=>ex
    puts "Failed to load ffi gem 0.6.3. gem. Try running install.rb to install it."
  end
end
begin
  require "rubygame"
rescue Exception=>ex
  puts "Failed to load Rubygame gem. Run install.rb to install it."
  puts "(#{ex.message})"
  exit
end
require "./visualization/vector.rb"
require "./visualization/background.rb"
require "./visualization/sky.rb"
require "./visualization/audio_manager.rb"
require "./visualization/sprites/sprite_group.rb"
require "./visualization/sprites/basic_sprite.rb"
require "./visualization/sprites/animated_sprite.rb"
require "./visualization/sprites/status.rb"

require "./visualization/battle_stepper.rb"
require "./visualization/battle_visualizer.rb"

class Visualization
  DEBUG_MODE = false
  attr_reader :sky_height
	def Visualization.get_resolution
    return @@resolution
  end
  def Visualization.debug?
    return DEBUG_MODE
  end
  def initialize(battle)
    @battle_stepper = BattleStepper.new(battle,100)

		Rubygame.init
    maximum_resolution = Rubygame::Screen.get_resolution
    @@resolution = [maximum_resolution[0] - 60, 200]
    puts "This display can manage at least " + maximum_resolution.join("x")
    @screen = Rubygame::Screen.new [@@resolution[0], @@resolution[1]], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
		@screen.title = "PES XA05 VISUALIZATION!"

    @sky_height = @@resolution[1]/2
    @sky = Sky.new(@@resolution[0],sky_height)
    @battle_visualizer = BattleVisualizer.new(battle,@@resolution,@sky_height)

		@queue = Rubygame::EventQueue.new
		@clock = Rubygame::Clock.new
		@clock.target_framerate = 60
    @clock.calibrate
    @clock.enable_tick_events
    
    @background = Background.new(@@resolution,@sky_height)
    @status  = Status.new
    begin
      music = AudioManager.get_music("ambience.mp3")
      music.volume = 0.34
      music.play
    rescue Exception=>ex
      puts "Failed to load music #{ex.message}"
    end

	end
 
	def run
		loop do
      time_elapsed = @clock.tick.milliseconds()
			update(time_elapsed)
			draw
		
		end
	end
#this code is really spagetti one. I will make it better. I promise.
	def update(td)

    @queue.each do |ev|
			case ev
				when Rubygame::QuitEvent
					Rubygame.quit
					exit
			end
		end
    if @battle_visualizer.animation_step_finnished?
      result = @battle_stepper.update(td)
      if(result == :step_made)
        @battle_visualizer.unit_sprites.each{|sprite| sprite.last_action_changed}
      end
    end
    @sky.update(td)
    @battle_visualizer.update(td)
    #@status.update(td)
	end

	def draw
    @background.draw(@screen)
    @sky.draw(@screen)
    @battle_visualizer.draw(@screen)
    #@status.draw(@screen)
    @screen.flip
    
	end
end
