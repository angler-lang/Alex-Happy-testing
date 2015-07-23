{
module Language.Calcc.Parser (parse_it_johnny) where

import Language.Calcc.Lexer.Token

}

%name parse_it_johnny
%tokentype { Token }
%monad { Either CalccError }
%error { omg_it's_an_error_johnny }

%token
        integer           { Number $$ }
        '+'               { Operator Plus   }
        '-'               { Operator Minus  }
        '*'               { Operator Times  }
        '/'               { Operator Divide }

%%

Expression :: { Int }
        : integer                       { $1 }
        | '+' Expression Expression     { (+)  $2 $3 }
        | '-' Expression Expression     { (-)  $2 $3 }
        | '*' Expression Expression     { (*)  $2 $3 }
        | '/' Expression Expression     {% if $3 == 0
                                                then Left ZeroDivision
                                                else return $ div $2 $3
                                        }

{

omg_it's_an_error_johnny = const $ Left ParseError

}
