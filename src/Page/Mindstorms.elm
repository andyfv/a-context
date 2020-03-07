module Page.Mindstorms exposing (Model, Msg, view, init, update)

import Url exposing (Url)
import Browser
import Browser.Navigation as Nav
import Article exposing (Article, ArticleCard, Image)
import Route.Route as Route exposing (Route)
import Page as Page exposing (viewCards)

import Mindstorms.Learning as Learning exposing (..)


-- MODEL

type alias Model =
    { articles : List ArticleCard }


init : (Model, Cmd Msg)
init =
    ( { articles = 
        [ Article.getCard Learning.article
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
    Page.view Route.Mindstorms (viewCards model.articles)