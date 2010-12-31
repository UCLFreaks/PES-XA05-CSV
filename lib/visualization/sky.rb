=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Cloud simulation.
=end
require "./visualization/sprites/cloud.rb"
class Sky

  def initialize(sky_width,sky_height)
    @height = sky_height
    @sky_sprites = SpriteGroup.new

    rand(20).times do
      @sky_sprites << Cloud.new(sky_width,sky_height)
    end
  end

  def update(miliseconds_elapsed)
    @sky_sprites.update(miliseconds_elapsed)
  end

  def draw(to_screen)
    @sky_sprites.draw(to_screen)
  end


end