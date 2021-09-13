module Pacman.View exposing
    ( -- FUNCTIONS
      view
    )

-- IMPORTS / LIB

import Html exposing (div)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, custom)
import Json.Decode
import Array2D
import Array

-- IMPORTS / DOMAIN

import Pacman.Message exposing (Msg(..))
import Pacman.Model exposing (Model, Cell(..))
import Pacman.Pathfinding exposing (findPath)

-- FUNCTIONS

onRightClick : msg -> Html.Attribute msg
onRightClick msg =
    custom "contextmenu"
        (Json.Decode.succeed
            { message = msg
            , stopPropagation = True
            , preventDefault = True
            }
        )


contains : List a -> a -> Bool
contains l x = (List.filter (\v -> x == v) l |> List.length) > 0


view : Model -> Html.Html Msg
view model =
    let path = findPath model.map model.positionA model.positionB
        buttonGrid = model.map |> Array2D.indexedMap (\row col cellValue -> Html.button
            -- coloring
            [ if (row, col) == model.positionA then class "cell-green"
              else if (row, col) == model.positionB then class "cell-red"
              else if cellValue == Filled then class "cell-empty"
              else class "cell-filled"

            , class "cell"
            
            -- on clicks
            , SetTargetAPosition (row, col) |> onClick
            , SetTargetBPosition (row, col) |> onRightClick
            ]
            
            ( if contains (Maybe.withDefault [] path) (row, col)
              then [div [class "circle"] []]
              else [] ) )
    
    in buttonGrid.data
    |> Array.map (Array.toList >> div [class "line"])
    |> Array.toList |> div [class "grid"]