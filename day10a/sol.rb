# frozen-string-literal: true

# rubocop:disable: Style/StringLiterals

# input_file = "inp1.txt"
# input_file = "inp2.txt"
# input_file = "input.txt"

lines = File.readlines(input_file)

NOOP = "noop"
ADDX = "addx"
X = "x"

register = {}
register[X] = 1

STEPS_FOR_INSTRUCTION = {}
STEPS_FOR_INSTRUCTION[NOOP] =  1
STEPS_FOR_INSTRUCTION[ADDX] =  2

IMPORTANT_CYCLES = [20, 60, 100, 140, 180, 220].freeze

def cycle_important?(cycle) = (((cycle - 20) % 40) == 0)

add_instruction = false
instruction_steps_pending = 0
cycle_count = 1

pp STEPS_FOR_INSTRUCTION
def run_instruction(instruction, value, register, cycle_count, signal_strength)


  if instruction.eql?(NOOP)
    STEPS_FOR_INSTRUCTION[NOOP].times do |step|
      cycle_count += 1
      # puts "#{NOOP}: #{step}: #{cycle_count}"

      if cycle_important?(cycle_count)
        puts "CYCLE: #{cycle_count}"
        puts "REGISTER: #{register}"
        puts "#{cycle_count * register[X]}"
        signal_strength += cycle_count * register[X]

        pp "Strenght: #{signal_strength}"
      end
    end

    return [register, cycle_count, signal_strength]
  elsif instruction.eql?(ADDX)
    STEPS_FOR_INSTRUCTION[ADDX].times do |step|
      cycle_count += 1

      if step == 1
        # puts "Executing #{ADDX}"
        register[X] += value.to_i
      end

      if cycle_important?(cycle_count)
        puts "CYCLE: #{cycle_count}"
        puts "REGISTER: #{register}"
        puts "#{cycle_count * register[X]}"
        signal_strength += cycle_count * register[X]

        pp "Strenght: #{signal_strength}"
      end
    end

    return [register, cycle_count, signal_strength]
  end

  puts "No register found"
end

pp register

signal_strength = 0
lines.map(&:strip).each do |line|
  instruction, value = line.split(' ')

  pp "BEFORE"
  pp cycle_count
  register, cycle_count, signal_strength = run_instruction(instruction, value, register, cycle_count, signal_strength)

  pp "AFTER"
  pp cycle_count


  
  pp "CYCLE COUNT: #{cycle_count}"
end

pp "FINAL"
pp register
pp signal_strength
