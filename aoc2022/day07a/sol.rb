Element = Struct.new(:el_parent, :el_name, :el_size, :el_children, :el_path, :el_type)
DIR = "directory"
FILE = "file"

# lines = File.readlines("inp2.txt")
lines = File.readlines("input.txt")
root = nil
current_line = 0
current_dir = nil

def parse_root
  Element.new(nil, "/", 0, [], "")
end

def parse_ls(current_dir, current_line, lines)
  puts current_dir.el_path
  puts current_dir.el_children.count
  loop do
    tokens = lines[current_line].split
    if lines[current_line].include? "dir"
      name = tokens[1]
      path = "#{current_dir.el_path}/#{name}"
      child_directory = Element.new(current_dir, name, 0, [], path, DIR)
      current_dir.el_children << child_directory
    else
      size = tokens[0]
      name = tokens[1]
      path = "#{current_dir.el_path}/#{name}"
      child = Element.new(current_dir, name, size, nil, path, FILE)
      current_dir.el_children << child
    end

    current_line += 1
    # pp current_line
    # pp lines[current_line]

    break if lines[current_line] == nil
    break if lines[current_line].include?("$")
  end

  puts "after"
  puts current_dir.el_children.count
  [current_dir, current_line]
end

def parse_cd(current_dir, current_line, lines)
  target = lines[current_line].split[2]

  if target == ".."
    [current_dir.el_parent, current_line + 1]
  else
    child = current_dir.el_children.select { |e| e.el_name == target }.first
    [child, current_line + 1]
  end
end

loop do
  break if current_line == "\n" || current_line == ""

  # Parse root
  if lines[current_line].include? "$ cd /"
    puts "parsing root"
    root = parse_root
    current_dir = root
    current_line += 1
  end

  # Parse other lines
  if lines[current_line].include? "$ ls"
    puts lines[current_line]
    puts "parsing ls"
    current_dir, current_line = parse_ls(current_dir, current_line+1, lines)
  end

  break if lines[current_line] == nil

  if lines[current_line].include? "$ cd"
    puts lines[current_line]
    puts "before: #{current_dir.el_path}"
    current_dir, current_line = parse_cd(current_dir, current_line, lines)
    puts "after: #{current_dir.el_path}"
  end

  break if lines[current_line] == nil
end

# pp root

LIMIT = 100000
directories = []

def count_size(dir, directories)
  return 0 if dir.el_children.length == 0

  size = 0

  dir.el_children.each do |c|
    if c.el_type == DIR
      new_size, new_directories = count_size(c, directories)

      size += new_size
      directories = new_directories
    else
      size += c.el_size.to_i
    end
  end

  dir.el_size = size

  if size <= LIMIT
    pp dir.el_name
    directories.push(dir)
  end

  [size, directories]
end

final_size, final_directories = count_size(root, directories)
root.el_size = final_size

total_sum = 0
final_directories.each do |fd|
  total_sum += fd.el_size
end


puts ""
puts ""
puts ""
puts ""
puts ""

def print_dir(offset, n)
  if n.el_parent == nil
    puts "#{n.el_name} #{n.el_size}"
  else
    puts "#{ '-' * (offset-1)}|#{n.el_name} #{n.el_size}"
  end

  n.el_children.each do |c|
    if c.el_type == DIR
      print_dir(offset+2, c)
    else
      puts "#{ '-' * (offset+1)}|#{c.el_name} #{c.el_size}"
    end
  end
end

print_dir(2, root)
# pp final_directories.count
# final_directories.each do |d|
#   pp d.el_size
# end

pp total_sum
