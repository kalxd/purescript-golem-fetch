module Network.AHttp.URL ( module Network.AHttp.URL
                         , module Output
                         ) where

import Network.AHttp.Internal.URL as URL
import Network.AHttp.Internal.URL (URL) as Output

fromString :: String -> URL.URL
fromString = URL._url_make
