module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Node.Fetch (fetch')
import Node.Fetch.Response (json)
import Node.Fetch.Unsafe.Trace (traceShow)

fheader :: Aff Unit
fheader = do
  rsp <- fetch' "http://httpbin.io/headers"
  j <- json rsp
  void $ pure $ traceShow j
  pure unit

main :: Effect Unit
main = launchAff_ fheader
