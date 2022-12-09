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

def tree_visible_from_left(tree_height, pos_row, pos_column, grid)
  count = 0

  (0...pos_column).to_a.reverse.each do |pos|
    count += 1
    break if tree_height <= grid[pos_row][pos]
  end

  count
end

def tree_visible_from_right(tree_height, pos_row, pos_column, max_column, grid)
  count = 0

  (pos_column + 1).upto(max_column) do |pos|
    count += 1
    break if tree_height <= grid[pos_row][pos]
  end

  count
end

def tree_visible_from_top(tree_height, pos_row, pos_column, grid)
  count = 0

  (0...pos_row).to_a.reverse.each do |pos|
    count += 1
    break if tree_height <= grid[pos][pos_column]
  end

  count
end

def tree_visible_from_bottom(tree_height, pos_row, pos_column, max_row, grid)
  count = 0

  (pos_row + 1).upto(max_row) do |pos|
    count += 1
    break if tree_height <= grid[pos][pos_column]
  end

  count
end

def tree_visible(tree_height, pos_row, pos_column, max_row, max_column, grid)
  tree_visible_from_top(tree_height, pos_row, pos_column, grid) *
    tree_visible_from_left(tree_height, pos_row, pos_column, grid) *
    tree_visible_from_right(tree_height, pos_row, pos_column, max_column, grid) *
    tree_visible_from_bottom(tree_height, pos_row, pos_column, max_row, grid)
end

visible_trees = []
forest.each_with_index do |row, row_index|
  row.each_with_index do |tree_height, column_index|
    visible_trees << tree_visible(tree_height, row_index, column_index, max_row, max_column, forest)
  end
end

puts visible_trees.max
