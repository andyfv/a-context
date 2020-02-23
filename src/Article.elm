module Article exposing (Article, Image, ArticleCard, getCard)

import Html exposing (Html)
import Url.Parser exposing (Parser, custom, string)
import Markdown as Md exposing (..)

type Msg
    = LinkClicked

type alias Article =
    { title : String
    , subtitle : String
    , date : String
    , image : Image
    , content : Html Msg
    , href : String
    , summary : String
    }


type alias ArticleCard =
    { title : String
    , date : String
    , image : Image
    , href : String
    }


type alias Image =
    { src : String
    , description : String
    }


type Content msg = Content (Html msg)

--titleParser : Parser (String -> a) a
--titleParser =
--    custom "ARTICLE" <| \title -> Maybe.map string title


getCard : Article -> ArticleCard
getCard article =
    ArticleCard
        article.title
        article.date
        article.image
        article.href




--type alias Article =
--    { title : String
--    , image : Image
--    , href : String
--    , summary : String
--    , date : String
--    }

--type alias Image =
--    { src : String
--    , description : String
--    }
--[ ArticleCard article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        --, Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        --, Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        --, Article "Testing my article right now is not very good" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        --, Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        --, Article "Testing my article" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"
        --, Article "Testing my article right now is not very good" (Image "/img/turtle.png" "Alan Kay") "/mindstorms/test_arcticle" "Just some test text" "07 Feb 2020"