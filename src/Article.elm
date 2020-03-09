module Article exposing 
    ( Article
    , ArticleStructure
    , Image
    , ArticleCard
    , getArticle
    , getSubtitle
    , getTitle
    , getDate
    , getHref
    , getSummary
    , getImageSrc
    , getCard
    )


import Html exposing (Html)


type alias ArticleStructure =
    { title : String
    , subtitle : String
    , date : String
    , image : Image
    , href : String
    , summary : String
    }


type Article  = 
    Article ArticleStructure


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


-- OPERATIONS

getArticle : ArticleStructure -> Article
getArticle info =
    Article info

getTitle : Article -> String
getTitle ( Article { title } ) =
    title

getSubtitle : Article -> String
getSubtitle ( Article { subtitle } ) =
    subtitle

getDate : Article -> String
getDate ( Article { date } ) =
    date

getHref : Article -> String
getHref ( Article { href } ) =
    href

getSummary : Article -> String
getSummary ( Article { summary } ) =
    summary

getImageSrc : Article -> String 
getImageSrc ( Article { image } ) =
    imageSrc image

imageSrc : Image -> String
imageSrc image =
    image.src



getCard : Article -> ArticleCard
getCard (Article { title, date, image, href } ) =
    ArticleCard
        title
        date
        image
        href


--titleParser : Parser (String -> a) a
--titleParser =
--    custom "ARTICLE" <| \title -> Maybe.map string title
