module Main exposing (main)

import Html exposing (..)
import Browser exposing (UrlRequest, Document)
import Browser.Navigation as Nav
import Route.Route as Route exposing (Route)
import Url exposing (Url)
import Page.Home as Home
import Page.Mindstorms as Mindstorms
import Page.MindstormArticle as MindstormArticle
import Page.Projects as Projects
import Page.ProjectArticle as ProjectArticle
import Page.About as About
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
    | MindstormsPage Mindstorms.Model
    | MindstormArticlePage MindstormArticle.Model
    | ProjectsPage Projects.Model
    | ProjectArticlePage ProjectArticle.Model
    | AboutPage About.Model



type Msg
    = HomeMsg Home.Msg
    | MindstormsMsg Mindstorms.Msg
    | MindstormArticleMsg MindstormArticle.Msg
    | ProjectsMsg Projects.Msg
    | ProjectArticleMsg ProjectArticle.Msg
    | AboutMsg About.Msg
    ---
    | LinkClicked UrlRequest
    | UrlChanged Url


-- INIT

init : () -> Url -> Nav.Key -> (Model, Cmd Msg)
init _ url navKey =
    let 
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
                    let
                        ( pageModel, pageCmd ) = Mindstorms.init
                    in
                    ( MindstormsPage pageModel, Cmd.map MindstormsMsg pageCmd )

                Route.MindstormArticle articleString ->
                    --( NotFoundPage, Cmd.none )
                    let 
                        ( pageModel, pageCmd ) = MindstormArticle.init articleString
                    in
                    ( MindstormArticlePage pageModel, Cmd.map MindstormArticleMsg pageCmd )

                Route.Projects ->
                    let 
                        ( pageModel, pageCmd ) = Projects.init
                    in 
                    ( ProjectsPage pageModel, Cmd.map ProjectsMsg pageCmd )

                Route.ProjectsArticle articleString ->
                    let
                        ( pageModel, pageCmd ) = ProjectArticle.init articleString
                    in
                    ( ProjectArticlePage pageModel, Cmd.map ProjectArticleMsg pageCmd )


                Route.About ->
                    let 
                        ( pageModel, pageCmd ) = About.init
                    in
                    ( AboutPage pageModel, Cmd.map AboutMsg pageCmd )

    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


-- VIEW 

view : Model -> Document Msg
view model =
    case model.page of
        NotFoundPage ->
            Page.viewNotFound

        HomePage pageModel ->
            --Page.view model.route (Home.view pageModel |> Html.map HomeMsg)
            Home.view model.route pageModel

        MindstormsPage pageModel ->
            --Page.view model.route (Mindstorms.view pageModel |> Html.map MindstormsMsg)
            Mindstorms.view model.route pageModel

        MindstormArticlePage pageModel ->
            MindstormArticle.view pageModel

        ProjectsPage pageModel ->
            Projects.view model.route pageModel

        ProjectArticlePage pageModel ->
            ProjectArticle.view pageModel

        AboutPage pageModel ->
            About.view model.route pageModel



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


        ( MindstormsPage pageModel, MindstormsMsg subMsg ) ->
            let
                ( updatedPageModel, updatedCmd ) =
                    Mindstorms.update subMsg pageModel
            in
            ( { model | page = MindstormsPage updatedPageModel }
            , Cmd.map MindstormsMsg updatedCmd
            )

        ( MindstormArticlePage pageModel, MindstormArticleMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    MindstormArticle.update subMsg pageModel
            in
            ( { model | page = MindstormArticlePage updatedPageModel }
            , Cmd.map MindstormArticleMsg updatedCmd
            )



        ( ProjectsPage pageModel, ProjectsMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    Projects.update subMsg pageModel
            in
            ( { model | page = ProjectsPage updatedPageModel }
            , Cmd.map ProjectsMsg updatedCmd 
            )

        ( ProjectArticlePage pageModel, ProjectArticleMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) = 
                    ProjectArticle.update subMsg pageModel
            in
            ( { model | page = ProjectArticlePage updatedPageModel }
            , Cmd.map ProjectArticleMsg updatedCmd
            )


        ( AboutPage pageModel, AboutMsg subMsg ) ->
            let 
                ( updatedPageModel, updatedCmd ) =
                    About.update subMsg pageModel
            in
            ( { model | page = AboutPage updatedPageModel }
            , Cmd.map AboutMsg updatedCmd
            )



        ( _ , UrlChanged url ) ->
            let
                newRoute = Route.fromUrl url
            in
            ( { model | route = newRoute }, Cmd.none )
                |> initCurrentPage


        ( _ , LinkClicked urlRequest ) ->
            case urlRequest of 
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model, Nav.load url )


        ( _, _ ) -> 
            ( model, Cmd.none )



