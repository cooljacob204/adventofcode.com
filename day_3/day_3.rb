require './day_3/input.rb'

class CrossedWires
  class << self
    def intersections(wire1, wire2)
      intersections = []

      wire1_hash = hash_wire(wire1)
      wire2_hash = hash_wire(wire2)

      require 'pry'
      binding.pry

      wire2_hash.keys.each do |move|
        intersections << move if wire1_hash[move]
      end

      intersections
    end

    def closest_intersection_distance(wire1, wire2)
      wire1_array = array_wire(wire1)
      wire2_array = array_wire(wire2)
      intersections = intersections(wire1, wire2)

      amount = distance_to_intersection(intersections[0], wire1_array) +
               distance_to_intersection(intersections[0], wire2_array)

      p amount, intersections[0]
      intersections[1..-1].each do |intersection|
        temp_amount = distance_to_intersection(intersection, wire1_array) +
                      distance_to_intersection(intersection, wire2_array)

        p temp_amount, intersection if temp_amount < amount
        amount = temp_amount if temp_amount < amount
      end

      amount
    end

    def distance_to_intersection(intersection, wire_array)
      wire_array.each_with_index do |point, index|
        return index if point == intersection
      end
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
          ((current[0] + 1)..(current[0] + amount)).each do |point|
            hash[[point, current[1]]] = move
            current = [point, current[1]]
          end
        elsif direction == 'L'
          ((current[0] - 1).downto(current[0] - amount)).each do |point|
            hash[[point, current[1]]] = move
            current = [point, current[1]]
          end
        elsif direction == 'U'
          ((current[1] + 1)..(current[1] + amount)).each do |point|
            hash[[current[0], point]] = move
            current = [current[0], point]
          end
        else
          ((current[1] - 1).downto(current[1] - amount)).each do |point|
            hash[[current[0], point]] = move
            current = [current[0], point]
          end
        end
      end

      hash
    end

    def array_wire(wire)
      current = [0, 0]
      array = []

      wire.each do |move|
        direction = move[0]
        amount = move[1..-1].to_i

        if direction == 'R'
          ((current[0] + 1)..(current[0] + amount)).each do |point|
            array << [point, current[1]]
            current = [point, current[1]]
          end
        elsif direction == 'L'
          ((current[0] - 1).downto(current[0] - amount)).each do |point|
            array << [point, current[1]]
            current = [point, current[1]]
          end
        elsif direction == 'U'
          ((current[1] + 1)..(current[1] + amount)).each do |point|
            array << [current[0], point]
            current = [current[0], point]
          end
        else
          ((current[1] - 1).downto(current[1] - amount)).each do |point|
            array << [current[0], point]
            current = [current[0], point]
          end
        end
      end

      array
    end
  end
end

test = CrossedWires.sorted_intersections(*WIRES)
test2 = CrossedWires.closest_intersection_distance(*WIRES)

require 'pry'
binding.pry