# To change this template, choose Tools | Templates
# and open the template in the editor.
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