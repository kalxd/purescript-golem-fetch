module Node.Fetch.Unsafe.Fetch where

import Data.Maybe (Maybe)
import Data.Tuple (Tuple)

foreign import data Headers :: Type

foreign import _headers_empty :: Headers
foreign import _headers_make :: forall a. a -> Headers
foreign import _headers_append :: String -> String -> Headers -> Headers
foreign import _headers_delete :: String -> Headers -> Headers
foreign import _headers_entries :: (String -> String -> Tuple String String) -> Headers -> Array (Tuple String String)
foreign import _headers_get :: (String -> Maybe String) -> Maybe String -> String -> Headers -> Maybe String
foreign import _headers_has :: String -> Headers -> Boolean
foreign import _headers_keys :: Headers -> Array String
foreign import _headers_set :: String -> String -> Headers -> Headers
foreign import _headers_values :: Headers -> Array String
