module Main exposing (main)

-- IMPORTS / LIB

import Browser

-- IMPORTS / DOMAIN

import Pacman.Model exposing (Model)
import Pacman.Message exposing (Msg)
import Pacman.View exposing (view)
import Pacman.Update exposing (update)
import Pacman.Init exposing (init)

-- MAIN

main : Program () Model Msg
main = Browser.sandbox
    { init = init
    , view = view
    , update = update
    }