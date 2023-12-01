# input_file = "inp1.txt"
input_file = "input.txt"
# input_file = "input.txt"

lines = File.readlines(input_file)

# Monkey = Struct.new(:items, :operation, :test, :true_monkey, :false_monkey)

monkey_lines = []
current = []

lines.each do |line|
  current << line.strip unless line == "\n"

  if line == "\n"
    monkey_lines << current
    current = []
  end
end

monkey_lines << current

monkey_id_regex = Regexp.new('^Monkey\s(\d):\z').freeze
starting_items_regex = Regexp.new('Starting\sitems: ([\s\S]+)').freeze
operation_regex = Regexp.new('Operation: ([\s\S]+)').freeze
test_regex = Regexp.new('Test: ([\s\S]+)').freeze
true_path_regex = Regexp.new('If true: throw to monkey ([\s\S]+)').freeze
false_path_regex = Regexp.new('If false: throw to monkey ([\s\S]+)').freeze


def do_test(level, divisor)
  (level%divisor) == 0
end


pp monkey_lines[2]

monkeys_array = []

class Monkey
  attr_accessor :id, :starting_items, :items_inspected, :test_number, :worry_level_control

  def initialize(id:, starting_items:, operation:, test:, true_monkey:, false_monkey:, worry_level_control: nil)
    @id = id
    # Array of items
    @starting_items = starting_items || []
    # string
    @operation = operation
    # string
    @test_number = test.split(" ").last.to_i
    # number
    @true_monkey = true_monkey
    # number
    @false_monkey = false_monkey
    # number
    @items_inspected = 0
    # number
    @worry_level_control = worry_level_control || 1
  end

  def play_round
    result = []
    loop do
      break if @starting_items.empty?

      item = @starting_items.shift

      @items_inspected += 1

      # puts
      # puts "Monkey #{@id} is inspecting item #{item}"
      # return [nil, nil] if item.nil?

      formula = @operation.split("=")[1].strip
      worry_level = process_formula(formula, item)
      # puts "Worry level of item multiplied to #{worry_level}"
      # worry_level_after_bored = worry_level / 3
      worry_level_after_bored = (worry_level % @worry_level_control)
      # puts "Monkey gets bored and worry level is now #{worry_level_after_bored}"
      test_result = do_test(worry_level_after_bored, @test_number)
      # if test_result == true
      #   # puts "Current worry level is divisible by #{divisor}"
      #   # puts "Item with worry level #{worry_level_after_bored} is thrown to #{@true_monkey}"
      # else
      #   # puts "Current worry level not is divisible by #{divisor}"
      #   # puts "Item with worry level #{worry_level_after_bored} is thrown to #{@false_monkey}"
      # end

      target_monkey = test_result == true ? @true_monkey : @false_monkey

      result << [target_monkey, worry_level_after_bored.clone]
    end

    result
  end

  def add_item(item)
    @starting_items << item
  end

  private

  def process_formula(formula, old_value)
    operand_1, operator, operand_2 = formula.split(" ")

    operand_1_parsed = operand_1 == "old" ? old_value : operand_1.to_i
    operand_2_parsed = operand_2 == "old" ? old_value : operand_2.to_i

    # pp formula
    # pp operand_1_parsed
    # pp operand_2_parsed
    case operator
    when "*"
      operand_1_parsed * operand_2_parsed
    when "+"
      operand_1_parsed + operand_2_parsed
    when "-"
      operand_1_parsed - operand_2_parsed
    when "/"
      operand_1_parsed - operand_2_parsed
    end
  end
end

# pp monkeys_array

monkey_lines.each do |monkeys|
  monkey_number = monkey_id_regex.match(monkeys[0])[1].to_i
  monkey_items = starting_items_regex.match(monkeys[1])[1].split(' ').map(&:to_i)
  operation = operation_regex.match(monkeys[2])[1]
  test = test_regex.match(monkeys[3])[1]
  true_monkey = true_path_regex.match(monkeys[4])[1].to_i
  false_monkey = false_path_regex.match(monkeys[5])[1].to_i

  monkeys_array << Monkey.new(
    id: monkey_number,
    starting_items: monkey_items,
    operation: operation,
    test: test,
    true_monkey: true_monkey,
    false_monkey: false_monkey
  )
end

pp monkeys_array

round_count = 0

new_divisor = 1
monkeys_array.each do |monkey|
  new_divisor = new_divisor * monkey.test_number
end

pp new_divisor

monkeys_array.each do |monkey|
  monkey.worry_level_control = new_divisor
end

loop do
  round_count += 1
  puts "Playing round #{round_count}"

  break if round_count > 10000

  monkeys_array.each do |monkey|
    results  = monkey.play_round
    results.each do |result|
      target_monkey, item  = result

      monkeys_array[target_monkey].add_item(item.clone)
    end
  end

  # pp "After Round #{round_count}"
  # monkeys_array.each { |m| pp "#{m.id}: #{m.starting_items}" }
end

pp monkeys_array

monkeys_array.each { |m| pp "#{m.id}: #{m.starting_items}" }
inspection_count = []
monkeys_array.each do |m|
  inspection_count << m.items_inspected
  pp "Monkey #{m.id} inspected items #{m.items_inspected} times"
end

pp inspection_count.sort.reverse[0] * inspection_count.sort.reverse[1]
