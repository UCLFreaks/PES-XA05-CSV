=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

This class visualizes the actions of armies.
=end
require "./visualization/sprites/axis.rb"
require "./visualization/sprites/unit_sprite.rb"
require "./visualization/sprites/soldier_sprite.rb"
require "./visualization/sprites/sniper_sprite.rb"
require "./visualization/sprites/tank_sprite.rb"
require "set"

class BattleVisualizer
  attr_reader :battle,:range,:world_size,:axis,:margin,:sky_height
  attr_accessor :busy_units,:unit_sprites
  def initialize(battle_program,world_size,sky_height)
    @busy_units = Set.new
    @battle = battle_program
    @range = get_range
    @world_size = world_size
    @sky_height = sky_height
    @margin = world_size[0]/80
    @axis = Axis.new(self)
    @unit_sprites = SpriteGroup.new
    create_sprites_for_units(@battle.army1.units,:team1)
    create_sprites_for_units(@battle.army2.units,:team2)
    @unit_sprites.sort_sprites
    @report_busy_after = 30000
    @time_since_last_report = 0
  end

  def create_sprites_for_units(units,team)
    sprites = @unit_sprites
    units.each do |unit|
      case unit
      when Soldier
        sprites << SoldierSprite.new(unit, team, self)
      when Sniper
        sprites << SniperSprite.new(unit, team, self)
      when Tank
        sprites << TankSprite.new(unit, team, self)
      else
        sprites << SoldierSprite.new(unit, team, self)
      end
      
    end
    return sprites
  end




  def sim_to_vis_x(sim_x)
    return @margin + ((sim_x - @range[0]) * tick_step_size).round
  end

  def tick_step_size()
    size_x = @world_size[0] - @margin * 2
    size_x/number_of_ticks.to_f
  end

  def number_of_ticks
    number_of_ticks = @range[1]-@range[0]
    return number_of_ticks
  end


  def update(dt)
    @unit_sprites.update(dt)
    @time_since_last_report += dt
    if(@time_since_last_report >= @report_busy_after)
      @time_since_last_report -= @report_busy_after
      puts "Busy units:"
      @busy_units.each do |sprite|
        puts "#{sprite.unit.class} state:#{sprite.state} - BusyReason:#{sprite.busy_reason} (#{sprite.object_id} #{sprite.unit.last_action})"
      end
    end
  end

  def draw(to_surface)
    #@axis.draw(to_surface)
    @unit_sprites.draw(to_surface)
  end
  
  def animation_step_finnished?
    return @busy_units.empty?
  end
  
  def get_unit_sprite(unit)
    return @unit_sprites.find{ |unit_sprite| unit_sprite.unit == unit  }
  end

  private
  def get_range
    all_units = @battle.army1.units + @battle.army2.units
    unit_positions = all_units.map{|unit| unit.position}
    range = [unit_positions.min, unit_positions.max]
    puts "range is #{range}"
    return range
  end




end