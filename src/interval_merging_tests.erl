-module(interval_merging_tests).
-include_lib("eunit/include/eunit.hrl").

first_test() ->
    L = [{1,5}, {3,7}, {10,14}],
    Expected = [{1,7}, {10,14}],
    Actual = interval_merging:merge(L),
    ?assertEqual(Expected, Actual).

second_test() ->
    L = [{1,5}, {3,7}, {10,14}, {1,9}, {13, 20}],
    Expected = [{1,7}, {10,14}, {1,9}, {13, 20}],
    Actual = interval_merging:merge(L),
    ?assertEqual(Expected, Actual).

third_test() ->
    L = [{1, 5}, {3, 7}, {1, 14}],
    Expected = [{1,14}],
    Actual = interval_merging:merge(L),
    ?assertEqual(Expected, Actual).

fourth_test() ->
    L = [{1, 10}, {2, 3}, {4, 5}],
    Expected = [{1, 10}],
    Actual = interval_merging:merge(L),
    ?assertEqual(Expected, Actual).

are_overlapping_test_() ->
    [fun left_max_lower_than_right_min_no_overlap/0,
     fun left_max_higher_than_right_min_overlaps/0,
     fun left_max_and_min_higher_than_right_min_no_overlap/0,
     fun right_is_contained_in_left/0,
     fun left_is_contained_in_right/0].

left_max_lower_than_right_min_no_overlap() ->
    L = {1, 7},
    R = {8, 9},
    Result = interval_merging:are_overlapping(L, R),
    ?assertNot(Result).

left_max_higher_than_right_min_overlaps() ->
    L = {1, 10},
    R = {5, 15},
    Result = interval_merging:are_overlapping(L, R),
    ?assert(Result).

left_max_and_min_higher_than_right_min_no_overlap() ->
    L = {1000, 1001},
    R = {1, 2},
    Result = interval_merging:are_overlapping(L, R),
    ?assertNot(Result).

left_is_contained_in_right() ->
    L = {2, 3},
    R = {1, 4},
    Result = interval_merging:are_overlapping(L, R),
    ?assert(Result).

right_is_contained_in_left() ->
    L = {10, 40},
    R = {20, 30},
    Result = interval_merging:are_overlapping(L, R),
    ?assert(Result).
