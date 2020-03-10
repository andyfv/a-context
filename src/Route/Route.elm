module Route.Route exposing (Route(..), fromUrl, internalLink, absoluteLink)

import Url exposing (Url)
import Url.Builder exposing (relative, absolute)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)
import Browser.Navigation as Nav


type Route
    = Home
    | Mindstorms
    | MindstormArticle String
    | Projects
    | ProjectsArticle String
    | About
    | NotFound


gitHubBase : String
gitHubBase =
    "z-context"


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Home (s gitHubBase)
        , Parser.map Mindstorms (s gitHubBase </> s "mindstorms")
        , Parser.map MindstormArticle (s gitHubBase </> s "mindstorms" </> string)
        , Parser.map Projects (s gitHubBase </> s "projects")
        , Parser.map ProjectsArticle (s gitHubBase </> s "projects" </> string)
        , Parser.map About (s gitHubBase </> s "about")
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


routeToPieces : Route -> String
routeToPieces route =
    case route of 
        Home ->
            ""

        Mindstorms ->
            "/mindstorms"

        Projects ->
            "/projects"

        About ->
            "/about"

        MindstormArticle article ->
            "/mindstorms/" ++ article

        ProjectsArticle article ->
            "/projects/" ++ article

        NotFound -> 
            "/not-found"


routeToString : Route -> String
routeToString page =
    "#/" ++ (routeToPieces page)


-- LINKS

internalLink : String -> String
internalLink path =
    absolute [ gitHubBase, String.dropLeft 1 path ] []


absoluteLink : String -> String
absoluteLink path =
    absolute [ path ] []

