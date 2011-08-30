require 'sudoku'

class SudokuResult

  include Enumerable

  attr_reader :depth

  def initialize depth
    @results = []
    @depth = depth
  end

  def each
    @results.each
  end

  def << sudoku
    @results << sudoku
    self
  end

  def correct?
    @results.count == 1
  end

  def many_solutions?
    @results.count > 1
  end

  def to_s
    @results.empty? ? '' : @results.first.to_s
  end

  def merge other
    @results += other.results
    @depth = [@depth, other.depth].max
  end

  protected

  attr_reader :results

end