module WebviewFFI
    ( 
        webview_create,
        webview_set_size,
        webview_set_title,
        webview_navigate,
        webview_run,
        Window,
        Webview
    ) where

import Foreign.Ptr
import Foreign.C

data Window = Window;
data Webview = Webview;

foreign import ccall "ffi_webview_create" webview_create :: Bool -> Ptr Window -> IO (Ptr Webview)
foreign import ccall "ffi_webview_set_size" webview_set_size :: Ptr Webview -> CInt -> CInt -> CInt -> IO ()
foreign import ccall "ffi_webview_set_title" webview_set_title :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_navigate" webview_navigate :: Ptr Webview -> CString -> IO ()
foreign import ccall "ffi_webview_run" webview_run :: Ptr Webview -> IO ()