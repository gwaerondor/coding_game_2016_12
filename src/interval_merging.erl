-module(interval_merging).
-author(erolars).
-export([merge/1, are_overlapping/2]).

merge(Short_list) when length(Short_list) < 2 ->
    Short_list;
merge([L = {L_min, L_max}, R = {R_min, R_max} | Rest]) ->
    case are_overlapping(L, R) of
	true ->
	    Min = min(L_min, R_min),
	    Max = max(L_max, R_max),
	    Merged = {Min, Max},
	    merge([Merged | Rest]);
	false ->
	    [L | merge([R | Rest])]
    end.

are_overlapping({Left_min, Left_max}, {Right_min, Right_max}) ->
    Right_min =< Left_max andalso Right_max >= Left_min.
