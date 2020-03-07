module Page.Home exposing (Model, Msg, view, init, update)

import Browser
import Route.Route exposing (Route)
import Article exposing (Article, ArticleCard, Image)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)

import Projects.NeighborhoodHere as NH exposing (..)
import Projects.SymbolRecognition as SR exposing (..)
import Projects.SailfishOS as SOS exposing (..)



-- MODEL


type alias Model =
    { articles : List ArticleCard 
    }


init : (Model, Cmd msg)
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


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)



-- VIEW


view : Route -> Model -> Browser.Document msg
view route model =
    Page.view route (viewCards model.articles)
