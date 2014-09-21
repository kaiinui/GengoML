gengo_parser
============

Translation order format for convenience of parsing with a script.

Background
---

gengo でたくさん頼むとマジで処理がヤバい

How
---

gengo では `[[[]]]` を無視してくれる。これは指示などに使ったりするが、今回アノテーションにも用いる。

これを使い

```
[[[@HELLO_WORLD]]]

[[[Category:UI Control, Instruction:アプリのチュートリアルに入るので、柔らかめにお願いします. 次の URL でスクリーンショットを参照してください。 , Context:http://dropbox.com/public/screenshot1.png]]]

こんにちは！

[[[/@HELLO_WORLD]]]
```

などとする。

これを翻訳すれば

```
[[[@HELLO_WORLD]]]

[[[Category:UI Control, Instruction:アプリのチュートリアルに入るので、柔らかめにお願いします. 次の URL でスクリーンショットを参照してください。 , Context:http://dropbox.com/public/screenshot1.png]]]

Hello!

[[[/@HELLO_WORLD]]]
```

などと帰ってくるので、適切にパースし、

```
//ja

"HELLO_WORLD" = "こんにちは！";
```

```
//en

"HELLO_WORLD" = "Hello!";
```

などと結果を得る。

To create an order
---

これを手動で書くのは大変なので、生成のためのフォーマットを用意する。ベースはベース言語の `.strings`

```
// base.strings

"HELLO_WORLD" = "こんにちは！";
"GOOD_EVENING" = "こんばんは！";
"GOOD_MORNING" = "おはようございます！";
"GOOD_NIGHT" = "おやすみなさい！";
```

ここにアノテーションを付ける。（`.strings` は `//` コメントを許容する）

```
// base.strings

"HELLO_WORLD" = "こんにちは！"; //@category=Label @instruction=これこれがこうです。 @screenshot=http://dropbox.com/
"GOOD_EVENING" = "こんばんは！"; //@category=Button @instruction=これこれがこうです。 @screenshot=http://dropbox.com/
"GOOD_MORNING" = "おはようございます！"; //@category=Title @instruction=これこれがこうです。 @screenshot=http://dropbox.com/
"GOOD_NIGHT" = "おやすみなさい！"; //@category=Prompt @instruction=これこれがこうです。 @screenshot=http://dropbox.com/
```

（ところで、スクリーンショットを得るために、UI テストのフレームワークを使ってシナリオを記述し、元言語のスクリーンショットを得る。これは、国際対応した際に画面崩れが無いか、あるいはきちんと出力出来ているかを確認するためにも役立つ。）

これを利用して、上記のオーダフォーマットを生成する。

Concerns
---

- 翻訳に関係ない文章多過ぎて、翻訳者としてうざくないか？ -> ウザいと思う。
- 結果が帰ってくるときに ```[[[]]]``` が消される可能性。 -> 冒頭に `[[[DO NOT DELETE [] SURROUNDED STATRMENTS.]]]` とか付ける. 消えたら仕方ない。手動で頑張る。それくらいは仕方ない。
- 結果を取得するために？ -> Gengo API を使う
