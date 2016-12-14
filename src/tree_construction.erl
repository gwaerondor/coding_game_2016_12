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
construct([Value | Rest], Tree) ->
    Updated_tree = insert(Value, Tree),
    construct(Rest, Updated_tree).
    
insert(New_value, 'NULL') ->
    #node{value = New_value};
insert(New_value, Tree) ->
    case New_value > Tree#node.value of
	true ->
	    Left_subtree = Tree#node.left,
	    Tree#node{left = insert(New_value, Left_subtree)};
	false ->
	    Right_subtree = Tree#node.right,
	    Tree#node{right = insert(New_value, Right_subtree)}
    end.	    

tree_to_tuple('NULL') ->
    'NULL';
tree_to_tuple(Node) ->
    Left = Node#node.left,
    Right = Node#node.right,
    Value = Node#node.value,
    {tree_to_tuple(Left), Value, tree_to_tuple(Right)}.
