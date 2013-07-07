---
title: msiのJScriptカスタムアクションでログを出力する
categories: windows msi
---

```javascript
var msiMessageTypeInfo = 0x04000000;
var record = Session.Installer.CreateRecord(0);
record.StringData(0) = message;
Session.Message(msiMessageTypeInfo, record);
```

[出典](http://msdn.microsoft.com/ja-jp/library/xc8bz3y5%28v=vs.80%29.aspx?cs-save-lang=1&cs-lang=jscript#code-snippet-3)

ログ出力するにはmsiexecのオプションを使用する

    msiexec /l*v log.log /i Setup.msi
