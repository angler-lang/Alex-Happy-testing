module Language.Calcc.Lexer.Token where

data Token = Number Int
           | Operator Symbol
           | Equal
           | Let
           | Identifier String
           | LeftParen
           | RightParen

data Symbol = Plus | Minus | Times | Divide

instance Show Token where
        show (Number x)     = show x
        show (Operator x)   = show x
        show Equal          = "="
        show Let            = "let"
        show (Identifier s) = s
        show LeftParen      = "("
        show RightParen     = ")"

instance Show Symbol where
        show Plus   = "+"
        show Minus  = "-"
        show Times  = "*"
        show Divide = "/"

data CalccError = ParseError | ZeroDivision | UndefinedIdentifier String

instance Show CalccError where
        show ParseError                = "error de parseo"
        show ZeroDivision              = "división entre cero"
        show (UndefinedIdentifier idn) = "identificador " ++ idn ++ " no existe"

data IdentifierInfo = Created String | Modified String

instance Show IdentifierInfo where
        show (Created idn)  = idn ++ " creado"
        show (Modified idn) = idn ++ " modificado"

data Output = Integer Int | Message IdentifierInfo

instance Show Output where
        show (Integer n) = show n
        show (Message m) = "-- " ++ show m
