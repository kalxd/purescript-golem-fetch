# purescript-node-fetch
纯Node.js运行时fetch的purescript实现，无法在浏览器中运行。

该库是fetch的中层封装。

# 又一个轮子
使用spago时常需要使用代理，然而spago使用的[js-fetch](https://pursuit.purescript.org/packages/purescript-fetch/4.1.0)
底层依然是fetch，目前并没有代理功能，于是想着能否自己实现一个。同时实现一个更高层的封装。

后来发现已经有这个[提案](https://github.com/nodejs/undici/discussions/2167)了。
于是可以等这个功能实现，就可以在自己的代码里提供这个功能。

# 不足之处
为了满足纯函数式范式，很多不会改变原始值（追求不可变性）的操作会导致性能不足，每次都会全量复制一份。

同时为了减少不必要依赖（有些库仅仅简单封装，没有提供不可变性数所结构），部分功能没有支持，例如`Buffer`和`TypedArray`。

# 示例

## 处理请求

可以使用`fetch'`直接发送请求，跟运行`fetch(url)`一样的效果。

```purescript
import Node.Fetch (fetch')

action :: Aff Unit
action = do
  rsp <- fetch' "http://httpbin.io"
  {-# ... #-}
```
返回一个Response，效果与`await fetch("http://httpbin.io")`相同。

## 处理请求Headers

`fetch`接受两个参数，跟node的`fetch`效果一样。

```purescript
import Node.Fetch (fetch)
import Node.Fetch.Request (defaultRequest, setHeader)

action :: Aff Unit
action = do
  let req = setHeader "Header1" "Value1" $ setHeader "X-Ver" "1" defaultRequest
  rsp <- fetch "http://httpbin.io" req
  {-# ... #-}
```
效果跟node的`fetch`一致，同样返回一个Response。

`defaultRequest`提供默认请求体，可以在`Node.Fetch.Request`查看所有操作。

## 处理响应

目前仅提供了`text()`和`json()`方法，不支持二进制。

```purescript
action :: Aff Unit
action = do
  rsp <- fetch
  rspText :: String <- text rsp
  {-# ... #-}
```

`text`相当于调用`rsp.text()`。

```purescript
action :: Aff Unit
action = do
  rsp <- fetch
  jsonValue :: Json <- json rsp
  {-# ... #-}
```

`json`相当于调用`rsp.json()`，返回一个`Json`对象，需要用户自行处理，目前还未支持`DecodeJson`操作。

## 发送JSON

JSON现在互联网最普遍格式，所以理所当然会支持这个格式。

```purescript
import Node.Fetch.Request (setBodyJson, defaultRequest)

data Dog = Dog {-# 用户自行实现 #-}

instance EncodeJson Dog where
  encodeJson = {-# 自行实现 #-}

action :: Aff Unit
action = do
  let body = Dog
  rsp <- fetch "http://httpio.com" $ setBodyJson body defaultRequest
  {-# ... #-}
```

`setBodyJson`能自动设置请求头`Content-Type: application/json`，自动转义body。
`setBodyJson'`是`setBodyJson`简化版，不会设置请求头，仅转义body。

## 发送Form

使用方法同发送JSON，唯一不同在于不依赖`EncodeJson`，仅需要传`URLSearchParams`。

```purescript
import Node.Fetch.Request (setBodyForm, defaultRequest)
import Node.Fetch.URLSearch as S

action :: Aff Unit
action = do
  let body = S.singleton "key" "value"
  rsp <- fetch "http://httpio.com" $ setBodyForm body defaultRequest
  {-# ... #-}
```

同样提供`setBodyForm'`简化版。

# 协议

AGPL v3
