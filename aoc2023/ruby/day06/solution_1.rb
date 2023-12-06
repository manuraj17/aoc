# input=
#   '''Time:      7  15   30
# Distance:  9  40  200'''
input = File.read("input.txt")
lines = input.split("\n")
times = lines[0].split(":")[1].split(" ").map(&:to_i)
distances = lines[1].split(":")[1].split(" ").map(&:to_i)

result = []

# times.each_with_index do |time, index|
#   result << (0..time).reduce(0) {  |acc, speed| (acc += 1) if (speed * (time - speed)) > distances[index]; acc }
# end

times.each_with_index do |time, index|
  result << (0..time).reduce(0) do |acc, t|
    speed = t
    time_left = time - speed
    total_distance = speed * time_left

    (acc += 1) if total_distance > distances[index]

    acc
  end
end

pp result.reduce(&:*)
