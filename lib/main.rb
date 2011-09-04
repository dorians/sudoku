$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sudoku_solver'

data = open('../test/inputs/001').read
sudoku = Sudoku.new(data)
solver = SudokuSolver.new sudoku
result = solver.solve

if result.correct?
  puts 'Your sudoku has been happily solved. Here it is:'
  puts result
else
  puts 'Oh no! Something went wrong'
end