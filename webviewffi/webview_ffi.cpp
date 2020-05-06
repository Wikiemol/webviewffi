#include "deps/webview.h"
#include "webview_ffi.h"

FFI_WEBVIEW_API webview_t ffi_webview_create(int debug, void *window) {
    return webview_create(debug, window);
}

FFI_WEBVIEW_API void ffi_webview_destroy(webview_t w) {
    webview_destroy(w);
}

FFI_WEBVIEW_API void ffi_webview_run(webview_t w) {
    webview_run(w);
}

FFI_WEBVIEW_API void ffi_webview_terminate(webview_t w) {
    webview_terminate(w);
}

FFI_WEBVIEW_API void
ffi_webview_dispatch(webview_t w, void (*fn)(webview_t w, void *arg), void *arg) {
    webview_dispatch(w, fn, arg);
}

FFI_WEBVIEW_API void *ffi_webview_get_window(webview_t w) {
    return webview_get_window(w);
}

FFI_WEBVIEW_API void ffi_webview_set_title(webview_t w, const char *title) {
    webview_set_title(w, title);
}

FFI_WEBVIEW_API void ffi_webview_set_size(webview_t w, int width, int height, int hints) {
    webview_set_size(w, width, height, hints);
}

FFI_WEBVIEW_API void ffi_webview_navigate(webview_t w, const char *url) {
    webview_navigate(w, url);
}

FFI_WEBVIEW_API void ffi_webview_init(webview_t w, const char *js) {
    webview_init(w, js);
}

FFI_WEBVIEW_API void ffi_webview_eval(webview_t w, const char *js) {
    webview_eval(w, js);
}

FFI_WEBVIEW_API void ffi_webview_bind(webview_t w, const char *name,
                              void (*fn)(const char *seq, const char *req,
                                         void *arg),
                              void *arg) 
                              {
                                  webview_bind(w, name, fn, arg);
                              }

FFI_WEBVIEW_API void ffi_webview_return(webview_t w, const char *seq, int status,
                                const char *result) {
                                    webview_return(w, seq, status, result);
                                }
