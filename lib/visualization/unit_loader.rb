=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Loads units from YAML file.
=end
require 'yaml'
class UnitLoader
  def UnitLoader.units_from_yaml(yaml_file_name)
    units_yaml = YAML.load_file(yaml_file_name);
    units = []
      units_yaml.each do |key,val|
          units << Object::const_get(key).new(val)
      end
    return units;
  end
end