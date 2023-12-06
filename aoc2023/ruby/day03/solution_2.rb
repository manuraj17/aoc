# input =
# '''467..114..
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58.
# ..592.....
# ......755.
# ...$.*....
# .664.598..'''

input = File.read('input.txt')
lines = input.split("\n")

def generate_positions(x, y)
  [
    [x + 1, y],
    [x + 1, y + 1],
    [x + 1, y - 1],

    [x - 1, y],
    [x - 1, y + 1],
    [x - 1, y - 1],

    [x, y + 1],
    [x, y - 1]
  ]
end

re = /(\d+)/
result = []

matrix = lines.map { |l| l.split('') }

gear_positions = []

matrix.each_with_index do |row, x|
  row.each_with_index do |_cell, y|
    gear_positions << [x, y] if matrix[x][y] == '*'
  end
end

match_positions = []

lines.each_with_index do |line, index|
  line.enum_for(:scan, re).map do
    p = [
      index,
      Regexp.last_match.begin(0),
      Regexp.last_match[1].length,
      (Regexp.last_match.begin(0) + Regexp.last_match[1].length - 1),
      Regexp.last_match[1]
    ]

    match_positions << p
 end
end

def check(gear_position, match_positions)
  stack = []

  nearby = generate_positions(gear_position[0], gear_position[1])

  match_positions.each do |line, start_pos, _length, end_pos, match|
    (start_pos..end_pos).each do |i|
      if nearby.include?([line, i])
        stack << match.to_i
        break
      end
    end

   break if stack.length == 2
  end

  stack.length == 2 ? stack[0] * stack[1] : nil
end

gear_positions.each do |pos|
  result << check(pos, match_positions)
end

pp result.compact.reduce(&:+)
