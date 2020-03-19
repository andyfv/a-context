module Projects.SailfishOS exposing (Model, Msg, view, init, update, article)

import Html exposing (..)
import Html.Attributes exposing (..)
import Article exposing (..)
import Center

-- MODEL


article : Article
article =
    getArticle 
        { title = "Sailfish OS: UX Design Study"
        , subtitle = ""
        , date = "2018/2019"
        , image = Image "/z-context/img/projects/sailfish/SailfishOS_icon.svg" "Sailfish Logo"
        , href = "projects/sailfish-design-study"
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
        , h5 [ class "article-date" ] [ text (Article.getDate a) ]
        , hr [] []
        , Center.markdown "800px" intro
        , chapter1
        , chapter2
        , chapter3
        ]




intro : String 
intro = """

As with most case studies, the idea is to explore the current state of a particular area and make some propositions about improving it.

And the area of this case study is the UX of Sailfish OS(which is already pretty good). Of course, the proposed ideas shouldn't be too harsh and drive away the current users.

<hr>

First, let's talk context. We have to deal with multiple contexts. So let's find the borders/limitations we have to work with.

"""

-- CHAPTER 1

chapter1 : Html msg
chapter1 =
    p []
        [ h2 [] [ text "1. Hardware Limitations" ]
        , p [] 
            [ text "Now let's start with what we know. "
            , highlightColor "Jolla" red
            , text " are not making hardware anymore, so they don't have much control here. Taking this is consideration and moving on with the currently supported devices. "
            ]
        , devices
        , paragraph "Based on the screen sizes we can limit the scope a bit. Phone makers are probably going to stay with the current trend of bigger screens for some time. (Possibly the upcoming folding phones will disrupt this trend). "
        , paragraph "In the context of hardware, the differences are mostly dimensional. Sadly, different and more innovative types of hardware for interacting with the devices are hard to find. So let’s focus just on the screen dimensions for now. "
        , paragraph "Let's take the current line of phones in the eco-system to find potential weak points." 
        , strong [] [ text "Current Device Line" ]
        , img [ src "/z-context/img/projects/sailfish/sailfish-current-devices.png", alt "Devices"] []
        , paragraph "Since not having a proper crowdsourcing I will be using screenshots (from review videos) of `one-handed use` of actual people interacting with the various version and not just posing for picture with the product. We can see the following: "
        , handling
        , paragraph "With the this information (which to be honest is not much, but still something) we can start analyzing:"
        , analysis
        , paragraph "So we can see the most common weak point these days:" 
        , p (block) [ blockElement "Reachability - in all versions of the XA2" ]
        , paragraph "Check the weak points against Sailfish OS 3:" 
        , weakPoints
        , paragraph "Other issues can mainly come from the size of the device and not the OS itself."
        , hr [] []
        , paragraph "Thinking about worst case scenario, I tried to make a heatmap of the reachability situation on the XA2 Plus."
        , paragraph "Now, I will excuse myself again. This was done within limited time. And without proper crowdsourcing this shouldn't be taken seriously. Based on my hand size(considering myself having normal hand size)."
        , reachability
        , img [ src "/z-context/img/projects/sailfish/sailfish-devices-reachability.svg", alt "Reachability" ][]
        , hr [] []
        ]

devices : Html msg
devices =
    div ( block )
        [ strong [] [ text "Mobile Phones:" ]
        , blockElement "- Jolla (4.5 inch, 16:9 ratio)"
        , blockElement "- Jolla C (5.0 inch, 16:9 ratio)"
        , blockElement "- Sony Xperia X (5.0 inch, 16:9 ratio)"
        , blockElement "- Sony XA2 (5.2 inch, 16:9 ratio)"
        , blockElement "- Sony XA2 Ultra (6.0 inch, 16:9 ratio)" 
        , blockElement "- Sony XA2 Plus (6.0 inch, 18:9 ratio)"
        , strong [] [ text "Tablets:" ]
        , blockElement "- Jolla Tablet (7.85inch, 4:3 ratio)"
        ]

handling : Html msg
handling =
    div (block)
        [ blockElement "- XA2: Most people hold the phone with their pinky on the bottom lip."
        , br [] []
        , blockElement "- XA2 Plus: Most people hold the phone more to the middle. Actually most people use the phone with two hands."
        , br [] []
        , blockElement "- XA2 Ultra: The same as XA2 Plus."
        ]

analysis : Html msg
analysis =
    div (block)
        [ blockElement "- XA2: Keeping your pinky on the bottom lip of the phone still gives enough grip and the phone can be used for somewhat normal operation. Top of the screen is unreachable. The opposite horizontal edge is unreachable."
        , br [] []
        , blockElement "- XA2 Plus: Users hold the phone more to the middle. Most possible explanation is weight balance, otherwise there would not be enough grip. Bottom of the screen is harder to reach(more on that later). Top of the screen is unreachable. The opposite horizontal edge is unreachable."
        , br [] []
        , blockElement "- XA2 Ultra: The same as XA2 Plus."
        ]

weakPoints : Html msg
weakPoints =
    div (block)
        [ blockElement "1. One-handed use is worse because of unreachability"
        , br [] []
        , blockElement "2. Quick closing an App on Sailfish 3 - with the top of the screen being unreachable, this is a problem. Also this action is only possible from the left or right portion of the top edge, which makes it tricky to use."
        ]

reachability : Html msg
reachability =
    div (block)
        [ p []
            [ highlightColor "Green Area" green
            , text " "
            , text "- the reachable part of the screen"
            ]
        , p []
            [ highlightColor "Orange Area" orange
            , text " "
            , text "- the trickier to reach part of the screen"
            ]
        , p []
            [ highlightColor "Red Area" red 
            , text " "
            , text "- unreachable"
            ]
        ]


-- CHAPTER 2

chapter2 : Html msg 
chapter2 =
    p []
        [ h2 [] [ text "2. Software Limitations" ]
        , paragraph "Again, let's start with what we already have and then see if something can be proposed. "
        , p [] 
            [ text "Sailfish is using "
            , highlightColor "gesture based navigation" red
            , text ". And in it's current state it looks like this: "
            ]
        , centerImage "/z-context/img/projects/sailfish/sailfish-navigation.svg" "Navigation" "320px"
        , p []
            [ text "Let's examine the "
            , highlightColor "navigation screens" red
            , text " which may have reachability issues."
            ]
        , navScreens
        , hr [] []
        ]


navScreens : Html msg
navScreens =
    div (block)
        [ strong [] [ text "1. Home" ]
        , blockElement "With just 2 App Covers on a row there will be no problem."
        , blockElement "But with 3 App Covers on a row it may get tricky to hit App Covers in the opposite edges on the Top of the screen."
        , br [] []
        , strong [] [ text "2. Events " ]
        , blockElement "Since the Top part is used as a Presentational component with no controls, everything is perfect."
        , br [] []
        , strong [] [ text "3. Apps "]
        , blockElement "App Icons on the Top may not be reachable."
        , br [] []
        , strong [] [ text "4. Top Menu"]
        , blockElement "Some of the Quick Toggles on the Top may not be reachable."
        ]



-- CHAPTER 3

chapter3 : Html msg 
chapter3 =
    p []
        [ h2 [] [ text "3. Propositions" ]
        , p [] 
            [ text "Some propositions will be given to improve the current "
            , highlightColor "Navigation" red
            , text "."
            ]
        , p []
            [ text "Let's start with the "
            , highlightColor "Quick Close" red
            ]
        , h3 [] [ text "Quick Close" ]
        , centerImage "/z-context/img/projects/sailfish/sailfish-quick-close.svg" "Quick Close" "320px"
        , p []
            [ text "Currently the "
            , highlightColor "Quick Close" red
            , text " is triggered with a swipe down from the "
            , highlightColor "Left/Right part of the Top edge" red
            , text "."
            , text "Since the Top edge of the screen is hardly reachable(especially on the XA2 Plus and Ultra), this is an area which can be improved. The problem is "
            , highlightColor "1. Where" green
            , text " to move this action and "
            , highlightColor "2. How" green
            , text " it will be triggered. "
            ]
        , p []
            [ highlightColor "1. Where" green
            , text " - it needs to go lower. This leaves us with the Left, Right, Bottom edge to initiate it. The Left and Right edges give us best reachability regardless of the way the phone is held. So lets try from the "
            , highlightColor "Left and Right edges" red
            , text "."
            ]
        , p []
            [ highlightColor "2. How" green
            , text " (it will be triggered?) - The "
            , highlightColor "Left and Right" red
            , text " edges are used for Navigation between Home and Events and also to minimize Apps. So we will need new gesture. Something without adding too much complexity and preventing accidental closing. So, let's check the natural swipe direction and go from there. The natural direction of a swipe from the edge is sideways and going down. So if the opposite direction is used for "
            , highlightColor "Quick Closing" red
            , text " an App, this will prevent from accidental closing. Let's check it."
            ]
        , centerImage "/z-context/img/projects/sailfish/sailfish-swipe-comparison.svg" "Swipe Comparison" "640px"
        , paragraph "And here it is a more complete overview, with a hint at the top of the screen, telling the user what is going to happen. "
        , centerImage "/z-context/img/projects/sailfish/SailfishOS_CloseApp.gif" "Close App" "320px"
        , p [] [ text "Now the ", highlightColor "Top Edge" red, text " is decluttered." ]
        , p [] [ text "Which lead us to the ", highlightColor "Top Menu" red, text "." ]
        , hr [] []
        , topMenu
        , hr [] []
        , systemSearch
        , hr [] []
        , appDrawer
        ]

topMenu : Html msg
topMenu =
    div []
        [ h3 [] [ text "Top Menu" ]
        , p [] 
            [ text "What can be done here? The "
            , highlightColor "Top Menu" red
            , text " can be accessed from three places - from "
            , highlightColor "Home, Events, In-App" red
            , text "."
            , text """ What about "one-handed" usage. What if the swipe direction from """
            , highlightColor "Home" red
            , text " to "
            , highlightColor "Events" red
            , text " is stored and used for rearanging the "
            , highlightColor "Top Menu" red
            , text " in a more compact form. A demonstration will clear things out."
            ]
        , div 
            [ style "display" "flex"
            , style "flex-direction" "row"
            , style "flex-wrap" "wrap"
            , style "justify-content" "space-around"
            ]
            [ div [] 
                [ p [] [ text "Left Swipe"]
                , centerImage "/z-context/img/projects/sailfish/SailfishOS_TopMenuLeft.gif" "Left Swipe" "200px"
                ]
            , div [] 
                [ p [] [ text "From Home Swipe"]
                , centerImage "/z-context/img/projects/sailfish/SailfishOS_TopMenu.gif" "Home Swipe" "200px"
                ]
            , div [] 
                [ p [] [ text "Right Swipe"]
                , centerImage "/z-context/img/projects/sailfish/SailfishOS_TopMenuRight.gif" "Right Swipe" "200px"
                ]
            ]
        , paragraph "This is not the about the UI (colors, icon shapes. etc), but more about the UX, so here is a little comparison of the proposed vs the old:"
        , centerImage "/z-context/img/projects/sailfish/sailfish-topmenu-comparison.svg" "Top Menu Comparison" "640px"
        , p [ style "text-align" "center"] [ text "Landscape" ]
        , centerImage "/z-context/img/projects/sailfish/sailfish-new-topmenu-landscape.svg" "Landscape" "480px"
        , p []
            [ text "And the "
            , highlightColor "Presentational Component" red
            , text " from the Events Screen can be leveraged, leaving the Top part of the screen just for infomartion/metrics:"
            ]
        , div (block) 
            [ blockElement "- onChange Notifications for the Quick Toggles (ON/OFF)"
            , blockElement "- Available Memory"
            , blockElement "- Media player information"
            , blockElement "- Temperature"
            ]
        ]



systemSearch : Html msg
systemSearch =
    div []
        [ h3 [] [ text "System Search" ]
        , p []
            [ text "Triggered only from the "
            , highlightColor "Home Screen and Events." red
            , text "."
            ]
        , p []
            [ text """Two 'paddles' will apear on """
            , highlightColor "Swipe Down + Hold" red
            , text ". "
            , text "From there the swipe will be continued to either "
            , highlightColor "Left" red
            , text " or "
            , highlightColor "Right" red
            , text "."
            ]
        , div 
            [ style "display" "flex"
            , style "flex-direction" "row"
            , style "flex-wrap" "wrap"
            , style "justify-content" "space-around"
            ]
            [ centerImage "/z-context/img/projects/sailfish/SailfishOS_Search.gif" "Search" "320px"
            , centerImage "/z-context/img/projects/sailfish/SailfishOS_SearchResults.gif" "Search" "320px"
            ]
        , paragraph "View from above of the proposed navigation improvements:"
        , centerImage "/z-context/img/projects/sailfish/sailfish-proposition-view.png" "Sailfish Swipe Comparison" "640px"
        ]


appDrawer : Html msg
appDrawer =
    div []
        [ h3 [] [ text "App Drawer" ]
        , p []
            [ text "The "
            , highlightColor "App Drawer" red
            , text " will be hard to improve without reducing the interactive area. Leaving it as it is, for now."
            ]
        ]


-- HELPERS


green : String
green = 
    "#7FCF59"

orange : String
orange = 
    "#DE6818"

red : String 
red = 
    "rgb(253, 120, 120)"


paragraph : String -> Html msg
paragraph str =
    p [] [ text str ]


centerImage : String -> String -> String -> Html msg
centerImage imgSrc altName maxWidth =
    p [ style "text-align" "center"]
        [ img 
            [ src imgSrc
            , alt altName 
            , style "max-width" maxWidth
            --, style "border-radius" "5%"
            ] []
        ]

highlightColor : String -> String -> Html msg
highlightColor str color =
    span
        [ style "background-color" color
        , style "border-radius" "4px"
        , style "padding" "2px 2px 1px 2px"
        , style "font-weigth" "ligther"
        , style "font-size" "0.85em"
        , style "color" "white"
        , style "-webkit-box-shadow" "0px 1px 2px 0px rgba(0,0,0,0.75)"
        , style "-moz-box-shadow" "0px 1px 2px 0px rgba(0,0,0,0.75)"
        , style "box-shadow" "0px 1px 2px 0px rgba(0,0,0,0.75)"
        ]
        [ text str ]


block : List (Attribute msg)
block =
    [ style "background-color" "rgb(236, 236, 236)"
    , style "text-align" "left"
    , style "word-break" "break-word"
    , style "padding-left" "10px"
    , style "padding-right" "10px"
    , style "padding-bottom" "10px"
    , style "padding-top" "10px"
    , style "border-radius" "4px"
    , style "margin-top" "20px"
    , style "margin-bottom" "20px"
    , style "-webkit-box-shadow" "0px 1px 2px 0px rgba(0,0,0,0.75)"
    , style "-moz-box-shadow" "0px 1px 2px 0px rgba(0,0,0,0.75)"
    , style "box-shadow" "0px 1px 2px 0px rgba(0,0,0,0.75)"
    ]

blockElement : String -> Html msg
blockElement str =
    p [ style "margin-top" "5px", style "margin-bottom" "5px" ] [ text str ]


toLine : String -> Html msg
toLine line =
    text line

