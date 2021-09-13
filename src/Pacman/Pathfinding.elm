module Pacman.Pathfinding exposing
    ( -- FUNCTIONS
      findPath
    )

-- IMPORTS / DOMAIN

import Pacman.Pathfinding.ShortestPath exposing (shortestPath)
import Pacman.Pathfinding.SearchTree exposing (searchTree)
import Pacman.Model exposing (Grid, Position)

-- FUNCTIONS

findPath : Grid -> Position -> Position -> Maybe (List Position)
findPath grid start end = shortestPath end (searchTree grid start)