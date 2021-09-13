module Pacman.Resources.GameMap exposing
    ( -- VALUES
      gameMap
    )

-- IMPORTS / LIB

import Array2D exposing (Array2D)

-- IMPORTS / DOMAIN

import Pacman.Model exposing (Cell(..))
import Pacman.Model exposing (Grid)

-- FUNCTIONS / VALUES

int2cell : Int -> Cell
int2cell n = if n <= 0 then Empty else Filled

gameMap : Grid
gameMap = Array2D.map int2cell <| Array2D.fromList
    [ [1, 1, 1, 1, 1, 1, 1]
    , [1, 0, 0, 0, 0, 0, 1]
    , [1, 0, 1, 1, 1, 0, 1]
    , [1, 0, 1, 0, 1, 0, 1]
    , [1, 0, 1, 0, 1, 0, 1]
    , [1, 0, 1, 0, 0, 0, 1]
    , [1, 1, 1, 1, 1, 1, 1]
    ]