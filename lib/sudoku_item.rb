class SudokuItem

  def initialize sudoku, value
    @sudoku = sudoku
    set value
  end

  def x
    position.first
  end

  def y
    position.last
  end

  def set value
    @value = value.to_i.zero? && value.to_i.to_s.size == 1 ? nil : value.to_i
  end

  def position
    @position ||=
      @sudoku.each_with_position do |element, x, y|
        return (@position = x.to_i, y.to_i) if element == self
    end
  end

  def related
    (related_in_box + related_vertical + related_horizontal).uniq
  end

  def related_in_box
    @sudoku.find_all {|item| (same_box? item) && (item != self)}
  end

  def related_vertical
    @sudoku.find_all {|item| (item.x == self.x) && (item != self)}
  end

  def related_horizontal
    @sudoku.find_all {|item| (item.y == self.y) && (item != self)}
  end

  def same_box? item
    (self.x / 3) == (item.x / 3) && (self.y / 3) == (item.y / 3)
  end

  def set?
    not @value.nil?
  end

  def to_i
    @value.to_i
  end

  def to_s
    set? ? @value.to_s : ' '
  end

end