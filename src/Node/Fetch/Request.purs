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

data RequestCache = RequestCacheDefault
                  | RequestCacheNoStore
                  | RequestCacheReload
                  | RequestCacheNoCache
                  | RequestCacheForceCache
                  | RequestCacheOnlyIfCached

derive instance Eq RequestCache

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
