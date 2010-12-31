=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Installator. It attempts to install Rubygame gem if it is not already installed.
=end

require "rubygems"
require "rubygems/dependency_installer"

puts " ---------------------------------------------------------"
puts "|PES-XA05-CSV Combat simulation visualization instalation |"
puts " ---------------------------------------------------------"

puts "Looking for Rubygame gem..."
if Gem.available?("rubygame" )
  puts "Rubygame is already installed. Run main.rb"
else
  puts "Installing rubygame gem"
  installer = Gem::DependencyInstaller.new
  installer.install("rubygame", "2.6.4")
  puts "Instalation complete. Run main.rb"
end
