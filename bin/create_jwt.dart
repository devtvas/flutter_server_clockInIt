// Creating a token

import 'package:fennec_jwt/fennec_jwt.dart';

import '../const/generate_id.dart';
import '../const/secret_key.dart';

createJWT() {
  final claimSet = JwtClaim(
    issuer: 'devtvas_jwt',
    subject: 'jwt',
    audience: <String>['devtvas@email.com'],
    jwtId: generateRandomString(32),
    otherClaims: <String, dynamic>{},
    maxAge: const Duration(seconds: 30),
  );
  final token = generateJwtHS256(claimSet, Constant.secret);

  return token;
}
