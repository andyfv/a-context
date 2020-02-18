module Route exposing (Route(..), fromUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)
import Browser.Navigation as Nav
import Article as Article exposing (..)


type Route
    = Home
    | Mindstorms
    | MindstormsArticle String
    | Projects
    | ProjectsArticle String
    | About
    | NotFound


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Mindstorms (s "mindstorms")
        , Parser.map MindstormsArticle (s "mindstorms" </> string)
        , Parser.map Projects (s "projects")
        , Parser.map ProjectsArticle (s "projects" </> string)
        , Parser.map About (s "about")
        ]


fromUrl : Url -> Route
fromUrl url =
    case Parser.parse matchRoute url of
        Just route ->
            route

        Nothing ->
            NotFound


pushUrl : Route -> Nav.Key -> Cmd msg
pushUrl route navKey =
    routeToString route
        |> Nav.pushUrl navKey


routeToString : Route -> String
routeToString page =
    case page of 
        Home ->
            "/"

        Mindstorms ->
            "/mindstorms"

        Projects ->
            "/projects"

        About ->
            "/about"

        MindstormsArticle article ->
            "/mindstorms/" ++ article

        ProjectsArticle article ->
            "/projects/" ++ article

        NotFound -> 
            "/not-found"




-- INTERNAL

--routeToString : Route -> String
--routeToString page =
--    "#/" ++ String.join "/" (routeToPieces page)



-- PUBLIC HELPERS

-- href: Route -> Element msg

-- replaceUrl : Nav.Key -> Route -> Cmd msg