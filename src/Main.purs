module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Node.Fetch (fetch)
import Node.Fetch.Request (RequestMethod(..), defaultRequest, setHeader, setMethod)
import Node.Fetch.Response (json)
import Node.Fetch.Unsafe.Trace (traceShow')

fheader :: Aff Unit
fheader = do
  let req = setHeader "Content-Type" "application/json" $ setHeader "X-Version" "X.1" defaultRequest
  rsp <- fetch "http://httpbin.io/anything" $ setMethod RequestPost req
  j <- json rsp
  pure $ traceShow' j

main :: Effect Unit
main = launchAff_ fheader
