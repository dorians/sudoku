require 'sudoku'

class SudokuResult

  include Enumerable
  
  attr_accessor :depth

  def initialize depth
    @results = []
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
  end

  protected

  attr_reader :results

end