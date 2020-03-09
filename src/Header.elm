module Header exposing (Model, Msg(..), init, update, view ,viewNavBar)

import Task
import Browser.Dom exposing (Viewport, getViewport)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Route.Route exposing (Route(..))



-- MODEL

type alias Model =
    { viewport : Viewport
    , isMenuOpen : Bool
    }


init : (Model, Cmd Msg)
init =
    (
    { viewport = 
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
    case msg of
        MenuButtonClicked ->
            ({ model | isMenuOpen = not model.isMenuOpen }, Cmd.none)

        ViewportChanged ->
            (model, Task.perform ViewportSize getViewport)

        ViewportSize vp ->
            ({ model | viewport = vp }, Cmd.none)



-- VIEW

view : Route -> Model -> Html Msg
view route ({ viewport, isMenuOpen }) =
    if viewport.viewport.width > 650 
    then viewDesktopHeader route
    else viewMobileHeader route


-- MOBILE

viewMobileHeader : Route -> Html Msg
viewMobileHeader route =
    div [ class "header" ]
        [ logo
        , viewMenuButton route
        ]

viewMenuButton : Route -> Html Msg
viewMenuButton route =
    button 
        [ id "menu-button"
        , onClick MenuButtonClicked 
        ]
        [ img [ src "/img/menu_icon_dark.svg", id "menu-icon" ] []
        ]


-- DESKTOP

viewDesktopHeader : Route -> Html msg
viewDesktopHeader route =
    div 
        [ classList 
            [ ("header-wrapper", True)
            , ("header-bg-scroll", True)
            ] 
        ]
        [ viewHeader route ]


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
        [ ul []
            [ viewLink route Home "Home" "/"
            , viewLink route Mindstorms "Mindstorms" "/mindstorms"
            , viewLink route Projects "Projects" "/projects"
            , viewLink route About "About" "/about"
            ]
        ]


-- COMMON

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

