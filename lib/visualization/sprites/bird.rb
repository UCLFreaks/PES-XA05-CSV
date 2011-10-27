=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Status arrow showing that the visualization is running.
I will probably remove it soon.
=end
class Bird < AnimatedSprite
  include LinearMovement
  def initialize(sky_width,sky_height)
    super()
    @position = [0,0]
    @velocity = [20,0.0]
    @sky_width = sky_width
    @sky_height = sky_height
    @since_fly_height_change = 0
    @target_fly_height = 0
  
  end

 def should_move?
    true
  end

  def update(dt)
    @since_fly_height_change += dt
    if(@since_fly_height_change > 5000)
      @since_fly_height_change = 0
      @target_fly_height = rand(@sky_height - self.sprite_size[1])
      puts "Changing fly height to #{@target_fly_height}"
      if @target_fly_height > position_y
        @velocity = [20,10];
      else
        @velocity = [20,-10];
      end
      
    end
    move(dt)
    #//puts "Target FH: #{@target_fly_height} position y: #{position_y}"
    #puts "laste Y: #{@laste_y}"
    if((@velocity[1] > 0 and position_y > @target_fly_height) or (@velocity[1] < 0 and position_y < @target_fly_height))
      puts "Jsem tu"
      position_y = @target_fly_height
      @velocity = [20,0]
    end

    super(dt)

    
  end

  private
  def setup_animation
    @number_of_frames = 8
    add_animation(:run, 500)
    set_animation(:run)
    
  end

  def get_spritesheet
    return get_image("bird.png")
  end

 



end