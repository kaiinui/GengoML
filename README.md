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
