module VendingMachine where

-- 状態を定義
data VendingState = Idle | HasCoin | Dispensing
  deriving (Show, Eq)

-- 入力イベントを定義
data Input = InsertCoin | SelectItem | Dispense
  deriving (Show, Eq)

-- 状態遷移関数型を定義
transition :: VendingState -> Input -> Either String VendingState
-- 状態遷移関数を定義
transition Idle InsertCoin    = Right HasCoin
transition HasCoin SelectItem = Right Dispensing
transition Dispensing Dispense = Right Idle
transition _ _                = Left "Invalid input for current state"

-- 状態遷移のシミュレーション関数型の定義
simulate :: [Input] -> VendingState -> Either String VendingState
-- 状態遷移のシミュレーション関数の定義
simulate [] state = Right state
simulate (i:is) state =
  case transition state i of
    Right newState -> simulate is newState
    Left err       -> Left err
