def parse_input
  File.new("./input.txt")
    .read
    .split(",")
    .map { |n| n.to_i }
end

def read_opcode(tape, index = 0)
  case tape[index]
  when 99
    halt(tape)
  when 1
    add(tape, index)
  when 2
    mult(tape, index)
  else
    puts "invalide opcode"
    return [nil]
  end
end

def halt(tape)
  return tape
end

def add(tape, index)
  tape[tape[index + 3]] = tape[tape[index + 1]] + tape[tape[index + 2]]
  read_opcode(tape, index + 4)
end

def mult(tape, index)
  tape[tape[index + 3]] = tape[tape[index + 1]] * tape[tape[index + 2]]
  read_opcode(tape, index + 4)
end

def run_opcode(verb, noun)
  tape = parse_input
  tape[1] = noun
  tape[2] = verb
  read_opcode(tape)
end

def find_verb_and_noun
  (0..99).each do |verb|
    (0..99).each do |noun|
      if run_opcode(verb, noun)[0] == 19690720
        puts "verb:#{verb}\nnoun:#{noun}\nsolution:#{noun*100+verb}"
      end
    end
  end
end

find_verb_and_noun
