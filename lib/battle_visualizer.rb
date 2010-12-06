# To change this template, choose Tools | Templates
# and open the template in the editor.
require "./axis.rb"

class BattleVisualizer
  attr_reader :battle,:range,:world_size,:axis,:margin
  def initialize(battle_program,world_size)
    @battle = battle_program
    @range = get_range
    @world_size = world_size
    @margin = world_size[0]/80
    @axis = Axis.new(self)
  end

  def sim_to_vis_x(sim_x)
    return @margin + (sim_x * tick_step_size).round
  end

  def tick_step_size()
    size_x = @world_size[0] - @margin * 2
    size_x/number_of_ticks.to_f
  end

  def number_of_ticks
    number_of_ticks = @range[1]-@range[0]
    return number_of_ticks
  end


  def update(miliseconds_elasped)

  end

  def draw(to_surface)
    @axis.draw(to_surface)
    
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