-module(tree_construction_tests).
-include_lib("eunit/include/eunit.hrl").

first_test() ->
    L = [2],
    Expected = {'NULL', 2, 'NULL'},
    Actual = tree_construction:construct(L),
    ?assertEqual(Expected, Actual).

second_test() ->
    L = [2,4,1],
    Expected = {{'NULL', 4, 'NULL'}, 2, {'NULL', 1, 'NULL'}},
    Actual = tree_construction:construct(L),
    ?assertEqual(Expected, Actual).

third_test() ->
    L = [4,1,3,2,5],
    Expected = {{'NULL', 5, 'NULL'}, 4, {{'NULL', 3, {'NULL', 2, 'NULL'}},1, 'NULL'}},
    Actual = tree_construction:construct(L),
    ?assertEqual(Expected, Actual).
