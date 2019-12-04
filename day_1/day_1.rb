require './day_1/input.rb'

class MassCalcuator
  def initialize(modules)
    @modules = modules
  end

  def fuel_required
    total_fuel = 0

    @modules.each do |mass|
      total_fuel += calculate_module_fuel(mass)
    end

    total_fuel
  end

  protected

  def calculate_module_fuel(mass)
    fuel_needed = (mass / 3.0).floor - 2

    return 0 if fuel_needed < 0

    fuel_needed
  end
end

p MassCalcuator.new(SPACECRAFT_MODULES).fuel_required
