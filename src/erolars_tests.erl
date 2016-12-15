-module(erolars_tests).
-author(erolars).
-include_lib("eunit/include/eunit.hrl").

tree_with_one_element_test() ->
    L = [2],
    Expected = {'NULL', 2, 'NULL'},
    Actual = erolars:construct_tree(L),
    ?assertEqual(Expected, Actual).

tree_with_three_elements_test() ->
    L = [2,4,1],
    Expected = {{'NULL', 4, 'NULL'}, 2, {'NULL', 1, 'NULL'}},
    Actual = erolars:construct_tree(L),
    ?assertEqual(Expected, Actual).

tree_with_five_elements_test() ->
    L = [4,1,3,2,5],
    Expected = {{'NULL', 5, 'NULL'}, 4, {{'NULL', 3, {'NULL', 2, 'NULL'}},1, 'NULL'}},
    Actual = erolars:construct_tree(L),
    ?assertEqual(Expected, Actual).

first_interval_test() ->
    L = [{1,5}, {3,7}, {10,14}],
    Expected = [{1,7}, {10,14}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

second_interval_test() ->
    L = [{1,5}, {3,7}, {10,14}, {1,9}, {13, 20}],
    Expected = [{1,7}, {10,14}, {1,9}, {13, 20}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

third_interval_test() ->
    L = [{1, 5}, {3, 7}, {1, 14}],
    Expected = [{1,14}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

fourth_interval_test() ->
    L = [{1, 10}, {2, 3}, {4, 5}],
    Expected = [{1, 10}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

overlapping_test_() ->
    [fun left_max_lower_than_right_min_no_overlap/0,
     fun left_max_higher_than_right_min_overlaps/0,
     fun left_max_and_min_higher_than_right_min_no_overlap/0,
     fun right_is_contained_in_left/0,
     fun left_is_contained_in_right/0].

left_max_lower_than_right_min_no_overlap() ->
    L = [{1, 7}, {8, 9}],
    Expected = [{1, 7}, {8, 9}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

left_max_higher_than_right_min_overlaps() ->
    L = [{1, 10}, {5, 15}],
    Expected = [{1, 15}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

left_max_and_min_higher_than_right_min_no_overlap() ->
    L = [{1000, 1001}, {1, 2}],
    Expected = [{1000, 1001}, {1, 2}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

left_is_contained_in_right() ->
    L = [{2, 3}, {1, 4}],
    Expected = [{1, 4}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).

right_is_contained_in_left() ->
    L = [{10, 40}, {20, 30}],
    Expected = [{10, 40}],
    Actual = erolars:merge_intervals(L),
    ?assertEqual(Expected, Actual).
