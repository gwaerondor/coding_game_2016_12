-module(erolars).
-author(erolars).
-export([construct_tree/1, merge_intervals/1]).
-record(node, {value,
	       left = 'NULL',
	       right = 'NULL'}).

merge_intervals(Short_list) when length(Short_list) < 2 ->
    Short_list;
merge_intervals([L = {L_min, L_max}, R = {R_min, R_max} | Rest]) ->
    case are_overlapping(L, R) of
	true ->
	    Min = min(L_min, R_min),
	    Max = max(L_max, R_max),
	    Merged = {Min, Max},
	    merge_intervals([Merged | Rest]);
	false ->
	    [L | merge_intervals([R | Rest])]
    end.

are_overlapping({Left_min, Left_max}, {Right_min, Right_max}) ->
    Right_min =< Left_max andalso Right_max >= Left_min.

construct_tree([Root | Rest]) ->
    Root_node = #node{value = Root},
    Tree = construct_tree(Rest, Root_node),
    tree_to_tuple(Tree).
   
construct_tree([], Tree) ->
    Tree;
construct_tree([Value | Rest], Tree) ->
    Updated_tree = insert(Value, Tree),
    construct_tree(Rest, Updated_tree).
    
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
