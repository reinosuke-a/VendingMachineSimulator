module Main (main) where

import VendingMachine
import Control.Monad (forever)
import HandleInput (handleInput)

-- メインのループ
main :: IO ()
main = do
    putStrLn "自動販売機シミュレーション開始！"
    putStrLn "使用可能なコマンド: insertCoin, selectItem, dispense, exit"
    runVendingMachine Idle

-- 自動販売機の動作をループさせる関数
runVendingMachine :: VendingState -> IO ()
runVendingMachine state = do
    putStrLn $ "現在の状態: " ++ show state
    putStrLn "いらっしゃいませ。コマンドを入力してください。 : insertCoin, selectItem, dispense, exit"
    input <- getLine
    newState <- handleInput input state
    if input == "exit"
        then return ()
        else runVendingMachine newState
