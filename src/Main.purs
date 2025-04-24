module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Node.Fetch (fetch)
import Node.Fetch.Request (RequestMethod(..), defaultRequest, setBodyForm, setHeader, setMethod)
import Node.Fetch.Response (json)
import Node.Fetch.URLSearch as S
import Node.Fetch.Unsafe.Trace (traceShow')

fheader :: Aff Unit
fheader = do
  let req = setHeader "X-Version" "X.1" defaultRequest
      s = S.fromRecord { name: 1, age: "other dog" }
  rsp <- fetch "http://httpbin.io/anything" $ setBodyForm s $ setMethod RequestPost req
  j <- json rsp
  pure $ traceShow' j

main :: Effect Unit
main = launchAff_ fheader
