module Main where

import Prelude

import Data.Either (hush)
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Routing.Duplex (parse)
import Routing.PushState (makeInterface)
import Site.AppM (runAppM)
import Site.Component.Router as Router
import Site.Data.Route (routeCodec)
import Site.Data.Route as Route
import Web.HTML (window)
import Web.HTML.Location as Location
import Web.HTML.Window as Window


main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody

  pushInterface <- liftEffect makeInterface

  let rootComponent :: H.Component Router.Query Router.Input Void Aff
      rootComponent = H.hoist (runAppM { pushInterface }) Router.component

  route <- liftEffect $ do
    window >>= Window.location >>= Location.pathname
      <#> fromMaybe Route.IndexR <<< hush <<< parse routeCodec

  halogenIO <- runUI rootComponent route body

  void $ liftEffect $ pushInterface.listen \location ->
    case hush $ parse routeCodec $ location.pathname of
      Just new ->
        launchAff_ $ halogenIO.query $ H.mkTell $ Router.Navigate new
      Nothing ->
        pure unit
