module Main exposing (main)

import Task
import Url exposing (Url)
import Browser.Navigation as Nav
import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events exposing (onResize)
import Browser exposing (UrlRequest, Document)
import Route.Route as Route exposing (Route)
import Page as Page exposing (view, viewNotFound, Config)
import Header as H
--
import Page.Home as Home
import Page.Mindstorms as Mindstorms
import Page.MindstormArticle as MindstormArticle
import Page.Projects as Projects
import Page.ProjectArticle as ProjectArticle
import Page.About as About



-- MAIN

main : Program () Model Msg
main =
    Browser.application
        { init = init 
        , view = view
        , update = update 
        , subscriptions = subscriptions
        , onUrlRequest =  LinkClicked
        , onUrlChange = UrlChanged
        }


type alias Model =
    { route : Route 
    , page : Page
    , navKey : Nav.Key
    , headerModel : H.Model
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

    -- VIEWPORT
    | ViewportSize Viewport
    | ViewportChanged

    -- URL    
    | LinkClicked UrlRequest
    | UrlChanged Url

    -- HEADER
    | HeaderMsg H.Msg



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    onResize  
        (\_ _ -> HeaderMsg H.ViewportChanged )



-- INIT

init : () -> Url -> Nav.Key -> (Model, Cmd Msg)
init flags url navKey =
    let 
        route = Route.fromUrl url
        (headerModel, headerCmds) = H.init route
        model =
            { route = route
            , page = NotFoundPage
            , navKey = navKey
            , headerModel = headerModel
            }
    in
    initCurrentPage (model, Cmd.batch [ Cmd.map HeaderMsg headerCmds ])


initCurrentPage : (Model, Cmd Msg) -> (Model, Cmd Msg)
initCurrentPage (model, existingCmds) =
    let 
        (currentPage, mappedPageCmds) = 
            case model.route of
                Route.NotFound ->
                    ( NotFoundPage, Cmd.none )

                Route.Home ->
                    updateWith HomePage HomeMsg Home.init

                Route.Mindstorms ->
                    updateWith MindstormsPage MindstormsMsg Mindstorms.init

                Route.MindstormArticle articleString ->
                    MindstormArticle.init articleString
                    |> updateWith MindstormArticlePage MindstormArticleMsg

                Route.Projects ->
                    updateWith ProjectsPage ProjectsMsg Projects.init

                Route.ProjectsArticle articleString ->
                    ProjectArticle.init articleString
                    |> updateWith ProjectArticlePage ProjectArticleMsg 

                Route.About ->
                    updateWith AboutPage AboutMsg About.init                    
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


-- VIEW 

view : Model -> Document Msg
view model =
    let 
        --_ = Debug.log "viewport" model.headerModel
        viewPage route content =
            let 
                config = 
                    { route = route
                    , content = content
                    , headerModel = model.headerModel
                    }
            in
            Page.view config
    in
    case model.page of
        NotFoundPage ->
            --Page.view Route.NotFound Page.viewNotFound model.viewport
            viewPage Route.NotFound Page.viewNotFound

        HomePage pageModel ->
            --Page.view Route.Home (Home.view pageModel) model.viewport
            viewPage Route.Home (Home.view pageModel)

        MindstormsPage pageModel -> 
            --Page.view Route.Mindstorms (Mindstorms.view pageModel) model.viewport
            viewPage Route.Mindstorms (Mindstorms.view pageModel)

        MindstormArticlePage pageModel ->
            --Page.view Route.Mindstorms (MindstormArticle.view pageModel) model.viewport
            viewPage Route.Mindstorms (MindstormArticle.view pageModel)

        ProjectsPage pageModel ->
            --Page.view Route.Projects (Projects.view pageModel) model.viewport
            viewPage Route.Projects (Projects.view pageModel)

        ProjectArticlePage pageModel ->
            --Page.view Route.Projects (ProjectArticle.view pageModel) model.viewport
            viewPage Route.Projects (ProjectArticle.view pageModel)

        AboutPage pageModel ->
            --Page.view Route.About (About.view pageModel) model.viewport
            viewPage Route.About (About.view pageModel)


-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case ( model.page, msg ) of 
        ( HomePage pageModel, HomeMsg subMsg ) ->
            (Home.update subMsg pageModel)
            |> updateWithModel HomePage HomeMsg model

        ( MindstormsPage pageModel, MindstormsMsg subMsg ) ->
            (Mindstorms.update subMsg pageModel)
            |> updateWithModel MindstormsPage MindstormsMsg model

        ( MindstormArticlePage pageModel, MindstormArticleMsg subMsg ) ->
            (MindstormArticle.update subMsg pageModel)
            |> updateWithModel MindstormArticlePage MindstormArticleMsg model            

        ( ProjectsPage pageModel, ProjectsMsg subMsg ) ->
            (Projects.update subMsg pageModel)
            |> updateWithModel ProjectsPage ProjectsMsg model

        ( ProjectArticlePage pageModel, ProjectArticleMsg subMsg ) ->
            (ProjectArticle.update subMsg pageModel)
            |> updateWithModel ProjectArticlePage ProjectArticleMsg model            

        ( AboutPage pageModel, AboutMsg subMsg ) ->
            (About.update subMsg pageModel)
            |> updateWithModel AboutPage AboutMsg model            


        -- VIEWPORT
        ( _ , HeaderMsg subMsg) ->
            let 
                (headerModel, subCmds) = H.update subMsg model.headerModel
            in
            ( { model | headerModel = headerModel }
            , Cmd.map HeaderMsg subCmds)


        -- URL UPDATES
        ( _ , UrlChanged url ) ->
            let 
                route = Route.fromUrl url
                headerModel = model.headerModel
            in
            initCurrentPage 
                ({ model | route = route, headerModel = { headerModel | route = route } }, Cmd.none )

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



updateWith : (subModel -> Page) -> (subMsg -> Msg) -> (subModel, Cmd subMsg) -> (Page, Cmd Msg)
updateWith toModel toMsg (subModel, subCmd) =
    (toModel subModel, Cmd.map toMsg subCmd)



updateWithModel : (subModel -> Page) -> (subMsg -> Msg) -> Model -> (subModel, Cmd subMsg) -> (Model, Cmd Msg)
updateWithModel toModel toMsg model (subModel, subCmd) =
    ( { model | page = toModel subModel }
    , Cmd.map toMsg subCmd
    )