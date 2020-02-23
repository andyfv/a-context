module Page.Projects exposing (Model, Msg, view, init, update)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Route exposing (Route(..))
import Article exposing (Article, ArticleCard, Image)
import TestArticle exposing (article)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)



-- MODEL


type alias Model =
    { articles : List ArticleCard 
    , displayArticle : Maybe Article
    }


init : (Model, Cmd Msg)
init =
    ( { articles = 
        [ Article.getCard TestArticle.article
        ]
      , displayArticle = Nothing
      }
    , Cmd.none    
    )



-- UPDATE


type Msg
    = ClickedArticle


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ClickedArticle ->
            (model, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
    case model.displayArticle of 
        Just article ->
            text ""

        Nothing ->
            viewCards model.articles