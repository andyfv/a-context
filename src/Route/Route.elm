module Route.Route exposing (Route(..), fromUrl)

import Url exposing (Url)
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


gitHubBase : Parser a a
gitHubBase =
    s "z-context"


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Mindstorms ( gitHubBase </> s "mindstorms")
        , Parser.map MindstormArticle (gitHubBase </> s "mindstorms" </> string)
        , Parser.map Projects (gitHubBase </> s "projects")
        , Parser.map ProjectsArticle (gitHubBase </> s "projects" </> string)
        , Parser.map About ( gitHubBase </> s "about")
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



-- PUBLIC HELPERS

-- href: Route -> Element msg

-- replaceUrl : Nav.Key -> Route -> Cmd msg