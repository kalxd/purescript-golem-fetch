module Node.Fetch where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Compat (fromEffectFnAff)
import Node.Fetch.URL (class ToURL, toURL)
import Node.Fetch.Unsafe.Fetch as F

fetch :: forall url. ToURL url => url -> F.Request -> Aff (F.Response)
fetch url req = fromEffectFnAff $ F._fetch_api2 (toURL url) req

fetch' :: forall url. ToURL url => url -> Aff (F.Response)
fetch' = fromEffectFnAff <<< F._fetch_api <<< toURL
