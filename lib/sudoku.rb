require 'sudoku_item.rb'

class Sudoku

  include Enumerable

  def initialize data
    # set up data container (9x9 array)
    @data = Array.new(9) { Array.new(9) }

    # convert insert data into one-dimensional array
    data = data.scan(/\d| /)

    if data.size == 81
      # split array into 9-elements arrays
      data.each_index do |i|
        @data[i/9][i%9] = SudokuItem.new(self, data.at(i))
      end
    end
  end

  def clone
    Sudoku.new self.to_s
  end

  def at x, y
    @data.at(y).at(x)
  end

  def set x, y, value
    at(x, y).set(value)
  end

  def count_set
    count {|item| item.set?}
  end

  def groups
    boxes + horizontals + verticals
  end

  def boxes
    (group_by {|item| (item.x / 3).to_s + (item.y / 3).to_s }).values
  end

  def horizontals
    @data
  end

  def verticals
    @data.transpose
  end

  def solved?
    all? {|item| item.set?}
  end

  def each
    @data.each {|row| row.each {|item| yield item }}
  end

  def each_with_position
    @data.each_with_index {|row, y| row.each_with_index {|item, x| yield item, x, y}}
  end

  def correct?
    groups.each do |group|
      group = group.map {|item| item.to_i }
      return false unless group.uniq == group
    end
    true
  end

  def to_s
    # output schemas
    break_line = '+---+---+---+'
    data_line = "|%s%s%s|%s%s%s|%s%s%s|"

    # initialize the output variable as an array
    result = [break_line]

    @data.each_with_index do |row, i|
      # add formated data line to output variable
      result.push sprintf(data_line, *row)

      # add a break line to the output variable if nedded
      result.push break_line if (i.succ % 3).zero?
    end

    # return output variable with EOL symbol between each element
    result.join("\n")
  end

end