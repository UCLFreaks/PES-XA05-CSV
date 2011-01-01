=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Installator. It attempts to install Rubygame gem if it is not already installed.
=end

require "rubygems"
require "rubygems/dependency_installer"
installer = Gem::DependencyInstaller.new
puts " ---------------------------------------------------------"
puts "|PES-XA05-CSV Combat simulation visualization instalation |"
puts " ---------------------------------------------------------"
puts "Ruby platform: " + RUBY_PLATFORM
puts "Ruby platform version: " + RUBY_VERSION
if(RUBY_PLATFORM == "i386-mingw32" and RUBY_VERSION =~ /^1\.8\../ )
  puts "ffi library version 0.6.3 is needed for compatibility reasons."
  if(Gem.available?('ffi', "= 0.6.3"))
    puts "ffi version 0.6.3. is already installed. proceeding..."
  else
    puts "ffi version 0.6.3. is not installed."
    puts "Installing ffi 0.6.3. gem"
    installer.install("ffi", "0.6.3")
  end
end
puts "Looking for Rubygame gem..."
if Gem.available?("rubygame" )
  puts "Rubygame is already installed. Run main.rb"
else
  puts "Installing rubygame gem"

  installer.install("rubygame", "2.6.4")
  puts "Instalation complete. Run main.rb"
end
