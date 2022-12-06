lines = File.readlines("input.txt")
# lines = File.readlines("inp2.txt")

moves = []
arrangement = []
stack_count_line = nil

lines.each do |line|
  if line.include?("move")
    moves.push(line)
    next
  end

  if line.include?("[")
    arrangement.push(line)
    next
  end

  next if line == "\n"

  stack_count_line = line
end


stack_count = stack_count_line.split.last.to_i

puts "stack count"
puts stack_count

puts arrangement

stacks = []

stack_count.times do 
  stacks << []
end

pp stacks

arrangement.each do |line|
  counter = 0
  while line != "\n" && line != ""
    puts line
    if line.length > 2
      c = line[1].strip
      stacks[counter].push(line[1]) unless c == ""
      line = line[4..-1]
      puts line
    end

    counter += 1
  end
end

puts "stacks---"
pp stacks

moves.each do |line|
  tokens = line.split
  count = tokens[1]
  from = tokens[3].to_i
  to = tokens[5].to_i

  puts "from #{from}"
  puts "to #{to}"
  puts "count #{count}"

  temp_array = []
  count.to_i.times do 
    pp stacks
    pp stacks[from - 1]
    temp_array.push(stacks[from - 1].shift)
  end

  pp stacks[to-1].prepend *temp_array
  pp stacks
end


result = []
stacks.each do |stack|
  result.push(stack.shift)
end

pp result.join

