module Node.Fetch.Unsafe.Fetch where

import Prelude

import Control.Promise (Promise)
import Data.Argonaut (Json)
import Data.Maybe (Maybe, fromJust, isJust)
import Data.Tuple (Tuple)
import Effect (Effect)

foreign import data Headers :: Type

foreign import _headers_empty :: Headers
foreign import _headers_make :: forall a. a -> Headers
foreign import _headers_show :: Headers -> String
foreign import _headers_append :: String -> String -> Headers -> Headers
foreign import _headers_delete :: String -> Headers -> Headers
foreign import _headers_entries :: (String -> String -> Tuple String String) -> Headers -> Array (Tuple String String)
foreign import _headers_get :: (String -> Maybe String) -> Maybe String -> String -> Headers -> Maybe String
foreign import _headers_has :: String -> Headers -> Boolean
foreign import _headers_keys :: Headers -> Array String
foreign import _headers_set :: String -> String -> Headers -> Headers
foreign import _headers_values :: Headers -> Array String

foreign import data Response :: Type

foreign import _response_body :: forall a. Response -> Maybe a
foreign import _response_bodyUsed :: Response -> Boolean
foreign import _response_headers :: Response -> Headers
foreign import _response_ok :: Response -> Boolean
foreign import _response_redirected :: Response -> Boolean
foreign import _response_status :: Response -> Int
foreign import _response_statusText :: Response -> String
foreign import _response_type :: Response -> String
foreign import _response_json :: Response -> Effect (Promise Json)
foreign import _response_text :: Response -> Effect (Promise String)

instance Show Headers where
  show = _headers_show

foreign import _fetch_api :: forall a. a -> Effect (Promise Response)
foreign import _fetch_api2 :: forall a b. a -> b -> Effect (Promise Response)

data Request = Request { body :: Maybe String
                       , cache :: Maybe String
                       , credentials :: Maybe String
                       , headers :: Maybe Headers
                       , keepalive :: Maybe Boolean
                       , method :: Maybe String
                       , mode :: Maybe String
                       , priority :: Maybe String
                       , redirect :: Maybe String
                       , referrer :: Maybe String
                       }

foreign import _unwrap_maybe :: forall x y. (forall a. Maybe a -> Boolean) -> (forall a. Maybe a -> a) -> x -> y
foreign import _unsafe_total :: forall a b. a -> b

unsafeTotal :: forall a. (Partial => a) -> a
unsafeTotal = _unsafe_total

unwrapRequestToInit :: forall a. Request -> a
unwrapRequestToInit = _unwrap_maybe isJust (unsafeTotal fromJust)
