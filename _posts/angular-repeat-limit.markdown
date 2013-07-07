---
title: ng-repeatでlimitを指定する
categories: angularjs
---

[limitToフィルタ](http://docs-angularjs-org-dev.appspot.com/api/ng.filter:limitTo)を使用すると、配列中の指定の箇所のみループできる。

    i in items | limitTo:5

マイナス値を指定すると、最後から件数分となる。

<iframe width="100%" height="200" src="http://jsfiddle.net/mAcm6/embedded/result,js,html" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

