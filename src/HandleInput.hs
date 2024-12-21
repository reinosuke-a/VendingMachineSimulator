module HandleInput (handleInput) where

import VendingMachine

-- ユーザーからの入力を待ち、適切なアクションを実行する関数
handleInput :: String -> VendingState -> IO VendingState
handleInput input state = case input of
    "insertCoin" -> case simulate [InsertCoin] state of
                      Right newState -> do
                        putStrLn $ "状態: " ++ show newState
                        return newState
                      Left err -> do
                        putStrLn $ "エラー: " ++ err
                        return state
    "selectItem" -> case simulate [SelectItem] state of
                      Right newState -> do
                        putStrLn $ "状態: " ++ show newState
                        return newState
                      Left err -> do
                        putStrLn $ "エラー: " ++ err
                        return state
    "dispense" -> case simulate [Dispense] state of
                      Right newState -> do
                        putStrLn $ "状態: " ++ show newState
                        putStrLn "ありがとうございました！"
                        return state
                      Left err -> do
                        putStrLn $ "エラー: " ++ err
                        return state
    "exit" -> do
        putStrLn "終了します。"
        return state
    _ -> do
        putStrLn "無効なコマンドです。もう一度試してください。"
        return state
