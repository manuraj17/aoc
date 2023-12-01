# frozen-string-literal: true

# rubocop:disable: Style/StringLiterals

# input_file = "inp1.txt"
# input_file = "inp2.txt"
input_file = "input.txt"

lines = File.readlines(input_file)

NOOP = "noop"
ADDX = "addx"
X = "x"

register = {}
register[X] = 1

STEPS_FOR_INSTRUCTION = {}
STEPS_FOR_INSTRUCTION[NOOP] =  1
STEPS_FOR_INSTRUCTION[ADDX] =  2
LIT_PIXEL = "#"
DARK_PIXEL = "."

IMPORTANT_CYCLES = [20, 60, 100, 140, 180, 220].freeze

def cycle_important?(cycle) = (((cycle - 20) % 40) == 0)

add_instruction = false
instruction_steps_pending = 0
cycle_count = 1

def run_instruction(instruction, value, register, cycle_count, signal_strength)
  step_print = []
  if instruction.eql?(NOOP)
    STEPS_FOR_INSTRUCTION[NOOP].times do |step|
      cycle_count += 1

      if cycle_important?(cycle_count)
        signal_strength += cycle_count * register[X]
      end
    end

    return [register, cycle_count, signal_strength]
  elsif instruction.eql?(ADDX)
    STEPS_FOR_INSTRUCTION[ADDX].times do |step|
      cycle_count += 1

      if step == 1
        register[X] += value.to_i
      end

      if cycle_important?(cycle_count)
        signal_strength += cycle_count * register[X]

      end
    end

    return [register, cycle_count, signal_strength]
  end
end


signal_strength = 0
register_index = 0
sprite_position = [0,1,2]
crt_index = 0
line_no = 0

# each cycle
loop do
  break if lines[line_no].nil?

  instruction, value = lines[line_no].strip.split(' ')

  register_index = register[X]

  sprite_position = [register_index-1, register_index, register_index + 1]

  current_execution_cycle_count = STEPS_FOR_INSTRUCTION[instruction]
  current_execution_cycle_count.times do |cycle|
    if sprite_position.include?(crt_index)
      print "#"
    else
      print "."
    end

    if [39, 79, 119, 159, 199, 239].include?(crt_index)
      puts ""
    end

    crt_index += 1
    crt_index = crt_index % 40
  end
  
  register, cycle_count, signal_strength = run_instruction(instruction, value, register, cycle_count, signal_strength)

  line_no += 1
end
