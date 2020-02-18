module Page.Home exposing (Model, Msg, view, init, update)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
--import Skeleton exposing (..)
import Route exposing (Route(..))
import Page as Page exposing (..)
import Article exposing (Article, Image)


-- MODEL


type alias Model =
    { articles : List Article }



type alias Article =
    { title : String
    , image : Image
    , href : String
    , summary : String
    , date : String
    }

type alias Image =
    { src : String
    , description : String
    }



init : (Model, Cmd Msg)
init =
    ( { articles = 
        [ Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        , Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        , Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        , Article "Testing my article right now is not very good" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        , Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        , Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        , Article "Testing my article right now is not very good" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        ] 
      }
    , Cmd.none    
    )



-- UPDATE


type Msg
    = ClickedTag


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ClickedTag ->
            (model, Cmd.none)



-- VIEW


view : Model -> Html msg
view model =
    viewCards model.articles


viewCards :  List Article -> Html msg
viewCards articles =
    div [ id "view-cards" ] ( List.map viewCard articles )


viewCard : Article -> Html msg
viewCard article =
    section [ class "view-card" ]
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


viewCardInfo : Article -> Html msg
viewCardInfo article =
    div [ class "card-info" ]
        [ h3 [ class "card-info-header" ] [ text article.title ]
        , div [ class "card-info-date" ] [ text article.date]
        ]
    