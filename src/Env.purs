module Site.Env where

import Routing.PushState (PushStateInterface)


type Env =
  { pushInterface :: PushStateInterface
  }
