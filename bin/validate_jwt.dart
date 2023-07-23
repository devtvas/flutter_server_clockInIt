import 'package:fennec_jwt/fennec_jwt.dart';

import '../const/secret_key.dart';

validateJWT(String token) {
  var result = '';
  try {
    final claimSet = verifyJwtHS256Signature(token, Constant.secret);
    claimSet.validate(issuer: 'devtvas_jwt', audience: 'devtvas@email.com');
    result = 'JWT token valid!';
  } catch (e) {
    result = e.toString();
  }
  return result;
}
