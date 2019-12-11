require './day_6/input.rb'
require './day_6/test_input.rb'

class Satellite
  attr_reader :name, :satellites, :orbiting
  def initialize(name)
    @name = name
    @satellites = []
    @orbiting = nil
  end

  def add_satellite(satellite)
    @satellites << satellite
  end

  def add_orbiting(satellite)
    @orbiting = satellite
  end

  def distance_to_inner_satellite(inner)
    total = 0
    current = self
    while current != inner
      current = current.orbiting
      total += 1
    end

    total
  end

  def distance_to_satellite(satellite)
    inner = find_common_inner_orbit(satellite)

    distance_to_inner_satellite(inner) +
    satellite.distance_to_inner_satellite(inner)
  end

  def find_common_inner_orbit(satellite)
    inner = self
    to_check = inner.satellites.dup

    while inner
      while to_check.any?
        sat = to_check.pop
        return inner if sat == satellite

        to_check += sat.satellites
      end

      inner = inner.orbiting
      to_check += inner.satellites
    end
  end
end

class System
  attr_reader :satellites, :root

  def initialize(orbits)
    @satellites = {}

    orbits.each do |orbit|
      inner, outer = orbit.split(')')

      inner = @satellites[inner] || (@satellites[inner] = Satellite.new(inner))
      outer = @satellites[outer] || (@satellites[outer] = Satellite.new(outer))

      inner.add_satellite(outer)
      outer.add_orbiting(inner)
    end

    set_root
  end

  def set_root
    satellite = @satellites.first.last
    satellite = satellite.orbiting while satellite.orbiting

    @root = satellite
  end

  def orbit_count(node = @root, distance = 0)
    return 0 unless node.satellites

    total = distance
    node.satellites.each do |satellite|
      total += orbit_count(node = satellite, distance + 1)
    end

    total
  end
end

test_system = System.new(TEST_ORBITS)
system = System.new(ORBITS)
test = test_system.satellites['I'].find_common_inner_orbit(test_system.satellites['zeta']).name
test2 = test_system.satellites['I'].distance_to_satellite(test_system.satellites['zeta'])
you_to_san = system.satellites['YOU'].distance_to_satellite(system.satellites['SAN']) - 2

require 'pry'
binding.pry