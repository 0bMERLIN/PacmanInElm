module Pacman.Model exposing
    ( -- TYPES
      Model
    , Grid
    , Cell(..)
    , Position
    )

-- IMPORTS / LIB

import Array2D exposing (Array2D)

-- MODEL

type alias Position = (Int, Int)

type Cell = Empty | Filled

type alias Grid = Array2D Cell

type alias Model =
    { map : Grid
    , positionA : Position
    , positionB : Position
    }
