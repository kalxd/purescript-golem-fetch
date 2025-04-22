module Node.Fetch.Request ( RequestCache(..)
                          , RequestCredentials(..)
                          , RequestMethod(..)
                          , RequestMode(..)
                          , RequestPriority(..)
                          , RequestRedirect
                          , RequestWith
                          , Request
                          , defaultRequest
                          , requestToInit
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

instance Show RequestCredentials where
  show RequestCredentialsOmit = "RequestCredentialsOmit"
  show RequestCredentialsSameOrigin = "RequestCredentialsSameOrigin"
  show RequestCredentialInclude = "RequestCredentialInclude"

credentialsToString :: RequestCredentials -> String
credentialsToString RequestCredentialsOmit = "omit"
credentialsToString RequestCredentialsSameOrigin = "same-origin"
credentialsToString RequestCredentialInclude = "include"

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

instance Show RequestMethod where
  show RequestGet = "RequestGet"
  show RequestHead = "RequestHead"
  show RequestPost = "RequestPost"
  show RequestPut = "RequestPut"
  show RequestDelete = "RequestDelete"
  show RequestConnect = "RequestConnect"
  show RequestOptions = "RequestOptions"
  show RequestTrace = "RequestTrace"
  show RequestPatch = "RequestPatch"

methodToString :: RequestMethod -> String
methodToString RequestGet = "GET"
methodToString RequestHead = "HEAD"
methodToString RequestPost = "POST"
methodToString RequestPut = "PUT"
methodToString RequestDelete = "DELETE"
methodToString RequestConnect = "CONNECT"
methodToString RequestOptions = "OPTIONS"
methodToString RequestTrace = "TRACE"
methodToString RequestPatch = "PATCH"

data RequestMode = RequestModeSameOrigin
                 | RequestModeCors
                 | RequestModeNoCors

derive instance Eq RequestMode

instance Show RequestMode where
  show RequestModeSameOrigin = "RequestModeSameOrigin"
  show RequestModeCors = "RequestModeCors"
  show RequestModeNoCors = "RequestModeNoCors"

modeToString :: RequestMode -> String
modeToString RequestModeSameOrigin = "same-origin"
modeToString RequestModeCors = "cors"
modeToString RequestModeNoCors = "no-cors"

data RequestPriority = RequestPriorityHigh
                     | RequestPriorityLow
                     | RequestPriorityAuto

derive instance Eq RequestPriority

instance Show RequestPriority where
  show RequestPriorityHigh = "RequestPriorityHigh"
  show RequestPriorityLow = "RequestPriorityLow"
  show RequestPriorityAuto = "RequestPriorityAuto"

priorityToString :: RequestPriority -> String
priorityToString RequestPriorityHigh = "RequestPriorityHigh"
priorityToString RequestPriorityLow = "RequestPriorityLow"
priorityToString RequestPriorityAuto = "RequestPriorityAuto"

data RequestRedirect = RequestRedirectFollow
                     | RequestRedirectError
                     | RequestRedirectManual

derive instance Eq RequestRedirect

instance Show RequestRedirect where
  show RequestRedirectFollow = "RequestRedirectFollow"
  show RequestRedirectError = "RequestRedirectError"
  show RequestRedirectManual = "RequestRedirectManual"

redirectToString :: RequestRedirect -> String
redirectToString RequestRedirectFollow = "RequestRedirectFollow"
redirectToString RequestRedirectError = "RequestRedirectError"
redirectToString RequestRedirectManual = "RequestRedirectManual"

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
                         , credentials: map credentialsToString req.credentials
                         , headers: req.headers
                         , keepalive: req.keepalive
                         , method: map methodToString req.method
                         , mode: map modeToString req.mode
                         , priority: map priorityToString req.priority
                         , redirect: map redirectToString req.redirect
                         , referrer: req.referrer
                         }
