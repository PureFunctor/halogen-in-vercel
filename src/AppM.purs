module Site.AppM where

import Prelude

import Control.Monad.Reader.Trans (class MonadAsk, ReaderT, asks, runReaderT)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Routing.Duplex as RD
import Simple.JSON (write)
import Site.Capability.Navigation (class Navigate)
import Site.Data.Route (routeCodec)
import Site.Env (Env)
import Type.Prelude (class TypeEquals, from)


newtype AppM r = AppM (ReaderT Env Aff r)

runAppM :: Env -> AppM ~> Aff
runAppM env (AppM m) = runReaderT m env


derive newtype instance functorAppM :: Functor AppM
derive newtype instance applyAppM :: Apply AppM
derive newtype instance applicativeAppM ∷ Applicative AppM
derive newtype instance bindAppM ∷ Bind AppM
derive newtype instance monadAppM ∷ Monad AppM
derive newtype instance monadEffectAppM ∷ MonadEffect AppM
derive newtype instance monadAffAppM ∷ MonadAff AppM

instance monadAskAppM :: TypeEquals e Env => MonadAsk e AppM where
  ask = AppM $ asks from

instance navigateAppM :: Navigate AppM where
  navigate route = do
    pushInterface <- asks _.pushInterface
    liftEffect $ pushInterface.pushState (write { }) (RD.print routeCodec route)
