module WebviewFFI
    ( 
        webview_create,
        webview_destroy,
        webview_run,
        webview_terminate,
        webview_dispatch,
        webview_get_window,
        webview_set_title,
        webview_set_size,
        webview_navigate,
        webview_init,
        webview_eval,
        webview_bind,
        webview_return,
        Window,
        Webview
    ) where

import Foreign.Ptr
import Foreign.C

data Window = Window;
data Webview = Webview;
foreign import ccall "ffi_webview_create" webview_create :: Bool -> Ptr Window -> IO (Ptr Webview)
foreign import ccall "ffi_webview_destroy" webview_destroy :: Ptr Webview -> IO ()
foreign import ccall "ffi_webview_run" webview_run :: Ptr Webview -> IO ()
foreign import ccall "ffi_webview_terminate" webview_terminate :: Ptr Webview -> IO ()
foreign import ccall "ffi_webview_dispatch" c_webview_dispatch :: Ptr Webview -> FunPtr (DispatchCallback a) -> Ptr a -> IO ()
foreign import ccall "ffi_webview_get_window" webview_get_window :: Ptr Webview -> IO (Ptr Window)
foreign import ccall "ffi_webview_set_title" c_webview_set_title :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_set_size" webview_set_size :: Ptr Webview -> CInt -> CInt -> CInt -> IO ()
foreign import ccall "ffi_webview_navigate" c_webview_navigate :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_init" c_webview_init :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_eval" c_webview_eval :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_bind" c_webview_bind :: Ptr Webview -> CString -> FunPtr (BindCallback a) -> Ptr a -> IO ()
foreign import ccall "ffi_webview_return" c_webview_return :: Ptr Webview -> CString -> CInt -> CString -> IO ()


type DispatchCallback a = Ptr Webview -> Ptr a -> IO ()
foreign import ccall "wrapper"
  mkDispatchCallback :: DispatchCallback a -> IO (FunPtr (DispatchCallback a))

webview_dispatch :: Ptr Webview -> (DispatchCallback a) -> Ptr a -> IO ()
webview_dispatch wv callback args = do 
    c_callback <- mkDispatchCallback callback
    c_webview_dispatch wv c_callback args

webview_set_title :: Ptr Webview -> String -> IO ()
webview_set_title wv title = do
    c_title <- newCString title
    c_webview_set_title wv c_title

webview_navigate :: Ptr Webview -> String -> IO ()
webview_navigate wv url = do
    c_url <- newCString url
    c_webview_navigate wv c_url

type JavaScript = String
webview_init :: Ptr Webview -> JavaScript -> IO ()
webview_init wv js = do
    c_js <- newCString js
    c_webview_init wv c_js

webview_eval :: Ptr Webview -> JavaScript -> IO ()
webview_eval wv js = do
    c_js <- newCString js
    c_webview_eval wv c_js

webview_return :: Ptr Webview -> String -> CInt -> String -> IO ()
webview_return wv str1 int str2 = do
    c_str1 <- newCString str1
    c_str2 <- newCString str2
    c_webview_return wv c_str1 int c_str2


type BindCallback a = CString -> CString -> Ptr a -> IO ()
foreign import ccall "wrapper"
  mkBindCallback :: BindCallback a -> IO (FunPtr (BindCallback a))

webview_bind :: Ptr Webview -> String -> BindCallback a -> Ptr a -> IO ()
webview_bind wv name callback args = do 
    c_name <- newCString name
    c_callback <- mkBindCallback callback
    c_webview_bind wv c_name c_callback args