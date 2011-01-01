=begin
PES-XA05 Strategy
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010
Written in Ruby 1.9.2-p0 (Seems to work in Ruby 1.8 and JRuby 1.5)

Abstract superclass for unit tacticts.
=end
module GeneralVK
  class GenericTactic
    def make_move(unit,strategy)
      raise "Abstract method make_move is not implemented for Class #{self.class}"
    end
    private
    def target_priority_by_type(enemy_unit)
      return 1
    end
  end
end



