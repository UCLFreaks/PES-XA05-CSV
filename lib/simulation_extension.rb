# To change this template, choose Tools | Templates
# and open the template in the editor.

class BattleProgram
  def army1
    return @army1
  end
  def army2
    return @army2
  end
  def make_step
    @army1.attack(@army1)
    @army2.attack(@army1)
    @day += 1
    info
  end

end