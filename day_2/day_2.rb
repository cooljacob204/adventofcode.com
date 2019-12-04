require './day_2/input.rb'

class Intcode
  attr_reader :integers

  def initialize(integers)
    @integers = integers.dup
  end

  def process_integers
    @integers.each_slice(4) do |slice|
      p slice
      if slice[0] == 1
        add(slice)
      elsif slice[0] == 2
        multiply(slice)
      else
        break
      end
    end

    self
  end

  protected

  def add(slice)
    @integers[slice[3]] = @integers[slice[1]] + @integers[slice[2]]
  end

  def multiply(slice)
    @integers[slice[3]] = @integers[slice[1]] * @integers[slice[2]]
  end
end

p Intcode.new(INTS).process_integers.integers[0]
