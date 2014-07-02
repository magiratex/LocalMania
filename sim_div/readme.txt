functions:

get_coordinate.m
- insert waypoints to a map (unit: pixel)
- add edges by identifying two waypoints and their gatepoint
- identify portals points (which are included in waypoints)
- display the waypoints and the proximity
- save the waypoints and the edges

get_hypergraph.m
- construct the graph and the hypergraph whose nodes represent an edge
- input the prior probability of the transition between edges
- save 'Gr' to graphInfo_*.mat and save 'attr' to attr_*.mat for later use

getseq.m
- generate sequences based on the graph configuration and the transition
probability
- filter the generated sequences by their lengths


const_subgraph.m
- if the waypoints are for the entire map, but you'd like to set a graph/hypergraph
based on the subset of the edges and the waypoints
- provide the indices of the waypoints and of the portal in the subgraph
- based on generated sequences, redo the indexing based on the subgraph info


P.S.:
- constrain the probability of 'return behavior' which means the agents 
visit 'a' then 'b' and back to 'a'.



Wenxi
July, 2nd, 2014
