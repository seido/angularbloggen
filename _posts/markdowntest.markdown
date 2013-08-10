--- 
category: 
  - markdown
date: "2013-06-03T22:34:11+09:00"
title: "Markdown test"
---
## コード
4つ以上インデントする

[指定例]

```
    function a() {
        var i = 0;
    }
```

[表示例]

    function a() {
        var i = 0;
    }

もしくは```を使用する

[指定例]

    ```
    hoge
    ```

[表示例]

```
hoge
```

## リスト

[指定例]

`*`を使う

```
* hoge
* fuga
```

`+`を使う

```
+ hoge
+ fuga
```

`-`を使う

```
- hoge
- fuga
```

[表示例]

- hoge
- fuga

## 数字付きリスト

[指定例]

```markdown
1. hoge
2. fuga
```

[表示例]

1. hoge
2. fuga

## ソースコード シンタックス

[指定例]

    ```javascript
    var f = function(x,y) {
   	return x+y;
    }
    ```

[表示例]

```javascript
var f = function(x,y) {
   return x+y;
}
f(1,2)
```
