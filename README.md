# webviewffi
Unfortunately [webviewhs](https://github.com/lettier/webviewhs) is completely broken on Mac OSX Catalina.

So this is a simple template that uses stack Setup.hs to provide a *very* thin wrapper around the most recent [webview](https://github.com/zserge/webview) library. It will only work on OSX, and has only been tested for 10.15.4 as of the time of this writing.

Why create a template instead of a package? Because [reasons](https://github.com/lettier/webviewhs/issues/7)


## To quickly get a project running 

```bash
stack new <project name> https://raw.githubusercontent.com/Wikiemol/webviewffi/master/webviewffi.hsfiles
cd <project name>
stack run
```
