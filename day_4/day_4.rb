require './day_4/input.rb'

class SecureContainer
  def initialize(range)
    @range = range
  end

  def brute_force
    total_valid = 0

    (@range.first..@range.last).each do |number|
      total_valid += 1 if valid_password?(number)
    end

    total_valid
  end

  def valid_password?(password)
    password_increasing?(password) && password_has_adjecents?(password)
  end

  def password_increasing?(password)
    last_char = nil
    password.to_s.split('').each do |char|
      if last_char.nil?
        last_char = char
        next
      end

      return false if last_char.to_i > char.to_i
      last_char = char
    end

    true
  end

  def password_has_adjecents?(password)
    password = password.to_s.split('')

    index = 0

    while index < password.size do
      if password[index + 1]
        count = 0
        password[index..-1].each do |char2|
          break unless char2 == password[index]

          count += 1
        end
        index += count

        return true if count == 2
      else
        index += 1
      end
    end

    false
  end
end

test = SecureContainer.new(RANGE)
p SecureContainer.new(RANGE).brute_force
# test.password_increasing?(114575)

# require 'pry'
# binding.pry