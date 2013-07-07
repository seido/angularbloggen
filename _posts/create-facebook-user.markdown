---
title: Facebookテストユーザ作成
categories: api facebook
---

```
https://graph.facebook.com/{APP_KEY}/accounts/test-users?installed=true&name={USER_NAME}&method=post&permissions=email&access_token={APP_TOKEN}
```

* {APP_KEY} - Facebookのアプリケーションキー
* {USER_NAME} - 作成するユーザ名
* {APP_TOKEN} - app access token

permissionsは必要に応じて指定する。[参考](https://developers.facebook.com/docs/reference/login/open-graph-permissions/)

[出典](https://developers.facebook.com/docs/test_users/)
