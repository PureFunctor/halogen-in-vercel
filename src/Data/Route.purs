module Site.Data.Route where

import Prelude

import Data.Generic.Rep (class Generic)
import Routing.Duplex (RouteDuplex', root)
import Routing.Duplex.Generic (noArgs, sum)


-- | Data type representing routes for the application.
data Route = IndexR

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route


-- | Codec used for parsing/printing routes.
routeCodec :: RouteDuplex' Route
routeCodec = root $ sum
  { "IndexR" : noArgs
  }
