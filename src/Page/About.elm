module Page.About exposing (Model, Msg, view, init, update)

import Center
import Markdown
import Html exposing (Html, div, a, h3, h5, text, hr)
import Html.Attributes exposing (id, class, href)

-- MODEL


type alias Model = {}

init : (Model, Cmd Msg)
init =
    ({}, Cmd.none)



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
    div [ id "about-page" ]
        [ socialNetworks
        , hr [] []
        , Markdown.toHtmlWith Center.options [] info 
        ]


info : String
info = """

Hi. 

This is part of my point of view at a cross section of relative time.

Interested in nothing specific and everything unspecified. Probably just a generalist.

I like to read... and find language and symbols amusing.

     
"""



-- Social Networks

socialNetworks : Html msg
socialNetworks =
    div
        [ id "social-networks-wrapper" ]
        [ linkedin ]



linkedin : Html msg
linkedin =
    a 
        [ class "social-network"
        , href "https://www.linkedin.com/in/andreafilchev/"
        ] 
        [ text "LinkedIn" ]


github : Html msg
github =
    a 
        [ class "social-network"
        , href ""
        ] 
        [ text "GitHub" ]