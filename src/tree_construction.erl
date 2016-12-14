-module(tree_construction).
-export([construct/1]).
-record(node, {value,
	       left = 'NULL',
	       right = 'NULL'}).

construct([Root | Rest]) ->
    Root_node = #node{value = Root},
    Tree = construct(Rest, Root_node),
    tree_to_tuple(Tree).
   
construct([], Tree) ->
    Tree;
construct([Current | Rest], Tree) ->
    Node = #node{value = Current},
    Updated_tree = insert(Node, Tree),
    construct(Rest, Updated_tree).
    
insert(New_node, 'NULL') ->
    New_node;
insert(New_node, Tree) ->
    case New_node#node.value > Tree#node.value of
	true ->
	    Left = Tree#node.left,
	    Tree#node{left = insert(New_node, Left)};
	false ->
	    Right = Tree#node.right,
	    Tree#node{right = insert(New_node, Right)}
    end.	    

tree_to_tuple('NULL') ->
    'NULL';
tree_to_tuple(Node) ->
    Left = Node#node.left,
    Right = Node#node.right,
    Value = Node#node.value,
    {tree_to_tuple(Left), Value, tree_to_tuple(Right)}.
