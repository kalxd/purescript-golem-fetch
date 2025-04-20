module Network.Http.URLSearch where

import Network.Http.Internal.URL as URL

empty :: URL.URLSearchParams
empty = URL._search_empty

singleton :: String -> String -> URL.URLSearchParams
singleton key value = URL._search_make [[key, value]]

fromString :: String -> URL.URLSearchParams
fromString = URL._search_make
