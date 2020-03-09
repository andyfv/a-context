module Header exposing (Model, Msg(..), init, update, view)

import Task
import Browser.Dom exposing (Viewport, getViewport)
import Html exposing (..)
import Html.Attributes exposing (..)
import Route.Route exposing (Route(..))



-- MODEL


type alias Model =
    { route : Route
    , viewport : Viewport
    , isMenuOpen : Bool
    }


init : Route -> (Model, Cmd Msg)
init route =
    (
    { route = route
    , viewport = 
        { scene = { width = toFloat 0, height = toFloat 0 }
        , viewport = 
            { x = toFloat 0
            , y = toFloat 0
            , width = toFloat 0
            , height = toFloat 0
            }
        }
    , isMenuOpen = False
    }
    , Task.perform ViewportSize getViewport
    )


-- UPDATE


type Msg
    = MenuButtonClicked

    -- VIEWPORT
    | ViewportSize Viewport
    | ViewportChanged


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let 
        _ = Debug.log "model" model 
    in
    case msg of
        MenuButtonClicked ->
            let 
                _ = Debug.log "menuButton" "clicked"
            in
            (model, Cmd.none)

        ViewportChanged ->
            (model, Task.perform ViewportSize getViewport)

        ViewportSize vp ->
            ({ model | viewport = vp }, Cmd.none)



-- VIEW

view : Model -> Html msg
view ({ route, viewport, isMenuOpen }) =
    if viewport.viewport.width > 650 
    then viewDesktopHeader route
    else viewMobileHeader route


viewDesktopHeader : Route -> Html msg
viewDesktopHeader route =
    div 
        [ classList 
            [ ("header-wrapper", True)
            , ("header-bg-scroll", True)
            ] 
        ]
        [ viewHeader route ]


viewMobileHeader : Route -> Html msg
viewMobileHeader route =
    div [ class "header" ]
        [ logo
        , viewMenuButton route
        ]

viewMenuButton : Route -> Html msg
viewMenuButton route =
    button [ id "menu-button" ]
        [ img [ src "/img/menu_icon_dark.svg", id "menu-icon" ] []
        ]

viewHeader : Route -> Html msg
viewHeader route = 
    div [ class "header"] 
        [ logo
        , viewNavBar route
        ]


logo : Html msg
logo =
    a [ href "/"]
        [ node "picture" [ id "header-icon" ]
            [ source 
                [ media "(max-width: 750px)"
                , attribute "srcset" "/img/icon_mobile_dark.svg"
                ] 
                []
            , source 
                [ media "(min-width: 751px)"
                , attribute "srcset" "/img/blog_desktop_dark.svg"
                ] 
                []
            , img [ src "/img/icon_mobile_dark.svg", alt "logo"] []
            ] 
        ]


viewNavBar : Route -> Html msg
viewNavBar route =
    nav [ id "nav-links" ]
        [ ol []
            [ viewLink route Home "Home" "/"
            , viewLink route Mindstorms "Mindstorms" "/mindstorms"
            , viewLink route Projects "Projects" "/projects"
            , viewLink route About "About" "/about"
            ]
        ]



viewLink : Route -> Route -> String -> String -> Html msg
viewLink currentTab targetTab name link =
    let 
        attrs =
            if currentTab == targetTab then
                [ class "selected-nav-link" ]
            else
                []
    in
    li [] [ a (href link :: attrs) [ text name ] ]

