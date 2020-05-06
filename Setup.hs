import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Types.LocalBuildInfo
import Distribution.Types.BuildInfo
import Distribution.Compiler
import Distribution.Types.UnqualComponentName

import System.Process
import System.FilePath.Posix
import System.Directory
import System.Environment

import Data.List.Split
import Data.List
import Data.Maybe

main = defaultMainWithHooks $ simpleUserHooks {
    postConf = \args configFlags packageDescription localBuildInfo -> (do 
        let _buildDir = buildDir localBuildInfo
        output <- readProcess "clang++" [joinPath ["webviewffi", "webview_ffi.cpp"], "-std=c++11", "-framework", "WebKit", "-dynamiclib", "-o" ++ (joinPath [_buildDir, "libwebview.dylib"])] ""
        return ()
        )
}