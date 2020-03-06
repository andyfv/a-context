module Page exposing 
    ( view
    , viewNotFound
    , viewContent
    , viewCards
    , viewCard
    , viewCardImage
    , viewCardInfo
    )

import Browser 
import Browser.Dom exposing (Viewport)
import Html exposing (..)
import Html.Attributes exposing (..)
import Route.Route exposing (Route(..))
import Article exposing (Article, ArticleCard, Image)
import Center


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
                [ h1 [] [ text "Page Not Found"] 
                , a [ href "/" ] [ text "Go to Home Page"]
                ]
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
        , viewNavBar page
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
viewNavBar page =
    nav [ id "nav-links" ]
        [ ol []
            [ viewLink page Home "Home" "/"
            , viewLink page Mindstorms "Mindstorms" "/mindstorms"
            , viewLink page Projects "Projects" "/projects"
            , viewLink page About "About" "/about"
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
        --, Center.markdown "800px" articleText 
        ]


{- FOOTER -}

viewFooter : Html msg
viewFooter = 
    div [ id "footer" ]
        []
