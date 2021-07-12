{-# LANGUAGE OverloadedStrings #-}
module Main where
  
import Network.HTTP.Types (ok200, status200, status404)
import Network.Wai (Application, responseLBS, responseBuilder, pathInfo)
import Network.Wai.Handler.Warp (run) 

main :: IO ()
main = Network.Wai.Handler.Warp.run 8000 router

router :: Network.Wai.Application
router req =
  case Network.Wai.pathInfo req of
    []       -> helloApp req
    ["foo"]  -> fooApp req
    _        -> notFoundApp req

helloApp :: Network.Wai.Application
helloApp req send 
  = send $ Network.Wai.responseBuilder Network.HTTP.Types.status200 [] "hello wai!"

fooApp :: Network.Wai.Application
fooApp req send
  = send $ Network.Wai.responseBuilder Network.HTTP.Types.status200 [] "bar buz"

notFoundApp :: Network.Wai.Application
notFoundApp req send
  = send $ Network.Wai.responseBuilder Network.HTTP.Types.status404 [] "not found"
