{
{-# OPTIONS_GHC -w #-}
module Language.Calcc.Lexer (scan_it_johnny) where

import Language.Calcc.Lexer.Token

}

%wrapper "basic"

$digit = 0-9

tokens :-

        $white+                 ;
        \#.*                    ;

        $digit+                 { (Number . read) }
        \+                      { const (Operator Plus)   }
        \-                      { const (Operator Minus)  }
        \*                      { const (Operator Times)  }
        \/                      { const (Operator Divide) }

{

scan_it_johnny = alexScanTokens

}
