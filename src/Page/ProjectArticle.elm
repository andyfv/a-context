module Page.ProjectArticle exposing (Model, Msg, view, init, update)


import Html exposing (Html)
import Article exposing (Article, ArticleCard, Image)
import Page exposing (viewNotFound)
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
                    updateWith Neighborhood NeighborhoodMsg NH.init

                ProjectsRoute.SymbolRecognition ->
                    updateWith SymbolRecognition SymbolRecognitionMsg SR.init

                ProjectsRoute.SailfishOS ->
                    updateWith SailfishOS SailfishOSMsg SOS.init

    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


updateWith : (subModel -> ProjectPage) -> (subMsg -> Msg) -> (subModel, Cmd subMsg) -> (ProjectPage, Cmd Msg)
updateWith toModel toMsg (subModel, subCmd) =
    (toModel subModel, Cmd.map toMsg subCmd)




-- VIEW

view : Model -> Html msg
view model =
    case model.page of
        NotFoundPage ->
            Page.viewNotFound

        Neighborhood pageModel ->
            NH.view pageModel

        SymbolRecognition pageModel ->
            SR.view pageModel

        SailfishOS pageModel ->
            SOS.view pageModel



-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case ( model.page, msg ) of 
        ( Neighborhood pageModel, NeighborhoodMsg subMsg) ->
            (NH.update subMsg pageModel)
            |> updateWithModel Neighborhood NeighborhoodMsg model

        ( SymbolRecognition pageModel, SymbolRecognitionMsg subMsg ) ->
            (SR.update subMsg pageModel)
            |> updateWithModel SymbolRecognition SymbolRecognitionMsg model

        ( SailfishOS pageModel, SailfishOSMsg subMsg ) ->
            (SOS.update subMsg pageModel)
            |> updateWithModel SailfishOS SailfishOSMsg model

        ( _, _ ) -> 
            ( model, Cmd.none )



updateWithModel : (subModel -> ProjectPage) -> (subMsg -> Msg) -> Model -> (subModel, Cmd subMsg) -> (Model, Cmd Msg)
updateWithModel toModel toMsg model (subModel, subCmd) =
    ( { model | page = toModel subModel }
    , Cmd.map toMsg subCmd
    )