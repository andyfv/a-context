module Page.MindstormArticle exposing (Model, Msg, view, init, update)


import Browser
import Article exposing (Article, ArticleCard, Image)
import Mindstorms.TestArticle exposing (article)
import Mindstorms.Learning as Learning exposing (..)
import Page as Page exposing (viewCards, viewCard, viewCardImage, viewCardInfo)
import Route.Route as Route exposing (Route)
import Route.MindstormsRoute as MindstormsRoute exposing (MindstormsRoute, fromString)


-- MODEL

type alias Model =
    { route : MindstormsRoute
    , page : MindstormPage
    }



type MindstormPage
    = LearningPage Learning.Model
    | NotFoundPage



type Msg
    = LearningMsg Learning.Msg



-- INIT

init : String -> (Model, Cmd Msg)
init pageString =
    let 
        model = 
            { route = MindstormsRoute.fromString pageString 
            , page = NotFoundPage
            }
    in
    initCurrentPage (model, Cmd.none)


initCurrentPage : (Model, Cmd Msg) -> (Model, Cmd Msg)
initCurrentPage (model, existingCmds) =
    let 
        (currentPage, mappedPageCmds) = 
            case model.route of
                MindstormsRoute.NotFound ->
                    ( NotFoundPage, Cmd.none )

                MindstormsRoute.Learning ->
                    let
                        ( pageModel, pageCmd ) = Learning.init
                    in
                    ( LearningPage pageModel, Cmd.map LearningMsg pageCmd )
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


-- VIEW

view : Model -> Browser.Document msg
view model =
    case model.page of
        NotFoundPage ->
            Page.viewNotFound

        LearningPage pageModel ->
            --Page.view model.route (Home.view pageModel |> Html.map HomeMsg)
            Learning.view Route.Mindstorms pageModel




-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case ( model.page, msg ) of 
        ( LearningPage pageModel, LearningMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    Learning.update subMsg pageModel
            in
            ( { model | page = LearningPage updatedPageModel } 
            , Cmd.map LearningMsg updatedCmd
            )


        ( _, _ ) -> 
            ( model, Cmd.none )


