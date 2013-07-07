---
title: VNWare Player で NATの詳細設定
categories: vmware
---

VMWare Playerのインストール先で次のコマンドを実行する

    rundll32.exe vmnetui.dll VMNetUI_ShowStandalone

また、Windows FireWallにひっかかる場合はSystem32\SysWow64かSystem32フォルダにあるvmnat.exeを許可する
