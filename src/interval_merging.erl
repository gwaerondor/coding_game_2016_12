-module(interval_merging).
-export([merge/1, are_overlapping/2]).

merge(Short_list) when length(Short_list) < 2 ->
    Short_list;
merge([L = {L_min, _}, R = {_, R_max} | Rest]) ->
    case are_overlapping(L, R) of
	true ->
	    Merged = {L_min, R_max},
	    merge([Merged | Rest]);
	false ->
	    [L | merge([R | Rest])]
    end.

are_overlapping({Left_min, Left_max}, {Right_min, Right_max}) ->
    Right_min =< Left_max andalso Right_max >= Left_min.
	
