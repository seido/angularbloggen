--- 
title: JsonTokenでJWTをシリアライズ
date: "2013-08-18T22:49:22+09:00"
category: jsontoken jwt
---

いろいろ探しまわっても情報がなかったが、コードみながらなんとか動作させることができた。
Checkerの使い方が怪しい。。

``` java
final Verifier verifier;
try {
	verifier = new HmacSHA256Verifier("XXX-SECRET-KEY-XXX".getBytes());
} catch (InvalidKeyException ex) {
	throw new RuntimeException(ex);
}
VerifierProvider hmacLocator = new VerifierProvider() {
	@Override
		public List<Verifier> findVerifier(String id, String key) {
			return Arrays.asList(verifier);
		}
};
VerifierProviders vp = new VerifierProviders();
vp.setVerifierProvider(SignatureAlgorithm.HS256, hmacLocator);
JsonToken token;
try {
	JsonTokenParser parser = new JsonTokenParser(vp, new Checker() {
		@Override
		public void check(JsonObject payload) throws SignatureException {
			// 何もチェックしない
		}
	});
	token = parser.verifyAndDeserialize(jwt);
} catch (SignatureException ex) {
	throw new RuntimeException(ex);
}
```

