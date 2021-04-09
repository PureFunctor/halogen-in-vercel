module Site.Component.Router where

import Prelude

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Site.Capability.Navigation (class Navigate)
import Site.Data.Route (Route(..))
import Site.Page.About as About
import Site.Page.Index as Index
import Type.Prelude (Proxy(..))


-- | Current state of the router.
type State = { currentRoute :: Route }


-- | Queries sent into the router.
data Query n = Navigate Route n


-- | Initial value taken by the router.
type Input = Route


-- | Slots for each page being handled.
type ChildSlots =
  ( index :: H.Slot Query Void Unit
  , about :: H.Slot Query Void Unit
  )


component
  :: forall output m
   . Monad m
  => Navigate m
  => H.Component Query Input output m
component =
  H.mkComponent
  { initialState
  , render
  , eval: H.mkEval $ H.defaultEval
    { handleQuery = handleQuery
    }
  }


initialState :: Input -> State
initialState currentRoute = { currentRoute }


render
  :: forall action m
   . Monad m
  => Navigate m
  => State
  -> H.ComponentHTML action ChildSlots m
render { currentRoute } =
  case currentRoute of
    IndexR -> HH.slot (Proxy :: _ "index") unit Index.component unit absurd
    AboutR -> HH.slot (Proxy :: _ "about") unit About.component unit absurd


handleQuery
  :: forall n action output m
   . Monad m
  => Navigate m
  => Query n
  -> H.HalogenM State action ChildSlots output m (Maybe n)
handleQuery = case _ of
  Navigate route a -> do
    H.put { currentRoute: route }
    pure $ Just a
