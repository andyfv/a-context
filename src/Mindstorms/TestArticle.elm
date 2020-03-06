module Mindstorms.TestArticle exposing (article, content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown 
import Article exposing (..)
import Center
import Browser
import Page as Page exposing (..)
import Route.Route exposing (Route(..))


articleView = Page.view Mindstorms content

article : Article
article = Article.getArticle
    { title = "Test Article"
    , subtitle = "Just trying out what will happen"
    , date = "18 Feb 2020"
    , image = (Image "/img/turtle.png" "Turtle")
    , href = "mindstorms/test-article"
    , summary = ""
    }


content : Html msg
content = 
    div []
        [ Center.markdown "600px" text
        ]


text : String 
text =
    """
        The eternal idea of knowledge.
    """