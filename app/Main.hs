 {-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import WebviewFFI
import Foreign.Ptr
import Foreign.C

main :: IO ()
main = do 
    uri <- newCString "http://example.com/"
    title <- newCString "My Title"
    w <- webview_create True nullPtr
    webview_set_title w title
    webview_set_size w 500 500 0
    webview_navigate w uri

    testFunName <- newCString "helloWorld"
    helloWorldContents <- newCString "console.log('Hello world!');"
    webview_bind w testFunName (\_ _ _ -> webview_eval w helloWorldContents) nullPtr
    runHelloWorldContents <- newCString "helloWorld();"
    webview_init w runHelloWorldContents
    webview_run w
