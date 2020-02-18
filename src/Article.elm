module Article exposing (Article, Image, getTitle)

import Html exposing (Html)
import Url.Parser exposing (Parser, custom, string)
import Markdown as Md exposing (..)

type alias Article =
    { title : String
    , date : String
    , image : Image
    , content : String
    , href : String
    , summary : String
    }



type alias Image =
    { src : String
    , description : String
    }

--titleParser : Parser (String -> a) a
--titleParser =
--    custom "ARTICLE" <| \title -> Maybe.map string title


getTitle : Article -> String
getTitle article =
   article.title