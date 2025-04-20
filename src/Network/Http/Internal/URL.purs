module Network.Http.Internal.URL where

import Prelude

import Data.Maybe (Maybe)
import Data.Tuple (Tuple)

foreign import data URLSearchParams :: Type

instance Show URLSearchParams where
  show = _search_show

foreign import _search_empty :: URLSearchParams

foreign import _search_make :: forall a. a -> URLSearchParams

foreign import _search_show :: URLSearchParams -> String

foreign import _search_toString :: URLSearchParams -> String

foreign import _search_append :: String -> String -> URLSearchParams -> URLSearchParams

foreign import _search_delete :: String -> URLSearchParams -> URLSearchParams

foreign import _search_entries :: (String -> String -> Tuple String String) -> URLSearchParams -> Array (Tuple String String)

foreign import _search_get :: (String -> Maybe String) -> Maybe String -> String -> URLSearchParams -> Maybe String

foreign import _search_getAll :: String -> URLSearchParams -> Array String

foreign import _search_has :: String -> URLSearchParams -> Boolean

foreign import _search_keys :: URLSearchParams -> Array String

foreign import _search_set :: String -> String -> URLSearchParams -> URLSearchParams

foreign import _search_size :: URLSearchParams -> Int

foreign import _search_values :: URLSearchParams -> Array String

foreign import data URL :: Type

instance Show URL where
  show = _show

foreign import _url :: String -> URL

foreign import _show :: URL -> String
