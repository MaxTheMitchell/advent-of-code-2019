def parse_wires(input)
  input.split("\n")
    .map { |line| create_lines(line.split(",")) }
end

def create_lines(directions, point = [0, 0], lines = [])
  return lines if directions == []
  new_point = new_point(point, directions[0][0], directions[0][1..].to_i)
  create_lines(
    directions[1..],
    new_point,
    lines << [
      point,
      new_point,
    ]
  )
end

def new_point(point, direction, length)
  case direction
  when "U"
    [point[0], point[1] + length]
  when "D"
    [point[0], point[1] - length]
  when "R"
    [point[0] + length, point[1]]
  when "L"
    [point[0] - length, point[1]]
  end
end

def find_intersections(wires)
  find_intersections_between_wires(wires[0], wires[1]).filter { |intersect| intersect != [0, 0] }
end

def find_intersections_between_wires(wire1, wire2)
  wire1.map do |line1|
    wire2.map do |line2|
      intersection(line1, line2)
    end
  end.flatten(1).filter { |intersection| intersection != nil }
end

def intersect?(line1, line2)
  return false if parellel?(line1, line2)
  return ((within?(line1[0][1], [line2[0][1], line2[1][1]]) and within?(line2[0][0], [line1[0][0], line1[1][0]])) or
          (within?(line2[0][1], [line1[0][1], line1[1][1]]) and within?(line1[0][0], [line2[0][0], line2[1][0]])))
end

def intersection(line1, line2)
  return nil unless intersect?(line1, line2)
  return [line1[0][0], line2[0][1]] if lies_on_x_axis?(line1)
  [line2[0][0], line1[0][1]]
end

def parellel?(line1, line2)
  lies_on_x_axis?(line1) == lies_on_x_axis?(line2)
end

def lies_on_x_axis?(line)
  line[0][0] == line[1][0]
end

def within?(val, points)
  val <= points.max and val >= points.min
end

def point_within_line?(point, line)
  within?(point[0], [line[0][0], line[1][0]]) and
  within?(point[1], [line[0][1], line[1][1]])
end

def path_length_to_point(lines, point, total = 0)
  return total + (lines[0][0].sum - point.sum).abs if point_within_line?(point,lines[0])
  path_length_to_point(lines[1..], point, total + (lines[0][0].sum - lines[0][1].sum).abs)
end

def combined_length_to_point(wires, point)
  path_length_to_point(wires[0], point) + path_length_to_point(wires[1], point)
end

wires = parse_wires(File.new("./input.txt").read)
# wires = parse_wires("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")

puts find_intersections(wires)
       .map { |intersect| combined_length_to_point(wires, intersect) }
       .min
