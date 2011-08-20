require 'sudoku'

class SudokuResult

  include Enumerable

  def initialize
    @results = []
  end

  def each
    @results.each
  end

  def << sudoku
    @results << sudoku
    self
  end

  def set_as_unsolved
    
  end

  def get
    @results.first unless @results.empty?
  end

  def correct?
    @results.count == 1
  end

  def many_solutions?
    @results.count > 1
  end

  def to_s
    get.to_s
  end

end