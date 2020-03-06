module Page.Projects exposing (Model, Msg, view, init, update)


import Browser
import Route.Route as Route exposing (Route(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Article exposing (Article, ArticleCard, Image)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)

import Projects.NeighborhoodHere as NH
import Projects.SymbolRecognition as SR
import Projects.SailfishOS as SOS




-- MODEL


type alias Model =
    { articles : List ArticleCard 
    }


init : (Model, Cmd Msg)
init =
    ( { articles = 
        [ Article.getCard NH.article
        , Article.getCard SR.article
        , Article.getCard SOS.article
        ]
      }
    , Cmd.none    
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)



-- VIEW


view : Route -> Model -> Browser.Document msg
view route model =
    Page.view Route.Projects (viewCards model.articles)