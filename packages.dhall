let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.14.0-20210406/packages.dhall sha256:7b6af643c2f61d936878f58b613fade6f3cb39f2b4a310f6095784c7b5285879

in upstream
     with express =
       { dependencies =
         [ "aff"
         , "arrays"
         , "console"
         , "effect"
         , "either"
         , "exceptions"
         , "foreign"
         , "foreign-generic"
         , "foreign-object"
         , "functions"
         , "maybe"
         , "node-http"
         , "prelude"
         , "psci-support"
         , "strings"
         , "test-unit"
         , "transformers"
         , "unsafe-coerce"
         ]
       , repo =
           "https://github.com/PureFunctor/purescript-express"
       , version =
           "purs-v0.14"
       }
