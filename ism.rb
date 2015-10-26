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
Perturb_to = Accuracy * Size.to_f

#init commands
$loopSum = 0.to_f # float, global for usage
$loopNormalSum = 0.to_f # normalizer
$ufactor = 1
$previous = $network

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
  $previous = $network
  setArray = $network.to_a
  for order in 1..(Perturb_to) do
    evolvedNet = ($network**order).to_a
    evolvedNorm = ($normals**order).to_a
    for i in 0..(Size - 1) do
      for j in 0..(Size - 1) do
        if order == 1
          setArray[i][j] = evolvedNet[i][j] / evolvedNorm[i][j]
        else 
          setArray[i][j] += evolvedNet[i][j] / evolvedNorm[i][j]
        end
      end
    end
  end

  # change setArray into $network
  $network = Matrix.build(Size) {|row,col| setArray[row][col]}
end

def uniformity(k)
  # uniformity factor computation
  diff = ($network - $previous).to_a
  pos = [1, 0]
  neg = [1, 0]
  for i in 0..(Size - 1) do
    for j in 0..(Size - 1) do
      if diff[i][j] > 0
        pos[0] *= diff[i][j]
        pos[1] += 1
      elsif diff[i][j] < 0
        neg[0] *= diff[i][j]
        neg[1] += 1
      end
    end
  end

  if neg[0] == 0 || neg[1] == 0
    $ufactor = "is undefined"
  else 
    $ufactor = (pos[0].abs ** (1.0 / pos[1])) / (neg[0].abs ** (1.0 / neg[1]))
  end
  puts "Order " + k.to_s + ": Uniformity Factor " + $ufactor.to_s
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

for i in 1..10 do
  iterate()
  normalize()
  uniformity(i)
end

puts $network.to_s

