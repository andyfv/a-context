module TestArticle exposing (article, content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown 
import Article exposing (..)
import Center
import Browser
import Page as Page exposing (..)
import Route exposing (Route(..))


articleView = Page.view Mindstorms content

article : Article
article = Article 
    "Test Article"
    "Just trying out what will happen"
    "18 Feb 2020"
    (Image "/img/turtle.png" "Turtle") 
    content
    "mindstorms/test-article"
    ""


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