# BlackjackOnSwift
Usage of <a href="https://github.com/Kota1021/SwiftyBlackjack" title="SwiftyBlackjack">SwiftyBlackjack</a>

You can set number of players<br>
![RocketSim_Recording_iPhone_14_Pro_2023-06-30_11 07 34](https://github.com/Kota1021/BlackjackOnSwift/assets/9388824/fe48c5cf-3964-48c1-95aa-c44dc32654a2)

![RocketSim_Recording_iPhone_14_Pro_2023-06-30_11 07 58](https://github.com/Kota1021/BlackjackOnSwift/assets/9388824/676fc468-9dfe-4233-b7af-101c9f046c34)


- 初期カードは52枚。1ゲーム中にカードの重複は起きない。
- ディーラーと任意の数のプレイヤーの対戦。ディーラーは自動、プレイヤーは実行者。
- 実行開始時、プレイヤーとディーラーはそれぞれ、カードを2枚引く。引いたカードは画面に表示する。ただし、ディーラーの2枚目のカードは分からないようにする
- その後、先にプレイヤーがカードを引く。プレイヤーが21を超えていたらバーストしてプレイヤーの負け、その時点でゲーム終了
- プレイヤーは、カードを引くたびに、次のカードを引くか選択できる
- プレイヤーが引き終えたら、その後ディーラーは、自分の手札が17以上になるまで引き続ける
- プレイヤーとディーラーが引き終えたら勝負。より21に近い方の勝ち
- JとQとKは10として扱う
- Aはとりあえず「1」としてだけ扱う。「11」にはしない
- ダブルダウンなし、スプリットなし、サレンダーなし、その他特殊そうなルールなし

### 依存関係
View → Presenter → Game → Blackjack →Card

### それぞれの責務<br>

#### 概念モジュール(SwiftyBlackjack)

###### Card
- 表面を向いているかどうか<br>
- ランク<br>
- スート<br>

###### Blackjack
- 山札
- ディーラー
- プレイヤー → 勝負の結果（Blackjackは複数人で遊べるが、その勝負はディーラー対各プレイヤーで、プレイヤー同士は干渉しない）
- 山札からドローし手札に加えるといったBlackjackの本質的な操作

#### 実装モジュール

###### Game
進行状況として
- 開始前
- プレイ中 → ゲームの進行状況
- 勝敗 → 勝負の結果
- 実際に進行する

###### GamePresenter
- Gameの保持しViewと仲介
