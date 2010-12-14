# To change this template, choose Tools | Templates
# and open the template in the editor.

class AnimatedSprite < BasicSprite

  def initialize
    super()
    @animations = Hash.new
    @animation_time = 0
    @current_animation = Hash.new
    setup_animation
  end

  def update(dt)
    super()
    update_animation(dt)
  end

  private

  def add_animation(name,period,repeat = true,frames=@number_of_frames)
    @animations[name] = {"frames"=>frames,"period"=>period,"repeat"=>repeat,"y"=>@animations.count}
  end

  def set_animation(name)
    @current_animation = @animation[name]
    @current_animation['frame_length'] = @current_animation['period']/@current_animation['frames']
    @current_animation['frame'] = 1
  end

  def number_of_frames=(number_of_frames)
    @number_of_frames = number_of_frames
  end

  def number_of_frames
    return @number_of_frames
  end

  def setup_animation
    raise "Setup animation is not implemented!"
  end

  def frame_size()
    return [@image.size[0]/number_of_frames,@image.size[1]/@animations.count]
  end

  def current_clip_rect()
    return Rubygame::Rect.new(frame_size[0]*@current_animation['frame'],frame_size[1]*@current_animation['y'],frame_size[0],frame_size[1])
  end

  def update_animation(dt)
    ca = @current_animation
    @animation_time += dt
    if(@animation_time >= ca['frame_length'])
      (ca['frame'] < ca['frames'])? ca['frame'] += 1 : ca['frame'] = 1
      @animation_time -= ca['frame_length']
      @image.clip = current_clip_rect
    end
  end


  

end