def parse_input
  File.new("./input.txt")
      .read
      .split("\n")
      .map { |line| line.to_i }
end

def fuel_needed_for_mass(mass)
  feul_needed = (mass / 3) - 2
  return feul_needed + fuel_needed_for_mass(feul_needed) unless feul_needed <= 0
  0
end

puts parse_input
    .map{|mass| fuel_needed_for_mass(mass)}
    .sum
