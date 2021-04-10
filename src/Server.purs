module Server where

import Prelude hiding (apply)

import Effect (Effect)
import Node.Express.App (App, apply, get)
import Node.Express.Response (send)
import Node.Express.Types (Application)


app :: App
app = do
  get "*" $ send "Hello, World"


attach :: Application -> Effect Unit
attach = apply app
