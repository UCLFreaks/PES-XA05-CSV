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



