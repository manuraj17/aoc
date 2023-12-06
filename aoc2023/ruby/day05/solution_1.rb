input = 
  '''seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4'''

input = File.read("input.txt")
lines = input.split("\n")

seeds = lines[0].split(":")[1].split(" ").map(&:to_i)

maps = []
headings = ["seed", "soil", "fertilizer", "water", "light", "temperature", "humidity"]

current = []


def find_in_range(source, targets)
  targets.each do |t|
    a,b,c = t.split(" ").map(&:to_i)

    if source == b
      return a
    elsif source > b && source <= b + c
      return a + (source-b)
    end
  end

  return source
end

lines[2..-1].each_with_index do |l, idx|
  if l == "" || idx == lines.length - 3
    maps << current
    current = []
  else
    next if (headings.map do |h| l.start_with?(h) end).any?
    current << l
  end
end

# pp maps

result = []
seeds.each do |seed|
  soil_target = find_in_range(seed, maps[0])
  fertilizer_target = find_in_range(soil_target, maps[1])
  water_target = find_in_range(fertilizer_target, maps[2])
  light_target = find_in_range(water_target, maps[3])
  temperature_target = find_in_range(light_target, maps[4])
  humidity_target = find_in_range(temperature_target, maps[5])
  location_target = find_in_range(humidity_target, maps[6])
  
  result << location_target

  # pp "Seed: #{seed} soil_target: #{soil_target}"
  # pp "Seed: #{seed} fertilizer_target: #{fertilizer_target}"
  # pp "Seed: #{seed} water_target: #{water_target}"
  # pp "Seed: #{seed} light_target: #{light_target}"
  # pp "Seed: #{seed} temperature_target: #{temperature_target}"
  # pp "Seed: #{seed} humidity_target: #{humidity_target}"
  # pp "Seed: #{seed} location_target: #{location_target}"
end

pp result.min
