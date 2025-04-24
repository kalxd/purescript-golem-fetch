module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Node.Fetch (fetch)
import Node.Fetch.Headers as H
import Node.Fetch.Request (defaultRequest, setHeaders)
import Node.Fetch.Response (json)
import Node.Fetch.Unsafe.Trace (traceShow')

fheader :: Aff Unit
fheader = do
  let h = H.fromRecord { "Content-Type": "application/json" }
  let req = setHeaders h defaultRequest
  rsp <- fetch "http://httpbin.io/headers" req
  j <- json rsp
  pure $ traceShow' j

main :: Effect Unit
main = launchAff_ fheader
