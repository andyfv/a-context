module Page exposing 
    ( view
    , viewNotFound
    , viewContent
    , viewCards
    , viewCard
    , viewCardImage
    , viewCardInfo
    , Config
    )

import Browser 
import Html exposing (..)
import Html.Attributes exposing (..)
import Route.Route exposing (Route(..))
import Article exposing (Article, ArticleCard, Image)
import Header exposing (viewNavBar)


type alias Config msg =
    { route : Route
    , content : Html msg
    , header : Html msg
    , isMenuOpen : Bool 
    }


view : Config msg -> Browser.Document msg
view ({ route, content, header, isMenuOpen }) = 
    { title = "Z Context"
    , body = 
        header
        :: viewContent content isMenuOpen route
        :: [ viewFooter ]
    }


viewNotFound : Html msg
viewNotFound =
    div [ id "page-not-found" ] 
        [ h1 [] [ text "Page Not Found"] 
        , a [ href "/" ] [ text "Go to Home Page"]
        ]



{- HEADER -}

viewHeaderWrapper : Route -> Viewport -> Html msg
viewHeaderWrapper route viewport =
    if viewport.viewport.width > 650 then
        div 
            [ classList 
                [ ("header-wrapper", True)
                , ("header-bg-scroll", True)
                ] 
            ]
            [ viewHeader route ]
    else 
        viewMobileHeader route


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



{- CONTENT -}

viewContent : Html msg -> Bool -> Route -> Html msg
viewContent content isMenuOpen route =
    if isMenuOpen == True then
        div [ id "content" ]
            [ content 
            , showMenu route
            ]
    else 
        div [ id "content" ]
            [ content ]


showMenu : Route -> Html msg
showMenu route =
    div [ id "menu" ]
        [ viewNavBar route ]



viewCards :  List ArticleCard -> Html msg
viewCards articles =
    div [ id "view-cards" ] ( List.map viewCard articles )


viewCard : ArticleCard -> Html msg
viewCard article =
    a 
        [ class "view-card"
        , href article.href
        ]
        [ viewCardImage article.image
        , viewCardInfo article
        ]


viewCardImage : Image -> Html msg
viewCardImage image =
    div [ class "card-image-wrapper" ]
        [ img 
            [ class "card-image" 
            , src image.src
            , alt image.description
            ]
            []
        ]


viewCardInfo : ArticleCard -> Html msg
viewCardInfo article =
    div [ class "card-info" ]
        [ h3 [ class "card-info-header" ] [ text article.title ] 
        , div [ class "card-info-date" ] [ text article.date ]
        ]
    

{- Article Template -}

viewArticle : Article -> Html msg
viewArticle article =
    div [ class "article" ]
        [ h1 [] [ text (Article.getTitle article) ]
        , h3 [] [ text (Article.getSubtitle article) ]
        , h5 [] [ text (Article.getDate article) ]
        ]


{- FOOTER -}

viewFooter : Html msg
viewFooter = 
    div [ id "footer" ]
        []
