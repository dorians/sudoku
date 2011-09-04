$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sudoku'

class SudokuResult

  include Enumerable

  attr_reader :depth, :forks

  def initialize depth
    @results = []
    @depth = depth
    @forks = 0
  end

  def each &block
    @results.each &block
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
    other.each do |sudoku|
      self.<< sudoku
    end
    @depth = [@depth, other.depth].max
    @forks += other.forks.succ
  end

end