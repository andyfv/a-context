module Projects.NeighborhoodHere exposing (Model, Msg, view, init, update, article)

import Center
import Article exposing (..)
import Html exposing (Html, div, h1, h3, h4, h5, text, hr, a)
import Html.Attributes exposing (id, class, href, attribute, style)
import Route.Route exposing (internalLink)


-- MODEL


article : Article
article =
    getArticle 
        { title = "Neighborhood Map"
        , subtitle = "Redo with Redux"
        , date = "2019"
        , image = Image "/z-context/img/projects/neighborhood/desktop_250.png" "Map"
        , href = "projects/neighborhood-here"
        , summary = ""
        }


type alias Model = 
    { }


init : (Model, Cmd msg)
init =
    ({ }, Cmd.none)


-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)



-- VIEW


view : Model -> Html msg
view model = articleBody article


articleBody : Article -> Html msg
articleBody a = 
    div [ class "article" ]
        [ h1 [ class "article-title" ] [ text (Article.getTitle a) ]
        , h3 [ class "article-subtitle" ] [ text (Article.getSubtitle a) ]
        , dateAndLink (Article.getDate a) "https://github.com/andyfv/neighborhood-here-source"
        , hr [] []
        , Center.markdown "800px" articleText
        ]


dateAndLink : String -> String -> Html msg
dateAndLink date link =
    div 
        [ style "display" "flex"
        , style "justify-content" "space-between"
        , style "align-items" "baseline"
        ]
        [ h5 [ class "article-date" ] [ text date ]
        , a [ href link
            , style "padding" "5px"
            ] 
            [ h5 [] [ text "Project Source" ] ]
        ]


articleText : String 
articleText = """

## Table of Contents

* [About](#about)
* [How to run it](#how-to-run-it)
* [How to use it](#how-to-use-it)
* [Dependencies](#dependencies)
* [TODO](#todo)

## About

The **Neighborhood-Here** project is Map app written in React and Redux. You can search different POI in the area and get basic information about them. The project emphasizes using React and Redux to build the application and the usage of third-party APIs (HereMapsAPI). 

## How to run it

#### [Open the App Link](https://andyfv.github.io/neighborhood-map-here/)

<br>

**Or download/clone locally:**

1) Download or Clone the repository

2) Unzip the file if you have downloaded a ZIP

3) Install dependencies using **npm**:

> `npm install`

4) Start the application:

 The service worker is only enabled in the production environment, so if you want to use it build the project first. For more information check [Making a Progressive Web App](https://goo.gl/KwvDNy).

> `npm run build`

> `npm install -g serve`

> `serve -s build`

* Otherwise just start the server

    

5) This will open new browser window/tab. If it doesn't navigate to:

- `http://localhost:3000/`

## How to use it

On the page you will see three main elements:

* Map
* Search Box
* List

![Page](/z-context/img/projects/neighborhood/desktop_800.jpg)

* To view information about specific venue you can choose item either from the List or from the map Markers. The map will be centered on the opened InfoBubble for you.

![POI](/z-context/img/projects/neighborhood/desktop_info_800.jpg)

***

* To search specific POI you are interested in just type in the Search Box and your results will update in both the **Map** and **List**

<p align="center">
    <img src="/z-context/img/projects/neighborhood/iphone5_results_200.jpg" width="200" alt="Search results on a phone">
    <img src="/z-context/img/projects/neighborhood/iphone5_info_200.jpg" width="200" alt="InfoBubble on a phone">
    <img src="/z-context/img/projects/neighborhood/iphone5_map_200.jpg" width="200" alt="Map results on a phone">
</p>

## Dependencies

* redux
* redux-thunk
* react-redux
* HereMapsAPI
* PropTypes


## TODO


* If HTTP 503 error is given - send another request<br>
Sadly the HTTP 503 Error for ```Places API``` didn't go away by reducing the number of requests send.<br>
As per [Here Maps Places API Documentation](https://developer.here.com/documentation/places/topics/http-status-codes.html) :

503 Service Unavailable Indicates that the service is temporarily unavailable due to system overload or maintenance.

"""


