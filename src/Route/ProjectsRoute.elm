module Route.ProjectsRoute exposing (ProjectsRoute(..), fromString)

import Parser as Parser exposing (Parser, run, oneOf, keyword, map)


type ProjectsRoute
    = NeighborhoodHere
    | SymbolRecognition
    | SailfishOS
    | DiscoverSofia
    | NotFound


matchRoute : Parser ProjectsRoute
matchRoute =
    oneOf
        [ Parser.map (\_ -> NeighborhoodHere) (keyword "neighborhood-here")
        , Parser.map (\_ -> SymbolRecognition) (keyword "symbol-recognition")
        , Parser.map (\_ -> SailfishOS) (keyword "sailfish-design-study")
        , Parser.map (\_ -> DiscoverSofia) (keyword "discover-sofia")
        ]


fromString : String -> ProjectsRoute
fromString articleString =
    case Parser.run matchRoute articleString of
        Ok article ->
            article

        Err _ ->
            NotFound
