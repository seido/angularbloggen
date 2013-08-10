--- 
category: 
  - tomcat
  - java
date: "2013-06-03T22:57:27+09:00"
title: Tomcat7メモリ設定
---

tomcat7.conf内のJAVA_OPTSに次の様に設定

```
JAVA_OPTS="-Xms256m -Xmx750m -XX:MaxPermSize=128m"
```
- Xmsは搭載メモリの1/4程度
- Xmxは搭載メモリの半分程度
- XX:MaxPermSizeは128mもあれば十分？

confフォルダにsetenv.shを作成して次を設定という情報もあったが誤り？

```
export CATALINA_OPTS="$CATALINA_OPTS -Xms128m -Xmx256m -XX:MaxPermSize=128m"
```
