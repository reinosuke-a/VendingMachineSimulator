
## setup
### Haskell
- https://docs.haskellstack.org/en/stable/install_and_upgrade/



### 主要コマンド
- stack build
- stack run
- stack test


## 状態遷移図
### onlyNomalCase
```mermaid
stateDiagram
    Idle --> HasCoin : InsertCoin
    HasCoin --> Dispensing : SelectItem
    Dispensing --> Idle : Dispense
```

### withErrorCase
```mermaid
stateDiagram
    Idle --> HasCoin : InsertCoin
    Idle --> Error : SelectItem / Invalid Input
    Idle --> Error : Dispense / Invalid Input

    HasCoin --> Dispensing : SelectItem
    HasCoin --> Error : InsertCoin / Invalid Input
    HasCoin --> Error : Dispense / Invalid Input

    Dispensing --> Idle : Dispense
    Dispensing --> Error : InsertCoin / Invalid Input
    Dispensing --> Error : SelectItem / Invalid Input

    Error --> Idle : Reset
```
## 状態遷移表

| 現在の状態   | `InsertCoin`  | `SelectItem`  | `Dispense`  |
|--------------|---------------|---------------|-------------|
| **Idle**     | `HasCoin`     | `Error`       | `Error`     |
| **HasCoin**  | `Error`       | `Dispensing`  | `Error`     |
| **Dispensing** | `Error`     | `Error`       | `Idle`      |

