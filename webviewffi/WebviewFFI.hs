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
foreign import ccall "ffi_webview_set_title" webview_set_title :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_set_size" webview_set_size :: Ptr Webview -> CInt -> CInt -> CInt -> IO ()
foreign import ccall "ffi_webview_navigate" webview_navigate :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_init" webview_init :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_eval" webview_eval :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_bind" c_webview_bind :: Ptr Webview -> CString -> FunPtr (BindCallback a) -> Ptr a -> IO ()
foreign import ccall "ffi_webview_return" webview_return :: Ptr Webview -> CString -> CInt -> CString -> IO ()


type DispatchCallback a = Ptr Webview -> Ptr a -> IO ()
foreign import ccall "wrapper"
  mkDispatchCallback :: DispatchCallback a -> IO (FunPtr (DispatchCallback a))

webview_dispatch :: Ptr Webview -> (DispatchCallback a) -> Ptr a -> IO ()
webview_dispatch wv callback args = do 
    c_callback <- mkDispatchCallback callback
    c_webview_dispatch wv c_callback args

type BindCallback a = CString -> CString -> Ptr a -> IO ()
foreign import ccall "wrapper"
  mkBindCallback :: BindCallback a -> IO (FunPtr (BindCallback a))

webview_bind :: Ptr Webview -> CString -> BindCallback a -> Ptr a -> IO ()
webview_bind wv name callback args = do 
    c_callback <- mkBindCallback callback
    c_webview_bind wv name c_callback args