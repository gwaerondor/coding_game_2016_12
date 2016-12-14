-module(tree_construction).
-export([construct/1]).
-record(node, {value, left, right}).

construct([Root | Rest]) ->
    Root_node = #node{value = Root},
    construct(Rest, Root_node).
   
construct([], Tree) ->
    Tree;
construct([Current | Rest], Tree) ->
    Node = #node{value = Current},
    Updated_tree = insert(Node, Tree),
    construct(Rest, Updated_tree).
    
insert(Node, Tree) ->
    ok.
