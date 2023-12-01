# lines = File.readlines("inp2.txt")
lines = File.readlines("input.txt")

lines = lines.map(&:strip)

head = [0,0]
tail = [0,0]
head_pre = nil
tail_pos = []

def move(point, direction)
  case direction.downcase
  when "d"
    [point[0] - 1, point[1]]
  when "u"
    [point[0] + 1, point[1]]
  when "l"
    [point[0], point[1] - 1]
  when "r"
    [point[0], point[1] + 1]
  end
end

def touching?(head, tail)
  (head[0] - tail[0]).abs <= 1 && (head[1] - tail[1]).abs <= 1
end


lines.each do |line|
  direction, steps = line.split(' ')

  steps.to_i.times do |step|
    head_pre = head
    head = move(head, direction)

    next if touching?(head, tail)

    tail = head_pre
    tail_pos << tail.clone
  end
end

pp tail_pos.uniq.count

