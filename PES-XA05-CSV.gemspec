spec = Gem::Specification.new do |s|
  s.name = 'PES-XA05-CSV'
  s.version = '0.9.0'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'PES-XA05-CSV'
  s.description = s.summary
  s.author = 'Vratislav Kalenda'
  s.email = 'v.kalenda+CSV@gmail.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
  s.add_dependency('rubygame')
end