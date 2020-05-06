#ifdef __cplusplus
#ifndef FFI_WEBVIEW_API
#define FFI_WEBVIEW_API extern "C"
#endif
#else
#ifndef FFI_WEBVIEW_API
#define FFI_WEBVIEW_API 
#endif
#endif

typedef void *ffi_webview_t;

// Creates a new webview instance. If debug is non-zero - developer tools will
// be enabled (if the platform supports them). Window parameter can be a
// pointer to the native window handle. If it's non-null - then child WebView
// is embedded into the given parent window. Otherwise a new window is created.
// Depending on the platform, a GtkWindow, NSWindow or HWND pointer can be
// passed here.
FFI_WEBVIEW_API ffi_webview_t ffi_webview_create(int debug, void *window);

// Destroys a webview and closes the native window.
FFI_WEBVIEW_API void ffi_webview_destroy(ffi_webview_t w);

// Runs the main loop until it's terminated. After this function exits - you
// must destroy the webview.
FFI_WEBVIEW_API void ffi_webview_run(ffi_webview_t w);

// Stops the main loop. It is safe to call this function from another other
// background thread.
FFI_WEBVIEW_API void ffi_webview_terminate(ffi_webview_t w);

// Posts a function to be executed on the main thread. You normally do not need
// to call this function, unless you want to tweak the native window.
FFI_WEBVIEW_API void
ffi_webview_dispatch(ffi_webview_t w, void (*fn)(ffi_webview_t w, void *arg), void *arg);

// Returns a native window handle pointer. When using GTK backend the pointer
// is GtkWindow pointer, when using Cocoa backend the pointer is NSWindow
// pointer, when using Win32 backend the pointer is HWND pointer.
FFI_WEBVIEW_API void *ffi_webview_get_window(ffi_webview_t w);

// Updates the title of the native window. Must be called from the UI thread.
FFI_WEBVIEW_API void ffi_webview_set_title(ffi_webview_t w, const char *title);

// Window size hints
// #define WEBVIEW_HINT_NONE 0  // Width and height are default size
// #define WEBVIEW_HINT_MIN 1   // Width and height are minimum bounds
// #define WEBVIEW_HINT_MAX 2   // Width and height are maximum bounds
// #define WEBVIEW_HINT_FIXED 3 // Window size can not be changed by a user
// Updates native window size. See WEBVIEW_HINT constants.
FFI_WEBVIEW_API void ffi_webview_set_size(ffi_webview_t w, int width, int height,
                                  int hints);

// Navigates webview to the given URL. URL may be a data URI, i.e.
// "data:text/text,<html>...</html>". It is often ok not to url-encode it
// properly, webview will re-encode it for you.
FFI_WEBVIEW_API void ffi_webview_navigate(ffi_webview_t w, const char *url);

// Injects JavaScript code at the initialization of the new page. Every time
// the webview will open a the new page - this initialization code will be
// executed. It is guaranteed that code is executed before window.onload.
FFI_WEBVIEW_API void ffi_webview_init(ffi_webview_t w, const char *js);

// Evaluates arbitrary JavaScript code. Evaluation happens asynchronously, also
// the result of the expression is ignored. Use RPC bindings if you want to
// receive notifications about the results of the evaluation.
FFI_WEBVIEW_API void ffi_webview_eval(ffi_webview_t w, const char *js);

// Binds a native C callback so that it will appear under the given name as a
// global JavaScript function. Internally it uses webview_init(). Callback
// receives a request string and a user-provided argument pointer. Request
// string is a JSON array of all the arguments passed to the JavaScript
// function.
FFI_WEBVIEW_API void ffi_webview_bind(ffi_webview_t w, const char *name,
                              void (*fn)(const char *seq, const char *req,
                                         void *arg),
                              void *arg);

// Allows to return a value from the native binding. Original request pointer
// must be provided to help internal RPC engine match requests with responses.
// If status is zero - result is expected to be a valid JSON result value.
// If status is not zero - result is an error JSON object.
FFI_WEBVIEW_API void ffi_webview_return(ffi_webview_t w, const char *seq, int status,
                                const char *result);