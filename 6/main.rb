class Node
  attr_accessor :parent, :name

  def initialize(name)
    @name = name
    @parent = nil
  end

  def orbits(i = 0)
    return i if parent == nil
    parent.orbits(i + 1)
  end

  def parents(p = [])
    return p if parent == nil
    parent.parents(p << self)
  end
end

def create_nodes(input)
  nodes = []
  input.each do |i|
    get_child(i, nodes).parent = get_parent(i, nodes)
  end
  nodes
end

def get_child(text, nodes)
  get_node(text.split(")")[1], nodes)
end

def get_parent(text, nodes)
  get_node(text.split(")")[0], nodes)
end

def get_node(name, nodes)
  node = nodes.find { |n| n.name == name }
  if node == nil
    nodes << Node.new(name)
    return nodes[-1]
  end
  node
end

input = File.new("./input.txt")
  .read
  .split("\n")

nodes = create_nodes(input)
you = get_node("YOU", nodes).parents
san = get_node("SAN", nodes).parents
puts ((you.length + san.length) - (you & san).length * 2) - 2
