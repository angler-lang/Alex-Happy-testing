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
        '('               { LeftParen  }
        ')'               { RightParen }
        '='               { Equal }
        let               { Let }
        identifier        { Identifier $$ }

%left '+' '-'
%left '*' '/'

%%

Declaration :: { Interpreter }
        : let identifier '=' Expression {}

Expression :: { Int }
        : integer                       { $1 }
        | '(' Expression ')'            { $2 }
        | Expression '+' Expression     { (+)  $2 $3 }
        | Expression '-' Expression     { (-)  $2 $3 }
        | Expression '*' Expression     { (*)  $2 $3 }
        | Expression '/' Expression     {% if $3 == 0
                                                then Left ZeroDivision
                                                else return $ div $2 $3
                                        }

{

type InterpreterState = IS { values :: Map String Int
                           , error  :: Maybe CalccError
                           }

omg_it's_an_error_johnny _ = modify (st -> st {error = Just ParseError})

}
