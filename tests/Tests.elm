module Tests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import LSystem
import Test exposing (..)


type State
    = A
    | B

rule : LSystem.Rule State
rule state =
    case state of
        A ->
            [ A, B ]

        B ->
            [ A ]

suite : Test
suite =
    describe "The LSystem Module"
        [ test "can perform deterministic generative rules" <|
            \_ ->
                Expect.equal [ A, B, A, A, B ] <|
                    LSystem.apply rule <| LSystem.apply rule [ A, B ]
        ]

