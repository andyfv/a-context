module Page.Page exposing (Page(..),view)

import Browser
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Element.Input as Input
import Element.Events as Events
import Element.Font as Font


type Page
    = Home
    | Projects
    | Mindstorms



view : DeviceClass -> Page -> Element msg -> Browser.Document msg
view deviceClass page content = 
    { title = "Z Context"
    , body = [ layout [] <| bodyDispatcher deviceClass page content]
    }



bodyDispatcher : DeviceClass -> Page -> Element msg -> Element msg
bodyDispatcher deviceClass page content =
    case deviceClass of
        Desktop ->
            desktopBody page content

        Phone ->
            mobileBody page content

        Tablet ->
            desktopBody page content

        _ ->
            desktopBody page content



desktopBody : Page -> Element msg -> Element msg
desktopBody page content =
    column
        [ height fill
        , width fill
        , Background.tiled "/img/background_noise.png"
        , inFront (headerWrapper)
        ]
        [
            content--paragraph [moveDown 100] [text <| Debug.toString model.deviceInfo]
        ]




mobileBody : Page -> Element msg -> Element msg
mobileBody page content =
    column
        [ width fill
        , height fill
        , Background.tiled "/img/background_noise.png"
        , inFront (mobileHeader)
        ]
        [
            content
            --paragraph [moveDown 300] [text <| Debug.toString model.deviceInfo]
        ]




headerWrapper : Element msg
headerWrapper =
    el
        [ width (fill |> maximum 960)
        , height (px 62)
        , padding 10
        , centerX
        ]
        (desktopHeader)



desktopHeader: Element msg
desktopHeader =
    row
        [ width fill
        , height (px 58)
        , Background.color <| rgb255 255 185 0
        , Border.rounded 100
        ]
        [ image
            [ height (px 50)
            , paddingEach { edges | left = 30}
            , alignLeft
            , moveDown 4
            ]
            { src = "/img/blog_desktop_dark.svg", description = "logo"}
        , row
            [ alignRight
            , spacing 10
            , paddingEach { edges | right = 30}
            ]
            [ link
                [ Font.family
                    [ Font.typeface "Helvetica"
                    , Font.sansSerif
                    ]
                , alignRight
                , Font.color <| rgb255 81 75 69
                , Font.size 22
                , Font.light
                ]
                { url = "/projects"
                , label = text "Projects"
                }
            , link
                [ Font.family
                    [ Font.typeface "Helvetica"
                    , Font.sansSerif
                    ]
                , alignRight
                , Font.color <| rgb255 81 75 69
                , Font.size 22
                , Font.light
                ]
                { url = "/mindstorms"
                , label = text "Mindstorms"
                }
            ]
        ]



mobileHeader : Element msg
mobileHeader =
    row
        [ width fill
        , height (px 60)
        , centerX
        , Background.color <| rgb255 255 185 0
        , alignBottom
        , spaceEvenly
        , paddingEach { edges | right = 15, left = 15 }
        ]
        [ column
            [ width (px 36)
            ]
            [ image
              [ height (px 36)
              , alignTop
              ]
              { src = "/img/icon_mobile_dark.svg", description = "logo"}
            , el
                [ Font.size 14
                , moveDown 2
                , moveLeft 2
                ]
                (text "Home")
            ]
        , column
            [ width (px 36)
            ]
            [ image
                [ height (px 36)
                , alignTop
                ]
                { src = "/img/menu_icon_dark.svg", description= "menu" }
            , el
                [ Font.size 14
                , moveDown 2
                ]
                (text "Menu")
            ]
        ]



edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }

