module Page exposing (view, viewNotFound)

import Browser 
import Browser.Dom exposing (Viewport)
import Html exposing (..)
import Html.Attributes exposing (..)
import Route exposing (Route(..))


view : Route -> Html msg -> Browser.Document msg
view page content = 
    { title = "Z Context"
    , body = viewHeaderWrapper page :: viewContent content :: [ viewFooter ]
    }


viewNotFound : Browser.Document msg
viewNotFound =
    { title = "Z Context"
    , body = 
            [ div [ id "page-not-found" ] 
                [ h1 [] [ text "Page Not Found"] ] 
            ]
    }



{- HEADER -}

viewHeaderWrapper : Route -> Html msg
viewHeaderWrapper page =
    div 
        [ classList 
            [ ("header-wrapper", True)
            , ("header-bg-scroll", True)
            ] 
        ]
        [ viewHeader page ]


viewHeader : Route -> Html msg
viewHeader page = 
    div [ class "header"] 
        [ logo
        , nav [ id "nav-links" ]
            [ ol []
                [ viewLink page Home "Home" "/"
                , viewLink page Mindstorms "Mindstorms" "/mindstorms"
                , viewLink page Projects "Projects" "/projects"
                , viewLink page About "About" "/about"
                ]
            ]
        ]


logo  : Html msg
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



{- CONTENT -}

viewContent : Html msg -> Html msg
viewContent content =
    div [ id "content"]
        [ content ]



{- FOOTER -}

viewFooter : Html msg
viewFooter = 
    div [ id "footer" ]
        []
