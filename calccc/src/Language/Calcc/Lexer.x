{
{-# OPTIONS_GHC -w #-}
module Language.Calcc.Lexer (scan_it_johnny) where

import Language.Calcc.Lexer.Token

}

%wrapper "basic"

$digit = 0-9
$alpha = [_a-zA-Z]
$ident = $alpha[$alpha $digits]*

tokens :-

        $white+                 ;
        \#.*                    ;

        $digit+                 { (Number . read) }
        \(                      { const LeftParen }
        \)                      { const RightParen }
        \+                      { const (Operator Plus)   }
        \-                      { const (Operator Minus)  }
        \*                      { const (Operator Times)  }
        \/                      { const (Operator Divide) }
        \=                      { const Equal }
        let                     { const Let }
        id                      { Identifier }

{

scan_it_johnny = alexScanTokens

}
