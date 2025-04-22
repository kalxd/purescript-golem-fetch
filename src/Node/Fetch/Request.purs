module Node.Fetch.Request ( RequestCache(..)
                          , RequestCredentials(..)
                          , RequestMethod(..)
                          , RequestMode(..)
                          , RequestPriority(..)
                          , RequestRedirect
                          , RequestWith
                          , Request
                          , defaultRequest
                          ) where

import Prelude

import Data.Maybe (Maybe(..))
import Node.Fetch.Headers as H
import Node.Fetch.Unsafe.Fetch as F

data RequestCache = RequestCacheDefault
                  | RequestCacheNoStore
                  | RequestCacheReload
                  | RequestCacheNoCache
                  | RequestCacheForceCache
                  | RequestCacheOnlyIfCached

derive instance Eq RequestCache

instance Show RequestCache where
  show RequestCacheDefault = "RequestCacheDefault"
  show RequestCacheNoStore = "RequestCacheNoStore"
  show RequestCacheReload = "RequestCacheReload"
  show RequestCacheNoCache = "RequestCacheNoCache"
  show RequestCacheForceCache = "RequestCacheForceCache"
  show RequestCacheOnlyIfCached = "RequestCacheOnlyIfCached"

cacheToString :: RequestCache -> String
cacheToString RequestCacheDefault = "default"
cacheToString RequestCacheNoStore = "no-store"
cacheToString RequestCacheReload = "reload"
cacheToString RequestCacheNoCache = "no-cache"
cacheToString RequestCacheForceCache = "force-cache"
cacheToString RequestCacheOnlyIfCached = "only-if-cached"

data RequestCredentials = RequestCredentialsOmit
                        | RequestCredentialsSameOrigin
                        | RequestCredentialInclude

derive instance Eq RequestCredentials

data RequestMethod = RequestGet
                   | RequestHead
                   | RequestPost
                   | RequestPut
                   | RequestDelete
                   | RequestConnect
                   | RequestOptions
                   | RequestTrace
                   | RequestPatch

derive instance Eq RequestMethod

data RequestMode = RequestModeSameOrigin
                 | RequestModeCors
                 | RequestModeNoCors

derive instance Eq RequestMode

data RequestPriority = RequestPriorityHigh
                     | RequestPriorityLow
                     | RequestPriorityAuto

derive instance Eq RequestPriority

data RequestRedirect = RequestRedirectFollow
                     | RequestRedirectError
                     | RequestRedirectManual

derive instance Eq RequestRedirect

data RequestWith (f :: Type -> Type) = Request { body :: f String
                                               , cache :: f RequestCache
                                               , credentials :: f RequestCredentials
                                               , headers :: f H.Headers
                                               , keepalive :: f Boolean
                                               , method :: f RequestMethod
                                               , mode :: f RequestMode
                                               , priority :: f RequestPriority
                                               , redirect :: f RequestRedirect
                                               , referrer :: f String
                                               }

type Request = RequestWith Maybe

defaultRequest :: Request
defaultRequest = Request { body: Nothing
                         , cache: Nothing
                         , credentials: Nothing
                         , headers: Nothing
                         , keepalive: Nothing
                         , method: Nothing
                         , mode: Nothing
                         , priority: Nothing
                         , redirect: Nothing
                         , referrer: Nothing
                         }

requestToInit :: Request -> F.Request
requestToInit (Request req) = F.unwrapRequestToInit req'
  where req' = F.Request { body: req.body
                         , cache: map cacheToString req.cache
                         }
