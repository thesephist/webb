# Webb

Simplistic social network evolution simulation software

## Concept

Webb is a simplistic simluation of evolution of _perfect social networks_.

_Perfect social networks_ are networks without any external or random factors, where all nodes are assuemd to be perfectly rational and all connections are assumed to be of the same type, only varying in strength.

Webb's core model is a perturbation model, where the strength of a connection between A and B in a social network is dictated most by the connection between A and B the period before, then slightly less by the connections between A, B, and a third party the generation, and so on for 2, 3, 4, etc. third party nodes. Webb uses a matrix model to simulate this behavior.

## Uniformity Factor

Each iteratino of an evolution of the Webb algorithm yields a floating point value uniformity factor describing the behavior of the network at that iteration

The uniformity factor is defined as _the geometric mean of connections strengthened divided by the geometric mean of the connections weakened_, and is not defined for systems at equilibrium (stable, unchanging networks) but is well defined for dynamic networks. 

## Project Roadmap

Webb is currently _running_. All major bugs have been fixed and the core stack has been completed, but there are unimplemented features:

* Easier ways of visualizing simluated networks through time
* Easier ways of visualizing simulated networks for more than ~12 nodes
* Better normalization
* Statistical testing and corrections based on data

## Setup

The full Webb stack has two main parts: 

* snt.rb: Ruby script for computation
* to\_graph.js: generating a visual output (SVG)

The SVG generator runs as a NodeJS application.

Within the ruby script, __$network__ dictates the beginning network strengths, with the connection strength from node _i_ to node _j_ defined by $network\[i\]\[j\]. 

