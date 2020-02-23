module Page.MindstormArticle exposing (Model, Msg, view, init, update)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Route exposing (Route(..))
import Article exposing (Article, ArticleCard, Image)
import TestArticle exposing (article)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)



-- MODEL

type MindstormArticle 
    = Learning
    | NotFound


type alias Model =
    { article : MindstormArticle
    }


init : Html msg -> (Model, Cmd Msg)
init article =
    ( { article = NotFound
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


view : Model -> Html Msg
view model =
    viewCards model.article
