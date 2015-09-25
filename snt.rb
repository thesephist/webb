#!/usr/bin/ruby
# Linus Lee
# linus@thelifelongtraveler.com
# webb - social network simulation software

require 'matrix'

$network = Matrix[
  [1.0, 1.0, 1.0, 1.0],
  [1.0, 1.0, 0.0, 0.0],
  [1.0, 0.0, 1.0, 0.0],
  [1.0, 0.0, 0.0, 1.0]
]
$normals = Matrix[
  [1.0,1.0,1.0,1.0],
  [1.0,1.0,1.0,1.0],
  [1.0,1.0,1.0,1.0],
  [1.0,1.0,1.0,1.0]
]

Size = $network.to_a.length
Accuracy = 1.to_f # how strong the peturbation is; the greater the better, scale of 0 to 1
Peturb_to = Accuracy * Size.to_f

#init commands
$loopSum = 0.to_f # float, global for usage
$loopNormalSum = 0.to_f # normalizer

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

puts $network.to_s

for i in 0..5 do
  iterate()
  normalize()
end

puts $network.to_s

