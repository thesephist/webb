#!/usr/bin/ruby
# Linus Lee
# linus@thelifelongtraveler.com

require 'matrix'

$network = Matrix[ 
]

$normals = Matrix[
]

Size = $network.to_a.length
Accuracy = 1.to_f # how strong the Perturbation is; the greater the better, scale of 0 to 1
Iterate_to = Accuracy * Size.to_f

# for speed
if Iterate_to >= 40
  Iterate_to = 40
end

#init commands
$loopSum = 0.to_f # float, global for usage
$loopNormalSum = 0.to_f # normalizer
$ufactor = 1
$previous = $network

def evolve(node1, node2, order)
  # evolving individual units
  if order >= Size
    puts "Invalid loop order! Aborting operation."
    exit
  end
  $loopSum = ($network ** order).[](node1, node2)
  $loopNormalSum = ($normals ** order).[](node1, node2)
  return $loopSum / $loopNormalSum
end

def iterate()
  # evolving entire networks
  $previous = $network
  setArray = $network.to_a
  for order in 1..(Iterate_to) do
    evolvedNet = ($network ** order).to_a
    evolvedNorm = ($normals ** order).to_a
    Size.times do |i|
      Size.times do |j|
        if order == 1
          setArray[i][j] = evolvedNet[i][j] / evolvedNorm[i][j]
        else 
          setArray[i][j] += evolvedNet[i][j] / evolvedNorm[i][j]
        end
      end
    end
  end

  # change setArray into $network
  $network = Matrix.build(Size) { |row, col| setArray[row][col] }
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
  Size.times do |i|
    Size.times do |j|
      setArray[i][j] /= setMax
    end
  end
  $network = Matrix.build(Size) { |row, col| setArray[row][col] }
end

for i in 1..10 do
  iterate()
  normalize()
end

puts $network.to_s

