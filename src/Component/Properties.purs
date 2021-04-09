module Site.Component.Properties where

import Prelude

import Data.Array as Array
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP


-- | Applies CSS classes.
css :: forall r i. String -> HP.IProp (class :: String | r) i
css = HP.class_ <<< HH.ClassName


-- | Applies a list of CSS classes.
css' :: forall r i. Array String -> HP.IProp (class :: String | r) i
css' = css <<< Array.intercalate " "
