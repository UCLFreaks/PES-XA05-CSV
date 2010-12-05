# To change this template, choose Tools | Templates
# and open the template in the editor.

puts "Hello World"
require "./rubygame/lib/rubygame.rb"


Rubygame.init
screen = Rubygame::Screen.new [1000, 200]
sleep(10)
Rubygame.quit  