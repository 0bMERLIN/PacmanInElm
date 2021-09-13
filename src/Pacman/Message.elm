module Pacman.Message exposing
    ( -- TYPES
      Msg(..)
    )
import Pacman.Model exposing (Position)


-- MESSAGES

type Msg
    = SetTargetAPosition Position
    | SetTargetBPosition Position