module LSystem.Turtle exposing (..)

{-| Turtle graphics consists of 4 states:

    type State
        = D -- | Draw forward
        | S -- | Skip foward without drawing
        | L -- | Turn left by some degrees
        | R -- | Turn right by some degrees

(In formal literature, it is known as `F`, `f`, `-`, and `+` respectively.)

Given a starting point and an angle, you can iterate through a list of `State`s
and create a generative drawing.

For example, the following ruleset applied 3 times will generate [this](https://twitter.com/Xavier_Ho/status/995651719064252416):

    rule : LSystem.Rule State
    rule state =
        case state of
            D ->
                [ D, D, R, D, L, D, R, D, R, D, D ]

            S ->
                [ S ]

            L ->
                [ L ]

            R ->
                [ R ]

If you want a complete example of how this can be used in the Elm Architecture,
see <https://github.com/creative/elm-generative/blob/master/example/Turtle.elm>


# Module functions

@docs State, turtle

-}

import List.Extra exposing (mapAccuml)
import Svg.PathD as PathD exposing (Segment)


{-| Turtle consists of 4 primary states.

  - D -- Draw forward
  - S -- Skip foward without drawing
  - L -- Turn left by some degrees
  - R -- Turn right by some degrees

We also supply additional states `A`, `B`, and `C`, which are ignored during
drawing. They are useful for constructing rulesets only.

-}
type State
    = D -- | Draw forward
    | S -- | Skip foward without drawing
    | L -- | Turn left by some degrees
    | R -- | Turn right by some degrees
    | A -- | Ignored by the drawing rules
    | B -- | Ignored by the drawing rules
    | C -- | Ignored by the drawing rules


{-| Transforms a list of `State`s into `Svg.Path` `d`-compatible property
strings. This requires a starting point and a starting angle.

You can use the `Svg.PathD` library's [`d_`](http://package.elm-lang.org/packages/spaxe/svg-pathd/1.0.1/Svg-PathD#d_)
to draw segments as a SVG attribute:

    import Svg.PathD as PathD exposing (d_)

    ...


    Svg.path
        [ d_ <| turtle [ D, R, D, R, D, R, D ] 90
        ]
        []

-}
turtle : List State -> Float -> List Segment
turtle states dAngle =
    let
        move ( x, y ) a =
            ( x + cos (degrees a), y + sin (degrees a) )

        next ( p, a ) state =
            case state of
                D ->
                    ( ( move p a, a ), [ PathD.L (move p a) ] )

                S ->
                    ( ( move p a, a ), [ PathD.M (move p a) ] )

                L ->
                    ( ( p, a - dAngle ), [] )

                R ->
                    ( ( p, a + dAngle ), [] )

                A ->
                    ( ( p, a ), [] )

                B ->
                    ( ( p, a ), [] )

                C ->
                    ( ( p, a ), [] )
    in
        List.concat (Tuple.second <| mapAccuml next ( (0, 0), 0 ) states)
