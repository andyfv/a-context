module Main exposing (main)

import Html exposing (..)
import Browser exposing (UrlRequest, Document)
import Browser.Navigation as Nav
import Route exposing (Route)
import Url exposing (Url)
import Page.Home as Home
import Page as Page exposing (view, viewNotFound)



main : Program () Model Msg
main =
    Browser.application
        { init = init 
        , view = view
        , update = update 
        , subscriptions = \_ -> Sub.none
        , onUrlRequest =  LinkClicked
        , onUrlChange = UrlChanged
        }



type alias Model =
    { route : Route 
    , page : Page
    , navKey : Nav.Key
    }



type Page 
    = NotFoundPage
    | HomePage Home.Model



type Msg
    = HomeMsg Home.Msg
    ---
    | LinkClicked UrlRequest
    | UrlChanged Url


-- INIT

init : () -> Url -> Nav.Key -> (Model, Cmd Msg)
init _ url navKey =
    let 
        debug = Debug.log (Debug.toString <| Route.fromUrl url)
        model =
            { route = Route.fromUrl url
            , page = NotFoundPage
            , navKey = navKey
            }
    in
    initCurrentPage (model, Cmd.none)


initCurrentPage : (Model, Cmd Msg) -> (Model, Cmd Msg)
initCurrentPage (model, existingCmds) =
    let 
        (currentPage, mappedPageCmds) = 
            case model.route of
                Route.NotFound ->
                    ( NotFoundPage, Cmd.none )

                Route.Home ->
                    let
                        ( pageModel, pageCmd ) = Home.init
                    in
                    ( HomePage pageModel, Cmd.map HomeMsg pageCmd )

                Route.Mindstorms ->
                    ( NotFoundPage, Cmd.none )

                Route.MindstormsArticle _ ->
                    ( NotFoundPage, Cmd.none )

                Route.Projects ->
                    ( NotFoundPage, Cmd.none )

                Route.ProjectsArticle _ ->
                    ( NotFoundPage, Cmd.none )

                Route.About ->
                    ( NotFoundPage, Cmd.none )




    in
    ( { model| page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


-- VIEW 

view : Model -> Document Msg
view model =
    case model.page of
        NotFoundPage ->
            Page.viewNotFound

        HomePage pageModel ->
            Page.view model.route (Home.view pageModel)

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case ( model.page, msg ) of 
        ( HomePage pageModel, HomeMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    Home.update subMsg pageModel
            in
            ( { model | page = HomePage updatedPageModel } 
            , Cmd.map HomeMsg updatedCmd
            )

        ( _, _ ) -> 
            ( model, Cmd.none )



