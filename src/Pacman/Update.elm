module Pacman.Update exposing
    ( -- FUNCTIONS
      update
    )

-- IMPORTS / LIB

import Array2D

-- IMPORTS / DOMAIN

import Pacman.Message exposing (Msg(..))
import Pacman.Model exposing (Model)

-- FUNCTIONS

update : Msg -> Model -> Model
update msg model = case msg of
   SetTargetAPosition pos -> { model | positionA = pos }
   SetTargetBPosition pos -> { model | positionB = pos }