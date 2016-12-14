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
