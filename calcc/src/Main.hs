{-# LANGUAGE LambdaCase #-}
module Main where

import Language.Calcc.Lexer (scan_it_johnny)
import Language.Calcc.Parser (parse_it_johnny)

import Control.Monad (forM_, liftM, forever, unless, when)

import System.IO (stdin, stdout, hIsEOF, hGetLine, hFlush, openFile, Handle, IOMode(ReadMode))
import System.Environment (getArgs)

main :: IO ()
main = do
        args <- getArgs
        if length args == 0
                then console True stdin
                else openFile (args !! 0) ReadMode >>= console False

console :: Bool -> Handle -> IO ()
console isStdin h = do
        when isStdin $ putStr "> "
        hFlush stdout

        isEOF <- hIsEOF h
        unless isEOF $ do
                answer <- liftM (parse_it_johnny . scan_it_johnny) $ hGetLine h
                either (\e -> putStr "-- " >> print e) print answer
                console isStdin h
