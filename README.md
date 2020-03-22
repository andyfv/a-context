# Z-Context

## Table Of Contents

  - [Table Of Contents](#table-of-contents)
  - [About](#about)
  - [How to run it](#how-to-run-it)
  - [Project Structure](#project-structure)
  - [Dependencies](#dependencies)
  - [TODO](#todo)
  - [Issues](#issues)

## About

The **Z-Context** personal website is a SPA written in Elm. 



## How to run it

- #### [Open the Link](https://andyfv.github.io/z-context/)


- #### `Or download/clone locally:`

1) Download or Clone the repository
2) Install **`elm-live`** : `npm install elm-live` 

From `z-context` directory:

    elm-live src/Main.elm --pushstate -- --output=docs/elm.js

`NOTE: Images won't be displayed by using elm-live for local development. The reason is that all image hrefs start with "/z-context/" so that they will be referenced correctly when deployed GitHub Pages.`


## Project Structure

    .
    ├── docs                    # Deployment files for GitHub Pages
    │   ├── 404.html            # Takes the current url and converts the path and query string into just a query string
    │   └── redirect.js         # This script checks to see if a redirect is present in the query string and converts it back into the correct url and adds it to the browser's history
    ├── src                     # Elm Files
    │   ├── Mindstorms          # Directory for Mindstorms articles
    │   ├── Projects            # Directory for Projects articles
    │   ├── Page                # Contains main Pages
    │   ├── Route               # Routers for main pages and subpages
    │   ├── Main.elm            # Root file. Start here if you want to explore more
    │   └── ...
    └── ...

## Dependencies

* elm-explorations/markdown

## TODO

There is much to be done: 

* Server-side rendering

## Issues

