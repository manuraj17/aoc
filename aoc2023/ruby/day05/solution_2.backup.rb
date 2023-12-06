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

seed_ranges = lines[0].split(":")[1].split(" ").map(&:to_i).each_slice(2).to_a
# pp seed_inputs

# def generate_seeds(seed_inputs)
#   range_grouped = []
#   current = []
#
#   seed_inputs.each_with_index do |s, idx|
#     current << s
#
#     if idx != 0 && idx%2 != 0 || idx == seed_inputs.length - 1
#       range_grouped << current
#       current = []
#     end
#   end
#
#   pp range_grouped
#
#   seeds = []
#
#   result = []
#   range_grouped.each do |start, range|
#     (start..start+range).each do |s| result << s end
#   end
#
#   result
# end

maps = []
headings = ["seed", "soil", "fertilizer", "water", "light", "temperature", "humidity"]

current = []


def find_range_in_map(source, target_map)
  in_range = []
  not_in_range = []

  pp "Source: #{source}"
  source_start, source_end = source

  pp target_map
  target_map.each do |t|
    _, target_start, range = t.split(" ").map(&:to_i)
    target_end = target_start + range

    # Within range conditions full and partial
    # Exact match or within range
    if source_start >= target_start && source_end <= target_end
      return [source], []
    end

    # Overlapping ranges
    # Starting before range
    if source_start < target_start && source_end > target_start && source_end <= target_end
      return [source_start, target_start-1], [target_start, source_end]
    end

    # Ending after range
    if source_start > target_start && source_start < target_end && source_end > target_end
      return [target_end+1, source_end], [source_start, target_end]
    end

  end


  # Not in any range
  if source_start < target_start && source_end < target_start
    return  [], [source]
  end

  # Above the range
  if source_start > target_start
    return [], [source]
  end
end

def transform_range(source, target)
  processed = []
  unprocessed = source

  unprocessed.each do |up|
    not_in_range, in_range = find_range_in_map(up, target)
    processed << in_range
    unprocessed << not_in_range
  end

  processed
end


def find_in_range(source, range, targets)
  result = []

  targets.each do |t|
    a,b,c = t.split(" ").map(&:to_i)

    if source == b
      return a
    elsif source > b && source <= b + c
      min = [source+range, b]
      result << (a..a + min)

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

# seeds = generate_seeds(seed_inputs)

def parse_ranges(first, second)
  converted = []
  not_converted = []

  if first[0] < second[0]
    if first[1] < second[0]
      # No overlap
      return [first, second]
    end
  end

  if first[0] > second[1]
    # No overlap
    return [first, second]
  end

  if first[0] >= second[0]
    if first[1] > second[1]
      # partial overlap
      [
        [first[0], second[1]], 
        [
          (first[1] - second[1]), first[1]
        ]
      ]
    end

    if first[1] <= second[1]
      # complete overlap
#     
    end
  end
end

# result = {}

result = []
pp seed_ranges

maps.each do |map|

  # Find and generate new ranges for seed and soil map
  seed_ranges.each do |seed_start, seed_range|
    
    seed_end = seed_start + seed_range
    result << transform_range([seed_start, seed_end], map)
  end


end
pp result

# seed_inputs.each do |seed, range|
#   if result[seed] == nil
#     (seed..seed+range).each do |s|
#       seed = s
#
#       soil_target = find_in_range(seed, maps[0])
#       fertilizer_target = find_in_range(soil_target, maps[1])
#       water_target = find_in_range(fertilizer_target, maps[2])
#       light_target = find_in_range(water_target, maps[3])
#       temperature_target = find_in_range(light_target, maps[4])
#       humidity_target = find_in_range(temperature_target, maps[5])
#       location_target = find_in_range(humidity_target, maps[6])
#
#       result[seed] = location_target
#     end
#   end
# end

# seeds.each do |seed|
#   if result[seed] == nil 
#     soil_target = find_in_range(seed, maps[0])
#     fertilizer_target = find_in_range(soil_target, maps[1])
#     water_target = find_in_range(fertilizer_target, maps[2])
#     light_target = find_in_range(water_target, maps[3]) temperature_target = find_in_range(light_target, maps[4])
#     humidity_target = find_in_range(temperature_target, maps[5])
#     location_target = find_in_range(humidity_target, maps[6])
#
#     result[seed] = location_target
#   end


  # pp "Seed: #{seed} soil_target: #{soil_target}"
  # pp "Seed: #{seed} fertilizer_target: #{fertilizer_target}"
  # pp "Seed: #{seed} water_target: #{water_target}"
  # pp "Seed: #{seed} light_target: #{light_target}"
  # pp "Seed: #{seed} temperature_target: #{temperature_target}"
  # pp "Seed: #{seed} humidity_target: #{humidity_target}"
  # pp "Seed: #{seed} location_target: #{location_target}"
# end

# pp result.values.min
