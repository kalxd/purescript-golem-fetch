module Node.Fetch.Unsafe.Trace where

-- | 类似于Haskell的Debug.Trace之traceShowId。
-- |
-- | `traceShow`内部使用`console.log`打印。
foreign import traceShow :: forall a. a -> a
