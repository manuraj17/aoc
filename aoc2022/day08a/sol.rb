# lines = File.readlines("inp2.txt")
lines = File.readlines("input.txt")

# Forest
# y  line
# y
# y
# x x x

# row
# row
# row
# column column column

max_row = lines.length - 1

max_column = (lines[0].strip.split('').length) - 1

forest = []
lines.length.times do |i|
  forest << lines[i].strip.split('')
end

# Everything on the edge is visible by default
def on_edge?(pos_row, pos_column, max_row, max_column)
  return true if pos_row.zero? ||
                 pos_column.zero? ||
                 pos_row == max_row ||
                 pos_column == max_column

  false
end

def tree_visible_from_left?(tree_height, pos_row, pos_column, grid)
  (0...pos_column).each do |pos|
    return false if tree_height <= grid[pos_row][pos]
  end

  true
end

def tree_visible_from_right?(tree_height, pos_row, pos_column, max_column, grid)
  (pos_column + 1).upto(max_column) do |pos|
    return false if tree_height <= grid[pos_row][pos]
  end

  true
end

def tree_visible_from_top?(tree_height, pos_row, pos_column, grid)
  (0...pos_row).each do |pos|
    return false if tree_height <= grid[pos][pos_column]
  end

  true
end

def tree_visible_from_bottom?(tree_height, pos_row, pos_column, max_row, grid)
  (pos_row + 1).upto(max_row) do |pos|
    return false if tree_height <= grid[pos][pos_column]
  end

  true
end

def is_tree_visible?(tree_height, pos_row, pos_column, max_row, max_column, grid)
  return true if on_edge?(pos_column, pos_row, max_column, max_row)

  tree_visible_from_top?(tree_height, pos_row, pos_column, grid) ||
    tree_visible_from_left?(tree_height, pos_row, pos_column, grid) ||
    tree_visible_from_right?(tree_height, pos_row, pos_column, max_column, grid) ||
    tree_visible_from_bottom?(tree_height, pos_row, pos_column, max_row, grid)
end

visible_trees = []
forest.each_with_index do |row, row_index|
  row.each_with_index do |tree_height, column_index|
    if is_tree_visible?(tree_height, row_index, column_index, max_row, max_column, forest)
      visible_trees << [row_index, column_index, tree_height]
    end
  end
end

puts
puts visible_trees.count
