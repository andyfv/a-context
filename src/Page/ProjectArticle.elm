module Page.ProjectArticle exposing (Model, Msg, view, init, update)


import Browser
import Article exposing (Article, ArticleCard, Image)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)
import Route.Route as Route exposing (Route)
import Route.ProjectsRoute as ProjectsRoute exposing (..)

import Projects.NeighborhoodHere as NH exposing (..)
import Projects.SymbolRecognition as SR exposing (..)
import Projects.SailfishOS as SOS exposing (..)


-- MODEL

type alias Model =
    { route : ProjectsRoute
    , page : ProjectPage
    }



type ProjectPage
    = Neighborhood NH.Model
    | SymbolRecognition SR.Model
    | SailfishOS SOS.Model
    | NotFoundPage



type Msg
    = NeighborhoodMsg NH.Msg
    | SymbolRecognitionMsg SR.Msg
    | SailfishOSMsg SOS.Msg



-- INIT

init : String -> (Model, Cmd Msg)
init pageString =
    let 
        model = 
            { route = ProjectsRoute.fromString pageString 
            , page = NotFoundPage
            }
        _ = Debug.log "pageString" pageString
        _ = Debug.log "route" (ProjectsRoute.fromString pageString)
    in
    initCurrentPage (model, Cmd.none)


initCurrentPage : (Model, Cmd Msg) -> (Model, Cmd Msg)
initCurrentPage (model, existingCmds) =
    let 
        (currentPage, mappedPageCmds) = 
            case model.route of
                ProjectsRoute.NotFound ->
                    ( NotFoundPage, Cmd.none )

                ProjectsRoute.NeighborhoodHere ->
                    let
                        ( pageModel, pageCmd ) = NH.init
                    in
                    ( Neighborhood pageModel, Cmd.map NeighborhoodMsg pageCmd )

                ProjectsRoute.SymbolRecognition ->
                    let
                        ( pageModel, pageCmd ) = SR.init
                    in
                    ( SymbolRecognition pageModel, Cmd.map SymbolRecognitionMsg pageCmd )

                ProjectsRoute.SailfishOS ->
                    let
                        ( pageModel, pageCmd ) = SOS.init
                    in
                    ( SailfishOS pageModel, Cmd.map SailfishOSMsg pageCmd )
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


-- VIEW

view : Model -> Browser.Document msg
view model =
    let 
        route = Route.Projects
    in
    case model.page of
        NotFoundPage ->
            Page.viewNotFound

        Neighborhood pageModel ->
            --Page.view model.route (Home.view pageModel |> Html.map HomeMsg)
            NH.view route pageModel

        SymbolRecognition pageModel ->
            SR.view route pageModel

        SailfishOS pageModel ->
            SOS.view route pageModel



-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case ( model.page, msg ) of 
        ( Neighborhood pageModel, NeighborhoodMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    NH.update subMsg pageModel
            in
            ( { model | page = Neighborhood updatedPageModel } 
            , Cmd.map NeighborhoodMsg updatedCmd
            )

        ( SymbolRecognition pageModel, SymbolRecognitionMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    SR.update subMsg pageModel
            in
            ( { model | page = SymbolRecognition updatedPageModel } 
            , Cmd.map SymbolRecognitionMsg updatedCmd
            )

        ( SailfishOS pageModel, SailfishOSMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    SOS.update subMsg pageModel
            in
            ( { model | page = SailfishOS updatedPageModel } 
            , Cmd.map SailfishOSMsg updatedCmd
            )

        ( _, _ ) -> 
            ( model, Cmd.none )


