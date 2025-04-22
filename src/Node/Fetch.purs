module Node.Fetch where

import Prelude

import Effect (Effect)
import Node.Fetch.URL (class ToURL, toURL)
import Node.Fetch.Unsafe.Fetch as F

getJSON :: forall a. ToURL a => a -> Effect Unit
getJSON url = F._fetch_api $ toURL url
