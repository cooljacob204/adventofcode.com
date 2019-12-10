require './day_6/input.rb'
require './day_6/test_input.rb'

class Planet
  attr_reader :name, :satellites
  def initialize(name)
    @name = name
    @satellites = []
  end

  def add_satellite(satellite)
    @satellites << satellite
  end
end

class System
  attr_reader :satellites

  def initialize(orbits)
    @satellites = {}
    @root = orbits.first.split(')').first

    orbits.each do |orbit|
      inner, outer = orbit.split(')')

      inner = @satellites[inner] || (@satellites[inner] = Planet.new(inner))
      outer = @satellites[outer] || (@satellites[outer] = Planet.new(outer))

      inner.add_satellite(outer)
    end
  end

  def orbit_count(node = satellites[@root], previous_total = 0)
    return 0 unless node.satellites

    total = previous_total
    node.satellites.each do |satellite|
      total += orbit_count(node = satellite, previous_total + 1)
    end

    total
  end
end

test_system = System.new(TEST_ORBITS)
system = System.new(ORBITS)

require 'pry'
binding.pry