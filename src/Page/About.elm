module Page.About exposing (Model, Msg, view, init, update)

import Browser
import Center
import Markdown
import Html exposing (Html, div)
import Html.Attributes exposing (id)
import Route.Route exposing (Route(..))
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)

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


view : Route -> Model -> Browser.Document msg
view route model =
    Page.view route info


info : Html msg
info =
    div [ id "about-page" ]
        [ Markdown.toHtmlWith Center.options [] text ]


text : String
text = """

Hi. 

This is part of my point of view at a cross section of relative time.

Interested in nothing specific and everything unspecified. Probably just a generalist.

I like to read... and find language and symbols amusing.

     
"""