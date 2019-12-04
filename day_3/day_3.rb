require './day_3/input.rb'

class CrossedWires
  attr_reader :wires

  def initialize(wires)
    @wires = parse_wires(wires)
  end

  def intersections 
    intersections = []

    lines[0..(lines.size - 2)].each_with_index do |line_for_wire, index|
      lines[index + 1..-1].each do |other_line_for_wire|
        line_for_wire.each do |line|
          other_line_for_wire.each do |line2|
            intersect = line_intersection(line, line2)
            intersections << intersect if intersect
          end
        end
      end
    end

    intersections
  end

  def intersections_with_lines
    intersections = []

    lines[0..(lines.size - 2)].each_with_index do |line_for_wire, index|
      lines[index + 1..-1].each do |other_line_for_wire|
        line_for_wire.each do |line|
          other_line_for_wire.each do |line2|
            intersect = line_intersection(line, line2)
            intersections += [[intersect, [line, line2]]] if intersect
          end
        end
      end
    end

    intersections
  end

  def lines
    @wires.map do |wire|
      lines_for_wire = []

      wire.each_with_index do |coordinate, index|
        lines_for_wire << [coordinate, wire[index + 1]] if wire[index + 1]
      end

      lines_for_wire
    end
  end

  def line_intersection(line1, line2)
    if line1[0][0] == line1[1][0] && line2[0][1] == line2[1][1]
      x = line1[0][0]
      y = line2[1][1]

      min = [line2[0][0], line2[1][0]].min
      max = [line2[0][0], line2[1][0]].max

      return [x, y] if min <= x && x <= max
    elsif line2[0][0] == line2[1][0]
      y = line1[0][1]
      x = line2[1][0]

      min = [line2[0][1], line2[1][1]].min
      max = [line2[0][1], line2[1][1]].max

      return [x, y] if min <= y && y <= max
    end

    nil
  end

  def closest_intersection
    intersections
  end

  def sorted_intersections
    intersections.sort do |a, b|
      (a[0].abs + a[1].abs) <=> (b[0].abs + b[1].abs)
    end
  end

  private

  def parse_wires(wires)
    @wires = wires.map { |wire| parse_wire(wire) }
  end

  def parse_wire(wire)
    last = [0, 0]

    wire.map do |move|
      direction = move[0]
      amount = move[1..-1].to_i

      last = if direction == 'R'
               [last[0] + amount, last[1]]
             elsif direction == 'L'
               [last[0] - amount, last[1]]
             elsif direction == 'U'
               [last[0], last[1] + amount]
             else
               [last[0], last[1] - amount]
             end
    end
  end
end

test = CrossedWires.new(WIRES)

require 'pry'
binding.pry