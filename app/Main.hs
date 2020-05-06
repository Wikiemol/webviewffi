 {-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import WebviewFFI
import Foreign.Ptr
import Foreign.C

main :: IO ()
main = do 
    w <- webview_create True nullPtr
    webview_set_title w "My Title"
    webview_set_size w 500 500 0
    webview_navigate w "http://example.com/"

    webview_bind w "helloWorld" (\_ _ _ -> webview_eval w "console.log('Hello world!');") nullPtr
    webview_init w "helloWorld();"
    webview_run w
