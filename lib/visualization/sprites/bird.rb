=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Bird flying in the sky. A nice little touch to the scene ;)
=end
class Bird < AnimatedSprite
  include LinearMovement
  def initialize(sky_width,sky_height)
    super()
    @position = [-sprite_size[0]-rand(400),rand(sky_height)]
    @fly_direction = 1
    @velocity = [@fly_direction * 20,0.0]
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
      if @target_fly_height > position_y
        @velocity = [@fly_direction * 20,10];
        set_animation(:fly,3)
      else
        @velocity = [@fly_direction * 20,-10];
        set_animation(:fly)
      end
      
    end
    move(dt)
    if((@velocity[1] > 0 and position_y > @target_fly_height) or (@velocity[1] < 0 and position_y < @target_fly_height))
      position_y = @target_fly_height
      @velocity = [@fly_direction * 20,0]
      set_animation(:fly)
    end
    
    if(self.position_x > @sky_width)
      @fly_direction = -1
      @image = @image.flip(true, false)
      @velocity = [@fly_direction * 20,0]
    elsif(self.position_x + self.sprite_size[0] < 0)
      @fly_direction = 1
      @image = @image.flip(true, false)
      @velocity = [@fly_direction * 20,0]      
    end
    


    super(dt)

    
  end

  private
  def setup_animation
    @number_of_frames = 8
    add_animation(:fly, 500)
    set_animation(:fly)
    
  end

  def get_spritesheet
    return get_image("bird.png")
  end

   def get_current_frame_image
    should_rdraw = should_redraw?
    super
    @image = @image.flip(true, false) if should_rdraw and @fly_direction == -1
    return @image
  end



end