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
# seeds = input.split("\n")[0].split(":")[1].split(" ").map(&:to_i).each_slice(2).to_a
# _, *blocks = input.split("\n\n")
inputs, *blocks = input.split("\n\n")

# pp inputs
# pp blocks
# exit
# inputs = inputs.split(":")[1].split(" ").map(&:to_i)
# seeds = inputs.each_slice(2).to_a.map { |x,y| [x, x+y]}

seeds = inputs.split(":")[1].split(" ").map(&:to_i).each_slice(2).to_a.map { |x,y| [x, x+y]}

blocks.each do |block|
  ranges = []
  
  block.split("\n")[1..-1].each do |line|
    ranges << line.split(" ").map(&:to_i)
  end
  # pp ranges

  new = []

  while seeds.length > 0
    s,e = seeds.pop

    non_match = true

    ranges.each do |a,b,c|
      os = [s,b].max
      oe = [e, b+c].min

      if os < oe
        new << [os - b + a, oe - b + a]

        if os > s
          seeds << [s, os]
        end


        if e > oe
          seeds << [oe, e]
        end

        non_match = false
        break
      end
    end

    if non_match == true
      new << [s, e]
    end
  end

  seeds = new.clone
end

# 7873084,
pp (seeds.min)[0]

