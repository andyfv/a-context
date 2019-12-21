module Page.Home exposing (Model, Msg, view)

import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Element.Input as Input
import Element.Events as Events
import Element.Font as Font


type alias Model =
    { article : String
    }



-- UPDATE


type Msg
    = ClickedTag



-- VIEW

view : Model -> { title : String , content : Element Msg}
view model =
    { title = "Z Context"
    , content = 
        el 
        []
        (text "Test")
    }