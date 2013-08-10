--- 
category: 
  - windows
  - msi
date: "2013-06-03T22:47:15+09:00"
title: msiのカスタムアクションでインストール先ディレクトリのパスを取得する
---

```javascript
Session.TargetPath("TARGETDIR")
```

[出典](http://msdn.microsoft.com/ja-jp/library/windows/desktop/aa371685%28v=vs.85%29.aspx)

なぜ"TARGETDIR"が必要なのか不明、、
