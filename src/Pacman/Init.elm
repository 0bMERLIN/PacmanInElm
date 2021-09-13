module Pacman.Init exposing
    ( -- FUNCTIONS / VALUES
      init
    )

-- IMPORTS  / DOMAIN

import Pacman.Model exposing (Model)
import Pacman.Resources.GameMap exposing (gameMap)

-- INITIALIZATIOn

init : Model
init =
    { map = gameMap
    , positionA = (0, 0)
    , positionB = (0, 0)
    }