#!/usr/bin/ruby

# Two things of note:
# 1. Assumed decay of all connections when not boosted by others
# 2. Connections from others create self-connections: a.k.a. friends increase self-esteem.

# Linus Lee
# linus@thelifelongtraveler.com
# webb - social network simulation software

require 'matrix'

$network = Matrix[
  [1.0, 1.0, 1.0],
  [1.0, 1.0, 1.0],
  [1.0, 1.0, 1.0]
]
$normals = Matrix[
  [1.0,1.0,1.0],
  [1.0,1.0,1.0],
  [1.0,1.0,1.0]
]
Size = $network.to_a.length
Accuracy = 1.0 # how strong the peturbation is; the greater the better, scale of 0 to 1
Peturb_to = Accuracy * Size.to_f

#init commands
$loopSum = 0.0 # float, global for usage
$loopNormalSum = 0.0 # normalizer

def evolve(node1,node2,order)
  # evolving individual units
  if order >= Size
    puts "Invalid loop order! Aborting operation."
    exit
  end
  $loopSum = ($network**order).[](node1,node2)
  $loopNormalSum = ($normals**order).[](node1,node2)
  return $loopSum / $loopNormalSum
end

def iterate()
  # evolving entire networks
  for order in 1..(Peturb_to) do
    evolvedNet = ($network**order).to_a
    evolvedNorm = ($normals**order).to_a
    setArray = $network.to_a # just to copy the same dimensions
    for i in 0..(Size - 1) do
      for j in 0..(Size - 1) do
        setArray[i][j] = evolvedNet[i][j] / evolvedNorm[i][j]
      end
    end
  end
  # change setArray into $network
  $network = Matrix.build(Size) {|row,col| setArray[row][col]}
end

def normalize()
  #normalizing network strength parameters
  setArray = $network.to_a
  setMax = setArray[0][0]
  setArray.each {|row|
    if row.max > setMax
      setMax = row.max
    end
  }
  for i in 0..(Size - 1) do
    for j in 0..(Size - 1) do
      setArray[i][j] /= setMax
    end
  end
  $network = Matrix.build(Size) {|row,col| setArray[row][col]}
end

for i in 0..5 do
  puts $network.to_s
  iterate()
  normalize()
end

