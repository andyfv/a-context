module Page.Mindstorms exposing (Model, Msg, view, init, update)


import Browser 
import Route exposing (Route)
import Article exposing (Article, ArticleCard, Image)
import TestArticle exposing (article)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)


-- MODEL


type alias Model =
    { articles : List ArticleCard 
    }


init : (Model, Cmd msg)
init =
    ( { articles = 
        [ Article.getCard TestArticle.article
        , Article.getCard TestArticle.article
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