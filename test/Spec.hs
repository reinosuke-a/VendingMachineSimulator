import Test.Hspec
import Lib (simulate, VendingState(..), Input(..))

main :: IO ()
main = hspec $ do
  describe "Vending Machine State Transitions" $ do
    -- Idle 状態からの遷移
    it "should transition from Idle to HasCoin with InsertCoin" $
      simulate [InsertCoin] Idle `shouldBe` Right HasCoin

    it "should return error when selecting item from Idle" $
      simulate [SelectItem] Idle `shouldBe` Left "Invalid input for current state"

    it "should return error when dispensing from Idle" $
      simulate [Dispense] Idle `shouldBe` Left "Invalid input for current state"
    
    -- HasCoin 状態からの遷移
    it "should transition from HasCoin to Dispensing with SelectItem" $
      simulate [SelectItem] HasCoin `shouldBe` Right Dispensing

    it "should return error when inserting coin again from HasCoin" $
      simulate [InsertCoin] HasCoin `shouldBe` Left "Invalid input for current state"

    it "should return error when dispensing from HasCoin" $
      simulate [Dispense] HasCoin `shouldBe` Left "Invalid input for current state"
    
    -- Dispensing 状態からの遷移
    it "should transition from Dispensing to Idle with Dispense" $
      simulate [Dispense] Dispensing `shouldBe` Right Idle

    it "should return error when inserting coin from Dispensing" $
      simulate [InsertCoin] Dispensing `shouldBe` Left "Invalid input for current state"

    it "should return error when selecting item from Dispensing" $
      simulate [SelectItem] Dispensing `shouldBe` Left "Invalid input for current state"

    -- 複数の入力に対するシミュレーション（例：順番通りに遷移するケース）
    it "should transition correctly for a valid sequence of inputs" $
      simulate [InsertCoin, SelectItem, Dispense] Idle `shouldBe` Right Idle

    -- 複数の入力でエラーが発生するケース（例：不正な遷移が続く場合）
    it "should return error for invalid sequence of inputs" $
      simulate [InsertCoin, Dispense, SelectItem] Idle `shouldBe` Left "Invalid input for current state"
