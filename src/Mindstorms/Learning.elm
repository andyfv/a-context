module Mindstorms.Learning exposing (Model, Msg, view, init, update, article)

import Center
import Markdown
import Article exposing (..)
import Html exposing (Html, div, h1, h3, h4, h5, text, hr)
import Html.Attributes exposing (id, class)


-- MODEL


article : Article
article =
    getArticle 
        { title = "Learning Article"
        , subtitle = "Just trying out what will happen"
        , date = "18 Feb 2020"
        , image = Image "/img/turtle.png" "Turtle"
        , href = "mindstorms/learning"
        , summary = ""
        }


type alias Model = 
    { }


init : (Model, Cmd msg)
init =
    ({ }, Cmd.none)


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
view model = articleBody article


articleBody : Article -> Html msg
articleBody a = 
    div [ class "article" ]
        [ h1 [ class "article-title" ] [ text (Article.getTitle a) ]
        , h3 [ class "article-subtitle" ] [ text (Article.getSubtitle a) ]
        , h5 [ class "article-date" ] [ text (Article.getDate a) ]
        , hr [] []
        , Center.markdown "800px" articleText
        ]



articleText : String 
articleText = """

The eternal idea of knowledge.

"""


