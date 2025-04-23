module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (logShow)
import Node.Fetch (fetch')
import Node.Fetch.Response (text)

fheader :: Aff Unit
fheader = do
  rsp <- fetch' "http://httpbin.io/headers"
  j <- text rsp
  liftEffect $ logShow j

main :: Effect Unit
main = launchAff_ fheader
