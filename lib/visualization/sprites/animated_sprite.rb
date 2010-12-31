=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Generic animated sprite.
=end
class AnimatedSprite < BasicSprite

  def initialize
    super()
    @animations = Hash.new
    @animation_time = 0
    @current_animation = Hash.new
    @spritesheet = get_spritesheet
    setup_animation
    @image = Rubygame::Surface.new(frame_size,@spritesheet.depth,@spritesheet.flags)
    @image = @image.to_display_alpha
    @should_redraw = true
    @final_frame = nil
    @image = get_current_frame_image
    
  end

  def update(dt)
    update_animation(dt)
  end


  def draw(to_surface)
    image = get_current_frame_image
    image.blit(to_surface, [@position[0].round,@position[1].round])
  end

  def current_animation
    return @current_animation
  end


  private

  def get_current_frame_image
    if(@should_redraw)
      @spritesheet.set_alpha 0,0
      #blitted.set_colorkey([255,255,255,0])
      @spritesheet.blit(@image,[0,0],current_clip_rect)
      @spritesheet.set_alpha 255
      @should_redraw = false
    end
    return @image
  end


  def add_animation(name,period,repeat = true,frames=number_of_frames)
    @animations[name] = {"name"=>name,"frames"=>frames,"period"=>period,"repeat"=>repeat,"y"=>@animations.count}
  end

  def should_redraw?
    return @should_redraw
  end

  def set_animation(name,current_frame=1)
    @current_animation = @animations[name]
    @current_animation['frame_length'] = @current_animation['period']/@current_animation['frames']
    @current_animation['frame'] = current_frame
    if(current_frame > 1)
      @final_frame = current_frame
    else
      @final_frame = @current_animation['frames']
    end  
    @should_redraw = true
  end

  def number_of_frames=(number_of_frames)
    @number_of_frames = number_of_frames
  end

  def number_of_frames
    return @number_of_frames
  end

  def setup_animation
    raise "Setup animation is not implemented for #{self.class}!"
  end

  def get_spritesheet
    raise "get_spritesheet is not implemented for #{self.class}!"
  end

  def frame_size()
    return [@spritesheet.size[0]/number_of_frames,@spritesheet.size[1]/@animations.count]
  end

  def current_clip_rect()
    return Rubygame::Rect.new(frame_size[0]*(@current_animation['frame']-1),frame_size[1]*@current_animation['y'],frame_size[0],frame_size[1])
  end

  def final_frame?
    if(@current_animation['repeat'] == false)
      return true if(@current_animation['frame'] == @final_frame)
    end
    return false
  end

  def update_animation(dt)
    if not final_frame?()
      ca = @current_animation
      @animation_time += dt
      if(@animation_time >= ca['frame_length'])
        (ca['frame'] < ca['frames'])? ca['frame'] += 1 : ca['frame'] = 1
        @animation_time -= ca['frame_length']
        @should_redraw = true
      else

      end
    end
  end




  

end