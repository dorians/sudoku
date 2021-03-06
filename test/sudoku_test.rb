$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'test/unit'
require 'sudoku'
require 'sudoku_solver'
require 'pp'

class SudokuTest < Test::Unit::TestCase

  def setup
    @data = open($:.first + '/../test/inputs/001').read
    @sudoku = Sudoku.new(@data)
  end

  def test_check_input_output
    assert_equal(@data, @sudoku.to_s)
  end

  def test_solved
    assert_equal(false, @sudoku.solved?)
  end

  def test_count
    assert_equal(24, @sudoku.count_set)
  end

  def test_boxes
    @sudoku.boxes.each do |box|
      box.each do |item|
        assert(box.first.same_box? item)
      end
    end
  end

  def test_position
    x, y = 0, 0

    @sudoku.each do |item|		
      assert_equal(x, item.x)
      assert_equal(y, item.y)

      y += 1 if x == 8
      x = x.succ % 9			
    end
  end

  def test_related
    test_data = [
      {
        "position" => [3,1],
        "related_in_box" => [5],
        "related_vertical" => [3,5],
        "related_horizontal" => [3,7],
        "related" => [3,5,7]
      },
      {
        "position" => [5,4],
        "related_in_box" => [3,5,9],
        "related_vertical" => [9],
        "related_horizontal" => [3,5,7],
        "related" => [3,5,7,9]
      },
      {
        "position" => [0,5],
        "related_in_box" => [5,9],
        "related_vertical" => [],
        "related_horizontal" => [1,9],
        "related" => [1,5,9]
      }
    ]

    test_data.each do |test_item|
      item = @sudoku.at(*test_item['position'])

      result = {}

      result['related_in_box'] = item.related_in_box
      result['related_vertical'] = item.related_vertical
      result['related_horizontal'] = item.related_horizontal
      result['related'] = item.related

      result.each_key do |key|
        result[key] = result[key].find_all {|item| item.set?}
        result[key] = result[key].map {|item| item.to_i}
        result[key] = result[key].uniq.sort
      end

      assert_equal(test_item['related_in_box'], result['related_in_box'])
      assert_equal(test_item['related_vertical'], result['related_vertical'])
      assert_equal(test_item['related_horizontal'], result['related_horizontal'])
      assert_equal(test_item['related'], result['related'])
    end
  end
  
  def test_set
    assert @sudoku.set(2, 1, 4)
    assert_nil @sudoku.set(2, 1, 6)
    assert_nil @sudoku.set(0, 0, 6)
    assert_nil @sudoku.set(0, 1, 6)
  end

  def test_solve
    (1..3).each do |i|
      data = open($:.first + '/../test/inputs/00' + i.to_s).read
      sudoku = Sudoku.new(data)
    
      solver = SudokuSolver.new sudoku
      result = solver.solve
      assert result.correct?
    end
  end

end
