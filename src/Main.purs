module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Halogen.Aff as HA
import Halogen.Component as H
import Halogen.VDom.Driver (runUI)
import Routing.PushState (makeInterface)
import Site.AppM (runAppM)
import Site.Component.Router as Router
import Site.Data.Route as Route


main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody

  pushInterface <- liftEffect makeInterface

  let rootComponent :: H.Component Router.Query Router.Input Void Aff
      rootComponent = H.hoist (runAppM { pushInterface }) Router.component

  runUI Router.component Route.IndexR body
