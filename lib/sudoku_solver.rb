require 'sudoku'

class SudokuSolver

  def initialize sudoku
    @sudoku = sudoku
    set_capabilities
  end

  def solve
    while (solve_method1 || solve_method2) do
      raise "Sudoku can't be solved" unless correct?
    end

    unless @sudoku.solved?
      item = @sudoku.find {|item| not item.set?}
      results = []

      @capabilities[item.y][item.x].each do |capability|
        begin
          sudoku = @sudoku.clone
          sudoku.set item.x, item.y, capability
          solver = SudokuSolver.new sudoku
          results.concat solver.solve
        rescue
        end
      end

      return results
    else
      return [@sudoku]
    end
  end

  def sudoku
    @sudoku
  end

  private

  def correct?
    @sudoku.each do |item|
      return false if (not item.set?) && @capabilities[item.y][item.x].empty?
    end
    true
  end

  def solve_method1
    @capabilities.each_with_index do |row, y|
      row.each_with_index do |element, x|
        if element.size == 1
          set x, y, element.first
          return true
        end
      end
    end
    return false
  end

  def solve_method2
    @sudoku.groups.each do |group|
      set_digits = (group.find_all {|item| item.set?}).map {|item| item.to_i}
      capabilities_digits = (1..9).to_a - set_digits

      capabilities_digits.each do |digit|
        capabilities_items = group.find_all do |item|
          @capabilities[item.y][item.x].include? digit
        end
        if capabilities_items.size == 1
          set capabilities_items.first.x, capabilities_items.first.y, digit 
          return true
        end
      end
    end
    return false
  end

  def set x, y, value
    @sudoku.set x, y, value

    @capabilities[y][x].clear
      @sudoku.at(x, y).related.each do |item|
        @capabilities[item.y][item.x] -= [value]
      end
    end

    def set_capabilities
      @capabilities = Array.new(9) {Array.new(9) { (1..9).to_a }}

      @sudoku.each do |item|
        # if item is set, then capabilities should be empty
        @capabilities[item.y][item.x].clear if item.set?

        # get related as array of integers
        related = item.related.collect {|element| element.to_i}
        related = (related.find_all {|element| not element.zero?}).uniq

        # any digit from related shouldn't be one of capabilities
        @capabilities[item.y][item.x] -= related
      end
    end
 
end