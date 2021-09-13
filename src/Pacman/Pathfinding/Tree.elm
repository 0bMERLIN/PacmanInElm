module Pacman.Pathfinding.Tree exposing
    ( -- TYPES
      Tree(..)
    )

-- TYPES

type Tree a = Tree a (List (Tree a))