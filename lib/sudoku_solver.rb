require 'sudoku'
require 'sudoku_result'

class SudokuSolver

  def initialize sudoku
    @sudoku = sudoku.clone
    initialize_capabilities
  end

  def clone
    solver = super

    solver.sudoku = @sudoku.clone
    solver.capabilities = Marshal.load(Marshal.dump(@capabilities))

    solver
  end

  def solve
    result = SudokuResult.new

    begin
      return (result << @sudoku) if try_solve_without_random
    rescue
      return result
    end

    unless @sudoku.solved?
      sudoku_posabilities = [self]

      until sudoku_posabilities.empty?
        current_solver = sudoku_posabilities.pop

        item = current_solver.sudoku.find {|i| not i.set? }

        current_solver.capabilities[item.y][item.x].each do |capability|
          solver = current_solver.clone
          solver.set item.x, item.y, capability

          begin
            if solver.try_solve_without_random
              result << solver.sudoku
            else
              (sudoku_posabilities << solver) if solver.correct?
            end
          rescue
          end
        end
      end
    end
    
    result
  end

  protected
  
  attr_accessor :sudoku, :capabilities

  def try_solve_without_random
    while (solve_method1 || solve_method2) do
      raise 'Sudoku can\'t be solved' unless correct?
    end
    @sudoku.solved?
  end

  def set x, y, value
    # delegate a task
    if @sudoku.set x, y, value
      # item was set, so clear capabilities
      @capabilities[y][x].clear

      # remove set value from capabilities of related items
      @sudoku.at(x, y).related.each do |item|
        @capabilities[item.y][item.x] -= [value]
      end
    end
  end

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
          return set x, y, element.first
        end
      end
    end
    false
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
          return set capabilities_items.first.x, capabilities_items.first.y, digit
        end
      end
    end
    false
  end

  def initialize_capabilities
    # each item of sudoku can be any digit from 1 to 9 at the beginning
    @capabilities = Array.new(9) {Array.new(9) { (1..9).to_a }}

    @sudoku.each do |item|
      # if item is set, then capabilities should be empty
      @capabilities[item.y][item.x].clear if item.set?

      # get related as array of integers
      related = item.related.collect {|element| element.to_i}

      # any digit from related shouldn't be one of capabilities
      @capabilities[item.y][item.x] -= related
    end
  end

end