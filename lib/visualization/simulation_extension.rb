=begin
PES-XA05-CSV Combat simulation visualization
Author: Vratislav Kalenda <v.kalenda+csv@gmail.com> (C) 2010

Necessary non intrusive extensions to the original BattleProgram.
=end
class BattleProgram
  def army1
    return @army1
  end
  def army2
    return @army2
  end
  def make_step
    @army1.attack(@army2)
    @army2.attack(@army1)
    @day += 1
    #info
  end

end