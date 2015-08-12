{-# LANGUAGE LambdaCase #-}
module Main where

import Language.Calcc.Lexer (scan_it_johnny)
import Language.Calcc.Parser (SymbolTable, parse_it_johnny)

import Control.Monad (liftM, unless, when)

import Data.Map (empty)

import System.IO (stdin, stdout, hIsEOF, hGetLine, hFlush, openFile, Handle, IOMode(ReadMode))
import System.Environment (getArgs)

main :: IO ()
main = do
        args <- getArgs
        if length args == 0
                then console True empty stdin
                else openFile (args !! 0) ReadMode >>= console False empty

console :: Bool -> SymbolTable -> Handle -> IO ()
console isStdin state h = do
        when isStdin $ putStr "> "
        hFlush stdout

        isEOF <- hIsEOF h
        unless isEOF $ do
                (answer, state') <- liftM ((parse_it_johnny state) . scan_it_johnny) $ hGetLine h
                putStrLn $ either message show answer
                console isStdin state' h
        where
                message :: (Show a) => a -> String
                message = (++) "-- " . show
