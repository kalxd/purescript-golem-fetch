module Node.Fetch where

import Prelude

import Control.Promise (toAffE)
import Effect.Aff (Aff)
import Node.Fetch.URL (class ToURL, toURL)
import Node.Fetch.Unsafe.Fetch as F

fetch :: forall url. ToURL url => url -> F.Request -> Aff (F.Response)
fetch url req = toAffE $ F._fetch_api2 (toURL url) req

fetch' :: forall url. ToURL url => url -> Aff (F.Response)
fetch' = toAffE <<< F._fetch_api <<< toURL
