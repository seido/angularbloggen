--- 
category: 
  - jekyll
date: "2013-06-03T22:43:23+09:00"
layout: post
title: "Install Jekyll!"
---

## インストール

```bash
$ sudo gem install jekyll
$ sudo gem install redcarpet
```

## サイト作成
```
$ jekyll new sitename
```

## github互換のmarkdown設定
_config.ymlに次の行を追加

```yaml
markdown: redcarpet
```

## 記事の作成
_postフォルダに次の形式の名前でファイルを作る

```
YYYY-MM-DD-タイトル.markdown
```

## サイトのビルド&表示
```bash
$ jekyll build
$ jekyll serve --watch
```

