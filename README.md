# elm-LSystem

Implementation of L-Systems in Elm. Given a set of states and a ruleset:

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

We can generate a new state based on these:

`[A]` => `[A, B]`

`[A, B]` => `[A, B, A]`

`[A, B, A]` => `[A, B, A, A, B]`

# Install

    elm install Spaxe/elm-lsystem

# Documentation

See the documentation on elm docs at http://package.elm-lang.org/packages/Spaxe/elm-lsystem/latest/LSystem
