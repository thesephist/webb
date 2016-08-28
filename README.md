# Webb

Simplistic social network evolution simulation software

## Concept

Webb is a simplistic simluation of evolution of _perfect social networks_.

_Perfect social networks_ are networks without any external or random factors, where all nodes are assuemd to be perfectly rational and all connections are assumed to be of the same type, only varying in strength.

Webb's core model is a perturbation model, where the strength of a connection between A and B in a social network is dictated most by the connection between A and B the period before, then slightly less by the connections between A, B, and a third party the generation, and so on for 2, 3, 4, etc. third party nodes. Webb uses a matrix model to simulate this behavior.

## Project Roadmap

Webb is currently _running_. All major bugs have been fixed and the core stack has been completed, but there are unimplemented features:

* Statistical testing and corrections based on data
* Speed-optimized simulation for networks with more than 20 nodes.

## Setup

The full Webb "library" has three main parts: 

* `ism.rb`: Ruby script for computation, and its derivatives focused on use cases
* `to\_graph.js`: generating a visual output (SVG)
* `to\_topology.js`: generating a visual CLI output for topology of a given network

The ruby script runs inside a loop within the code, each time the network progressing 1 interval of time, and prints out the raw output of the network variable as a Ruby matrix object.

The raw output of the ruby script can be captured and directly fed into the SVG generator script that outputs a single SVG.

## Samples

Within the repository there are some already tested samples availble with their source inputs inside `samples/graphs/` and `samples/networks/` respectively.
