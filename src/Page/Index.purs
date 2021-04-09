module Site.Page.Index where

import Prelude

import Halogen as H
import Halogen.HTML as HH


component
  :: forall query input output m
   . H.Component query input output m
component =
  H.mkComponent
  { initialState
  , render
  , eval: H.mkEval $ H.defaultEval
  }


initialState :: forall input. input -> Unit
initialState _ = unit


render :: forall state w i. state -> HH.HTML w i
render _ = HH.div [ ] [ HH.text "Hello, World." ]
