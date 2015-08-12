{
module Language.Calcc.Parser (SymbolTable, parse_it_johnny) where

import Language.Calcc.Lexer.Token

import Data.Map (Map, member, insert)
import qualified Data.Map as Map (lookup)

import Control.Monad.Trans.State (State, runState, modify, gets)
import Control.Monad.Trans.Either (EitherT, left, runEitherT)
import Control.Monad.Trans (lift)

}

%name parseInput
%tokentype { Token }
%monad { MonadOfJohnny }
%error { omg_an_error_johnny }

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

Command :: { Output }
        : Declaration                   { Message $1 }
        | Expression                    { Integer $1 }

Expression :: { Int }
        : integer                       { $1 }
        | identifier                    {% lift (gets $ Map.lookup $1) >>=
                                                maybe (left $ UndefinedIdentifier $1) return
                                        }
        | '(' Expression ')'            { $2 }
        | Expression '+' Expression     { (+)  $1 $3 }
        | Expression '-' Expression     { (-)  $1 $3 }
        | Expression '*' Expression     { (*)  $1 $3 }
        | Expression '/' Expression     {% if $3 == 0
                                                then left ZeroDivision
                                                else return $ div $1 $3
                                        }

Declaration :: { IdentifierInfo }
        : let identifier '=' Expression {% do
                                                existed <- lift $ gets (member $2)
                                                lift $ modify (insert $2 $4)
                                                return $ (if existed then Modified else Created) $2
                                        }

{

type SymbolTable = Map String Int

type MonadOfJohnny = EitherT CalccError (State SymbolTable)

omg_an_error_johnny :: [Token] -> MonadOfJohnny a
omg_an_error_johnny _ = left ParseError

parse_it_johnny st = flip runState st . runEitherT . parseInput

}
