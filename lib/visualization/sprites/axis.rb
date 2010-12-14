# To change this template, choose Tools | Templates
# and open the template in the editor.

class Axis < BasicSprite


  def initialize(visualizer)
    @visualizer = visualizer
    @image = generate_axis(visualizer.world_size,visualizer.range)
    @position = [0,visualizer.world_size[1]-visualizer.world_size[1]/4]
  end
  private
  def generate_axis(size,range)
    surface = Rubygame::Surface.new([size[0],size[1]/5],0)
    surface.colorkey = [0,0,255]
    surface.fill([0,0,255])

    surface.draw_box_s([0+@visualizer.margin,5], [size[0]-@visualizer.margin,10], [0,0,0])
    puts "number of ticks: #{@visualizer.number_of_ticks}"
    (@visualizer.number_of_ticks() + 1).times do |sim_tick|
      sim_x = @visualizer.range[0] + sim_tick
      x = @visualizer.sim_to_vis_x(sim_x)
      puts "#{sim_x} to #{x}"
      surface.draw_box_s([x-1,0], [x+1,20], [255,0,0])
    end
    return surface
  end


end