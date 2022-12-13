require 'set'

# lines = File.readlines("inp2.txt")
lines = File.readlines("input.txt")

lines = lines.map{ |l| l.strip }

# lines.each do |line|
#   pp line.strip
# end

Point = Struct.new(:x, :y)
start = Point.new(0,0)

def move_up(start, steps)
  positions = []

  # positions << start.clone

  (steps - 1).times do |x| 
    start.x = start.x + 1

    next if x == steps - 2

    positions << start
  end

  [start, positions]
end

def move_left(start, steps)
  positions = []

  # positions << start.clone

  (steps - 1).times do |x|
    start.y -= 1

    next if x == (steps - 2)

    positions << start.clone
  end

  [start, positions]
end

def move_down(start, steps)
  positions = []

  # positions << start.clone

  (steps - 1).times do |x|
    start.x = start.x - 1

    next if x == (steps - 2)

    positions << start.clone
  end

  [start, positions]
end

def move_right(start, steps)
  positions = []

  # positions << start.clone

  (steps - 1).times do |x|
    start.y = start.y + 1

    break if x == (steps - 2)

    positions << start.clone
  end

  [start, positions]
end

# puts "Tests"
# puts "Moving up"
# start_point = Point.new(0,0)
# [end_point, positions] = Point.new(4,0)
# puts end_point == move_up(start, 4)
#
# puts "Moving left"
# start_point = Point.new(5,5)
# [end_point, positions] = Point.new(5,1)
# puts end_point == move_left(start_point, 4)
#
# puts "Moving down"
# start_point = Point.new(5,5)
# end_point= Point.new(9,5)
# [end_point, positions] = move_down(start_point, 4)
# puts end_point == 
#
#
# puts "Moving right"
# start_point = Point.new(5,5)
# [end_point, positions] = Point.new(5,9)
# puts end_point == move_right(start_point, 4)

def make_move(start_point, line)
  tokens = line.split(' ')


  direction = tokens[0]
  steps = tokens[1].to_i + 1

  pp line
  pp "START: #{start_point}"
  
  end_point = nil
  positions = []

  case tokens[0]
  when "L"
    end_point, positions = move_left(start_point, steps)
  when "R"
    end_point, positions = move_right(start_point, steps)
  when "U"
    end_point, positions = move_up(start_point, steps) 
  when "D"
    end_point, positions = move_down(start_point, steps)
  end

  pp "END: #{end_point}"

  [end_point, positions]
end

start_point = Point.new(0,0)
head_point = Point.new(0,0)
tail_point = Point.new(0,0)

current_point = start_point

all_positions = []

all_positions << start_point.clone

lines.each do |line|
  current_point, positions = make_move(current_point, line)

  all_positions.concat(positions)
end

pp current_point
pp all_positions
pp all_positions.count

all_pos_extracted = []
all_positions.each do |pos|
  all_pos_extracted << [pos.x, pos.y]
end

pp all_pos_extracted

pp all_pos_extracted.to_set
pp all_pos_extracted.to_set.count
