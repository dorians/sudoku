require 'sudoku_solver'

data = open('../test/inputs/001').read
sudoku = Sudoku.new(data)
solver = SudokuSolver.new sudoku
puts solver.solve