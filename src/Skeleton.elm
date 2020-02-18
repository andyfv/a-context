module Skeleton exposing
    ( Author
    , Date
    , andy
    --, news
    , skeleton
    )

import Browser
import Center
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Route exposing (Route)


-- SKELETON

skeleton : String -> Route -> List (Html Never) -> Program () () Never
skeleton title tab content =
    Browser.document
        { init = \_ -> ( (), Cmd.none)
        , update = \_ _-> ( (), Cmd.none)
        , subscriptions = \_ -> Sub.none
        , view = 
            \_ ->
                { title = title
                , body = header tab :: content ++ [ footer ]
                }
        }


-- HEADER

header : Route -> Html msg
header tab =
    div [ class "header" ]
        [ 
        ]


viewTab : Route -> Route -> String -> String -> Html msg
viewTab currentTab targetTab name link =
    let
        attrs = if
            currentTab == targetTab then
                [ style "font-weight" "bold" ]
            else
                []

    in
    a (href link :: attrs) [ text name ]


footer : Html msg
footer =
    div [ class "footer" ]
        [ a [ class "grey-link", href "github.com"] [ text "Site Source" ]
        ]





--news : String -> String -> Author -> Date -> List (Html Never) -> Program () () Never
--news title subtitle author date body =
--    skeleton title News




-- AUTHORS


type alias Author =
    { name : String
    , url : String
    }


andy : Author
andy =
    { name = "Andrea Filchev"
    , url = ""
    }


-- DATES 

type alias Date =
    { year : Int
    , month : Int
    , day : Int
    }



dateToString : Date -> String
dateToString date =
    case Dict.get date.month months of 
        Nothing ->
            String.fromInt date.year

        Just month ->
            String.fromInt date.day ++ " " ++ month ++ " " ++ String.fromInt date.year



months : Dict.Dict Int String
months =
    Dict.fromList
        [ ( 1, "Jan")
        , ( 2, "Feb")
        , ( 3, "Mar")
        , ( 4, "Apr")
        , ( 5, "May")
        , ( 6, "June")
        , ( 7, "July")
        , ( 8, "Aug")
        , ( 9, "Sep")
        , ( 10, "Oct")
        , ( 11, "Nov")
        , ( 12, "Dec")
        ]