module Pacman.Pathfinding.ShortestPath exposing
    ( -- FUNCTIONS
      shortestPath
    )

-- IMPORTS / DOMAIN

import Pacman.Pathfinding.Tree exposing (Tree(..))
import Pacman.Pathfinding.SearchTree exposing (SearchTree)
import Pacman.Model exposing (Position)

-- | find the shortest path from the root to a given node
shortestPath : a -> Tree a -> Maybe (List a)
shortestPath terminator tree =
    let paths = allPathsToLeaves (removeNonTerminalBranches terminator tree)
    in List.head (List.sortBy List.length paths)

-- | find shortest path through a search tree, to a given node

removeLast : List a -> List a
removeLast l = List.reverse l |> List.tail |> Maybe.withDefault [] |> List.reverse

-- | find all paths to leaves
-- | given:
-- |           1
-- |         /  \
-- |        2    5
-- |       / \    \
-- |      3   4    6
-- | result:
-- |    [1, 2, 3], [1, 2, 4], [1, 5, 6]

allPathsToLeaves : Tree a -> List (List a)
allPathsToLeaves = allPathsToLeavesHelper []

allPathsToLeavesHelper : List a -> Tree a -> List (List a)
allPathsToLeavesHelper l tree = case tree of
    Tree a [] -> [l ++ [a]]
    Tree a forest -> List.concatMap (allPathsToLeavesHelper (l ++ [a])) forest

-- || terminals are nodes that == end position

-- | remove all non-terminal branches

removeNonTerminalBranches : a -> Tree a -> Tree a
removeNonTerminalBranches terminator (Tree value children)
    =  List.map (removeNonTerminalBranches terminator) children
    |> List.filter (isTerminalBranch terminator)
    |> Tree value

-- | test if one of the nodes in the given tree is the terminal node

isTerminalBranch : a -> Tree a -> Bool
isTerminalBranch terminator (Tree value children) =
    if value == terminator
    then True
    else children
        |> List.map (isTerminalBranch terminator)
        |> List.foldl (||) False -- true if one of the elements is `True`