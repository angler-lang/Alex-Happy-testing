module Language.Calcc.Lexer.Token where

data Token = Number Int | Operator Symbol
data Symbol = Plus | Minus | Times | Divide

instance Show Token where
        show (Number x)   = show x
        show (Operator x) = show x

instance Show Symbol where
        show Plus   = "+"
        show Minus  = "-"
        show Times  = "*"
        show Divide = "/"

data CalccError = ParseError | ZeroDivision

instance Show CalccError where
        show ParseError   = "error de parseo"
        show ZeroDivision = "división entre cero"
