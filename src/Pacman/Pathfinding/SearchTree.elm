module Pacman.Pathfinding.SearchTree exposing
    ( -- TYPES
      SearchTree
      
      -- FUNCTIONS
    , searchTree
    )

-- IMPORTS / DOMAIN

import Pacman.Model exposing (Grid, Position, Cell(..))
import Pacman.Pathfinding.Tree exposing (Tree(..))

-- IMPORTS / LIB

import Array2D
import Set

-- TYPES

type alias SearchTree = Tree Position

type alias Visited = List Position

-- FUNCTIONS / VALUES

-- | turns a list of `Maybe a` values into a list of `a`s

unwrapMaybes : List (Maybe a) -> List a
unwrapMaybes mbs = List.concatMap (Maybe.map List.singleton >> Maybe.withDefault []) mbs

-- | add two tuples of ints

addPositions : Position -> Position -> Position
addPositions a b = (Tuple.first a + Tuple.first b, Tuple.second a + Tuple.second b)

-- | get the value of a cell at a given grid position

gridAt : Grid -> Position -> Maybe Cell
gridAt grid pos = Array2D.get (Tuple.first pos) (Tuple.second pos) grid

-- | find all neighbours at a given position

neighbours : Grid -> Position -> List (Position, Cell)
neighbours grid at =
    let offsets = [ (0, -1), (-1, 0), (1,  0), (0,  1) ]
        potentialNeighbours = List.map (\offset ->
                let pos = addPositions at offset
                in Maybe.map (Tuple.pair pos) (gridAt grid pos))
                offsets
    in unwrapMaybes potentialNeighbours

-- | find all the neighbours of the given position, that are empty

emptyNeighbours : Grid -> Position -> List Position
emptyNeighbours grid position
    =  neighbours grid position                      -- 1. get surrounding cells (in a plus pattern) around `current`
    |> List.filter (\(pos, state) -> state == Empty) -- 2. filter out all the cells, we can't walk through
    |> List.map Tuple.first                          -- 3. get rid of cell states, we only need positions

-- | find all the neighbours of the given position, that are empty and not in the given list of visited positions

nonVisitedEmptyNeighbours : List Position -> Grid -> Position -> List Position
nonVisitedEmptyNeighbours visited grid position = Set.diff (Set.fromList (emptyNeighbours grid position)) (Set.fromList visited) |> Set.toList

-- | recursive helper for `searchTree`
createSearchTree : Visited -> Grid -> Position -> SearchTree
createSearchTree visited grid current
    -- 1. get all walkable neighbours
    =  nonVisitedEmptyNeighbours visited grid current
    -- 2. repeat for all those neighbours (then get their neighbours etc. etc., until there are none left / list of walkable neighbours is empty)
    |> List.map (createSearchTree (current :: visited) grid)
    -- 3. wrap in tree structure
    |> Tree current

-- | nice interface for `createSearchTree` (with state initialized properly)

searchTree : Grid -> Position -> SearchTree
searchTree = createSearchTree []