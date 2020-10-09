module Page.Home exposing (Model, Msg, view, init, update)

import Html exposing (Html)
import Article exposing (Article, ArticleCard, Image)
import Page exposing (viewCards)

import Projects.NeighborhoodHere as NH
import Projects.SymbolRecognition as SR
import Projects.SailfishOS as SOS
import Projects.DiscoverSofia as DS



-- MODEL


type alias Model =
    { articles : List ArticleCard 
    }


init : (Model, Cmd msg)
init =
    ( { articles = 
        [ Article.getCard DS.article
        , Article.getCard NH.article
        , Article.getCard SR.article
        , Article.getCard SOS.article
        ]
      }
    , Cmd.none    
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)



-- VIEW


view : Model -> Html msg
view model  =
    viewCards model.articles
