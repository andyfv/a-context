module Route.MindstormsRoute exposing (MindstormsRoute(..), fromString)

import Parser as Parser exposing (Parser, run, oneOf, keyword, map)


type MindstormsRoute
    = Learning
    | NotFound


matchRoute : Parser MindstormsRoute
matchRoute =
    oneOf
        [ Parser.map (\_ -> Learning) (keyword "learning")
        ]


fromString : String -> MindstormsRoute
fromString articleString =
    case Parser.run matchRoute articleString of
        Ok article ->
            article

        Err _ ->
            NotFound
