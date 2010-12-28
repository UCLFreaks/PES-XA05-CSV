# To change this template, choose Tools | Templates
# and open the template in the editor.

class Vector < Array
  def Vector.from_points(start_point,end_point)
    vector = Vector.new
    vector << end_point[0] - start_point[0]
    vector << end_point[1] - start_point[1]
    return vector
  end

  def magnitude
    return Math.sqrt(x**2 + y**2)
  end

  def normalize
    m = magnitude
    normalized = Vector.new
    normalized << x/m.to_f
    normalized << y/m.to_f
    return normalized
  end

  def normalize!
    norm = normalize
    self.x = norm.x
    self.y = norm.y
    return self
  end

  def length
    return magnitude
  end


  def x
    return self[0]
  end

  def y
    return self[1]
  end

  def x=(x_to_set)
    self[0] = x_to_set
  end

  def y=(y_to_set)
    self[1] = y_to_set
  end
end