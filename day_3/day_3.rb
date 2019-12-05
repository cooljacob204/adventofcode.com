require './day_3/input.rb'

class CrossedWires
  class << self
    def intersections(wire1, wire2)
      intersections = []

      wire1_hash = hash_wire(wire1)
      wire2_hash = hash_wire(wire2)

      wire2_hash.keys.each do |move|
        intersections << move if wire1_hash[move]
      end

      intersections
    end

    def sorted_intersections(wire1, wire2)
      intersections(wire1, wire2).sort do |a, b|
        (a[0].abs + a[1].abs) <=> (b[0].abs + b[1].abs)
      end
    end

    def hash_wire(wire)
      current = [0, 0]
      hash = {}

      wire.each do |move|
        direction = move[0]
        amount = move[1..-1].to_i

        if direction == 'R'
          (current[0]..(current[0] + amount)).each do |point|
            hash[[point, current[1]]] = move
            current = [point, current[1]]
          end
        elsif direction == 'L'
          (current[0].downto(current[0] - amount)).each do |point|
            hash[[point, current[1]]] = move
            current = [point, current[1]]
          end
        elsif direction == 'U'
          (current[1]..(current[1] + amount)).each do |point|
            hash[[current[0], point]] = move
            current = [current[0], point]
          end
        else
          (current[1].downto(current[1] - amount)).each do |point|
            hash[[current[0], point]] = move
            current = [current[0], point]
          end
        end
      end

      hash
    end
  end
end

test = CrossedWires.sorted_intersections(*WIRES)

require 'pry'
binding.pry