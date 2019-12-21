module Main exposing (main, Model, Msg)

import Browser
import Browser.Navigation as Nav
import Browser.Events exposing (onResize)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Element.Input as Input
import Element.Events as Events
import Element.Font as Font
import Json.Decode as Decode
import Json.Encode as Encode
import Html.Attributes as HtmlAttribute
import Url
import Page.Page as Page exposing (Page, view)
import Page.Home as Home 


-- MAIN

main : Program Flags Model Msg
main =
    Browser.application
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = subscription
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


initialModel : Flags -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
initialModel flags url key =
    (
    { url = url
    , key = key
    , page = Home Home.Model
    , deviceInfo = DeviceInfo flags.deviceWidth flags.deviceHeight (classifyDevice flags)
    , str = ""
    }
    , Cmd.none )


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : Page
    , deviceInfo : DeviceInfo
    , str : String
    }


type alias Flags =
    { deviceWidth: Int
    , deviceHeight: Int
    }


type alias DeviceInfo =
    { width: Int
    , height: Int
    , deviceType: Device
    }


type Model
    = Home Home.Model


-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ViewportUpdate { width : Int, height : Int }
    | Update String
    | NoOp
    | HomeMsg Home.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url))

                Browser.External url ->
                    ( model, Nav.load url)

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        ViewportUpdate { width, height } ->
            let
                deviceClass = classifyDevice { width = width, height = height}
            in
                ({ model | deviceInfo = DeviceInfo width height deviceClass }
                , Cmd.none)

        Update str ->
            ( {model| str = str} , Cmd.none )

        NoOp ->
            (  model , Cmd.none )



-- SUBSCRIPTIONS


subscription : Model -> Sub Msg
subscription model =
    onResize <|
        \width height -> ViewportUpdate { width = width, height = height }



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        deviceClass = model.deviceInfo.deviceType.class

        viewPage page toMsg config =
            let 
                { title, body } = Page.view deviceClass page config
            in
            { title = title
            , body = List.map (Element.map toMsg) body
            }

    in
    case model of 
        Home home ->
            viewPage Page.Home HomeMsg (Home.view home)




type alias PageContent =
    { header : Element Msg
    , content : Element Msg
    , footer : Element Msg
    }



--bodyDispatcher : Model -> DeviceClass -> Element Msg
--bodyDispatcher model deviceClass =
--    case deviceClass of
--        Desktop ->
--            desktopBody model 

--        Phone ->
--            mobileBody model

--        Tablet ->
--            desktopBody model

--        _ ->
--            desktopBody model



--desktopBody : Model -> Element Msg
--desktopBody model =
--    column
--        [ height fill
--        , width fill
--        , Background.tiled "/img/background_noise.png"
--        , inFront (headerWrapper)
--        ]
--        [
--            paragraph [moveDown 100] [text <| Debug.toString model.deviceInfo]
--        ]



--mobileBody : Model -> Element Msg
--mobileBody model =
--    column
--        [ width fill
--        , height fill
--        , Background.tiled "/img/background_noise.png"
--        , inFront (mobileHeader)
--        ]
--        [
--            paragraph [moveDown 300] [text <| Debug.toString model.deviceInfo]
--        ]



--headerWrapper : Element Msg
--headerWrapper =
--    el
--        [ width (fill |> maximum 960)
--        , height (px 62)
--        , padding 10
--        , centerX
--        ]
--        (desktopHeader)



--desktopHeader: Element Msg
--desktopHeader =
--    row
--        [ width fill
--        , height (px 58)
--        , Background.color <| rgb255 255 185 0
--        , Border.rounded 100
--        ]
--        [ image
--            [ height (px 50)
--            , paddingEach { edges | left = 30}
--            , alignLeft
--            , moveDown 4
--            ]
--            { src = "/img/blog_desktop_dark.svg", description = "logo"}
--        , row
--            [ alignRight
--            , spacing 10
--            , paddingEach { edges | right = 30}
--            ]
--            [ link
--                [ Font.family
--                    [ Font.typeface "Helvetica"
--                    , Font.sansSerif
--                    ]
--                , alignRight
--                , Font.color <| rgb255 81 75 69
--                , Font.size 22
--                , Font.light
--                ]
--                { url = "/projects"
--                , label = text "Projects"
--                }
--            , link
--                [ Font.family
--                    [ Font.typeface "Helvetica"
--                    , Font.sansSerif
--                    ]
--                , alignRight
--                , Font.color <| rgb255 81 75 69
--                , Font.size 22
--                , Font.light
--                ]
--                { url = "/mindstorms"
--                , label = text "Mindstorms"
--                }
--            ]
--        ]



--mobileHeader : Element Msg
--mobileHeader =
--    row
--        [ width fill
--        , height (px 60)
--        , centerX
--        , Background.color <| rgb255 255 185 0
--        , alignBottom
--        , spaceEvenly
--        , paddingEach { edges | right = 15, left = 15 }
--        ]
--        [ column
--            [ width (px 36)
--            ]
--            [ image
--              [ height (px 36)
--              , alignTop
--              ]
--              { src = "/img/icon_mobile_dark.svg", description = "logo"}
--            , el
--                [ Font.size 14
--                , moveDown 2
--                , moveLeft 2
--                ]
--                (text "Home")
--            ]
--        , column
--            [ width (px 36)
--            ]
--            [ image
--                [ height (px 36)
--                , alignTop
--                ]
--                { src = "/img/menu_icon_dark.svg", description= "menu" }
--            , el
--                [ Font.size 14
--                , moveDown 2
--                ]
--                (text "Menu")
--            ]
--        ]



--edges =
--    { top = 0
--    , right = 0
--    , bottom = 0
--    , left = 0
--    }



valueDecoder : Decode.Decoder Int
valueDecoder =
    Decode.field "value" Decode.int

