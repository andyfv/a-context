module Page.MindstormArticle exposing (Model, Msg, view, init, update)


import Html exposing (Html)
import Article exposing (Article, ArticleCard, Image)
import Page exposing (viewNotFound)
import Route.MindstormsRoute as MindstormsRoute exposing (MindstormsRoute, fromString)

import Mindstorms.Learning as Learning exposing (..)


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
                    updateWith LearningPage LearningMsg (Learning.init)
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


-- VIEW

view : Model -> Html msg
view model =
    case model.page of
        NotFoundPage ->
            Page.viewNotFound

        LearningPage pageModel ->
            Learning.view pageModel



-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case ( model.page, msg ) of 
        ( LearningPage pageModel, LearningMsg subMsg ) ->
            (Learning.update subMsg pageModel)
            |> updateWithModel LearningPage LearningMsg model

        ( _, _ ) -> 
            ( model, Cmd.none )


------
updateWith : (subModel -> MindstormPage) -> (subMsg -> Msg) -> (subModel, Cmd subMsg) -> (MindstormPage, Cmd Msg)
updateWith toModel toMsg (subModel, subCmd) =
    (toModel subModel, Cmd.map toMsg subCmd)



updateWithModel : (subModel -> MindstormPage) -> (subMsg -> Msg) -> Model -> (subModel, Cmd subMsg) -> (Model, Cmd Msg)
updateWithModel toModel toMsg model (subModel, subCmd) =
    ( { model | page = toModel subModel }
    , Cmd.map toMsg subCmd
    )