module Site.Page.About where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Site.Capability.Navigation (class Navigate, navigate)
import Site.Data.Route (Route(..))


data Action = NavigateTo Route


component
  :: forall query input output m
   . Monad m
  => Navigate m
  => H.Component query input output m
component =
  H.mkComponent
  { initialState
  , render
  , eval: H.mkEval $ H.defaultEval
    { handleAction = handleAction
    }
  }


initialState :: forall input. input -> Unit
initialState _ = unit


render :: forall state w. state -> HH.HTML w Action
render _ =
  HH.div [ ]
  [ HH.text "About Page"
  , HH.button [ HE.onClick \_ -> NavigateTo IndexR ]
    [ HH.text "Go to Index."
    ]
  ]


handleAction
  :: forall state slots output m
   . Monad m
  => Navigate m
  => Action
  -> H.HalogenM state Action slots output m Unit
handleAction = case _ of
  NavigateTo route -> navigate route
