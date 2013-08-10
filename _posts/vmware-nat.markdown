--- 
category: 
  - vmware
date: "2013-06-03T22:52:23+09:00"
title: "VNWare Player で NATの詳細設定"
---

VMWare Playerのインストール先で次のコマンドを実行する

    rundll32.exe vmnetui.dll VMNetUI_ShowStandalone

また、Windows FireWallにひっかかる場合はSystem32\SysWow64かSystem32フォルダにあるvmnat.exeを許可する
