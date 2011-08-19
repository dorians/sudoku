# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'sudoku_solver'

class SudokuSolverTest < Test::Unit::TestCase

  def test_foo
    data = open($:.first + '/../test/inputs/001').read
    sudoku = Sudoku.new(data)
		#solver = SudokuSolver.new(sudoku)

    # assert_equal("foo", bar)
  end

end
