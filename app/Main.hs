 {-# LANGUAGE ForeignFunctionInterface #-}

module Main where
import WebviewFFI
import Foreign.Ptr
import Foreign.C

main :: IO ()
main = do 
    uri <- newCString "https://en.m.wikipedia.org/wiki/Main_Page"
    title <- newCString "My Title"
    w <- webview_create True nullPtr
    webview_set_title w title
    webview_set_size w 500 500 0
    webview_navigate w uri
    webview_run w
