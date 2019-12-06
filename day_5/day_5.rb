require './day_5/input.rb'

class Intcode
  attr_reader :integers

  def initialize(integers)
    @integers = integers.dup
  end

  def start
    index = 0

    index = parse_instruction(index) while index != -1 && index < @integers.size
  end

  def parse_instruction(index)
    send(codes[@integers[index] % 100], index)
  end

  def add(index)
    modes = get_modes(index)

    num1 = get_value(index + 1, modes[2])
    num2 = get_value(index + 2, modes[1])
    writelocation = @integers[index + 3]

    @integers[writelocation] = num1 + num2

    index + 4
  end

  def multiple(index)
    modes = get_modes(index)

    num1 = get_value(index + 1, modes[2])
    num2 = get_value(index + 2, modes[1])
    writelocation = @integers[index + 3]

    @integers[writelocation] = num1 * num2

    index + 4
  end

  def input(index)
    p 'Input Number:'
    input = gets.chomp

    @integers[@integers[index + 1]] = input.to_i

    index + 2
  end

  def output(index)
    modes = get_modes(index)

    p get_value(index + 1, modes[2])

    index + 2
  end

  def hault(_)
    -1
  end

  protected

  def get_value(index, mode)
    return @integers[@integers[index]] if mode.zero?
    return @integers[index] if mode == 1

    nil
  end

  def get_modes(index)
    (@integers[index] / 100).to_s.rjust(3, '0').split('').map(&:to_i)
  end

  def codes
    {
      1 => :add,
      2 => :multiple,
      3 => :input,
      4 => :output,
      99 => :hault
    }
  end
end

Intcode.new(INTEGERS).start