module Route.ProjectsRoute exposing (ProjectsRoute(..), fromString)

import Parser as Parser exposing (Parser, run, oneOf, keyword, map)


type ProjectsRoute
    = NeighborhoodHere
    | SymbolRecognition
    | SailfishOS
    | NotFound


matchRoute : Parser ProjectsRoute
matchRoute =
    oneOf
        [ Parser.map (\_ -> NeighborhoodHere) (keyword "neighborhood-here")
        , Parser.map (\_ -> SymbolRecognition) (keyword "symbol-recognition")
        , Parser.map (\_ -> SailfishOS) (keyword "sailfish-design-study")
        ]


fromString : String -> ProjectsRoute
fromString articleString =
    case Parser.run matchRoute articleString of
        Ok article ->
            article

        Err _ ->
            NotFound
