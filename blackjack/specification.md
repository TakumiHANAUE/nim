# 目的

# ブラックジャックのルール
ブラックジャックのルールは以下の通りとする。
- プレイヤーは1人とする
- ユーザーはプレイヤーとなる
- ディーラーはコンピュータである

## ゲームの流れ
以下の順序でゲームが進行する。
1. カードを切る
1. カードを配る
1. カードを引く(プレイヤー)
1. カードを引く(ディーラー)
1. 勝敗判定
### カードを切る
トランプをシャッフルし山札を作成する。トランプはジョーカーを除く52枚を使用する。
### カードを配る
ディーラーとプレイヤーにカードを交互に配る。
それぞれの手札が2枚になるまで配る。
カードは山札の上から配る。
ディーラーは1枚目の手札を表に、2枚目を裏にする。
プレイヤーは1枚目、2枚目ともに表にする。
### カードを引く(プレイヤー)
プレイヤーは山札から1枚ずつカードを引く。
プレイヤーは引いたカードを自分の手札に追加する。
プレイヤーの手札の合計点が22点以上となった場合、その時点でプレイヤーは負けとなる。
### カードを引く(ディーラー)
ディーラーは2枚めの手札を表にする。
ディーラーは山札から1枚ずつカードを引き、自分の手札に追加する。
ディーラーは自分の手札の合計点が17点以上になるまで、山札からカードを引く。
ディーラーの手札の合計点が22点以上となった場合、その時点でディーラーは負けとなる。
## 勝敗判定
プレイヤーとディーラーの手札の合計点を比較し、21点により近いほうが勝利となる。
同点の場合は引き分けとなる。

# 機能要件
## ゲーム進行関数
- 初期化
- カードを切る
- カードを配る
- カードを引く（プレイヤー）
- カードを引く（ディーラー）
- 勝敗判定
```
```

## メンバー
### メンバ
- 手札
    - 型: Card
    - 要素数: 7
- 得点
    - 型: Score
### メソッド
- 得点を計算する
```
type
    Member = ref object of RootObj
        hand: array[0..6, Card]
        score: Score

method CalculateScore(member: Member): bool =
    
```

## プレイヤー
### メンバ
- 手札
    - 型: Card
    - 要素数: 7
- 得点
    - 型: Score
### メソッド
- ストップする
- 得点を計算する
- カードを受け取る
```
method StopDrawing(player: Player): bool =

method ReceiveCard(player: Player): bool =
```

## ディーラー
### メンバ
- 手札
    - 型: Card
    - 要素数: 7
- 得点
    - 型: Score
- 山札
    - 型: Stock
### メソッド
- カードを配る
- 山札を切る
- カードを表にする
- 得点を計算する
```
method DealCards(dealer: Dealer, player: Player): bool = 

method ShuffleStock(dealer: Dealer): bool =

method TurnUpHand(dealer: Dealer): bool = 
```

## カード
### メンバ
- マーク suit
    - 型: マーク
- 数字 number
    - 型: 数字
- 表裏 isUp
    - 型: bool (表 true, 裏 false)
```
type
    Card = tuple
        suit: Suit
        number: Number
        isUp: bool
```

## 山札
### メンバ
- カード
    - 型: カード
    - 要素数: 0 - 52 (要素数は可変)  
        マーク、数字の全ての組み合わせ(52通り)を持つ。表裏の値は裏とする
### メソッド
- 山札を切る
- カードを取得する
```
type
    Stock = ref object of RootObj
        card: seq[Card]

method ShuffleStock(stock: Stock): bool = 

mothod GetCard(stock: Stock): Card =
```

## 定義型
### 得点 Score
- 値域: 最小値 0, 最大値 30
    ```
    type
        Score = range[0..30]
    ```
### マーク Suit
- 値: スペード, ハート, クローバー, ダイヤ
    ```
    type
        Suit = enum
            Spades, Hearts, Clubs, Diamonds
    ```
### 数字 Number
- 値: A, 2, 3, ... , 10, J, Q, K
    ```
    type
        Number = enum
            (1, "A"), 2, 3, 4, 5, 6, 7, 8, 9,
            10, (11, "J"), (12 "Q"), (13, "K")
    ```

# 非機能要件
TBD