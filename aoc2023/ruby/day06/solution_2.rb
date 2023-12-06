# input=
#   '''Time:      7  15   30
# Distance:  9  40  200'''
input = File.read("input.txt")
lines = input.split("\n")
time = lines[0].split(":")[1].split(" ").join("").to_i
distance = lines[1].split(":")[1].split(" ").join("").to_i

result = []
patterns = 0

(0..time).each do |t|
  speed = t
  time_left = time - speed
  total_distance = speed * time_left
  if total_distance > distance
    patterns += 1
  end
end

result << patterns
pp result.reduce(&:*)
