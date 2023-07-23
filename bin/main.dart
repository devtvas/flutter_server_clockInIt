import 'dart:math';

import 'package:fennec_jwt/fennec_jwt.dart';

final String sharedSecret = '123456';
void main(List<String> arguments) {
  final claimSet = JwtClaim(
    issuer: 'fennec_jwt',
    subject: 'jwt',
    audience: <String>['fennec_jwt@test.com'],
    jwtId: generateRandomString(32),
    otherClaims: <String, dynamic>{},
    maxAge: const Duration(seconds: 5),
  );
  final token = generateJwtHS256(claimSet, sharedSecret);

  print('JWT: "$token"\n');
  validateJwt(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiZmVubmVjX2p3dEB0ZXN0LmNvbSJdLCJleHAiOjE2OTAwOTQ4NTAsImlhdCI6MTY5MDA5NDg0NSwiaXNzIjoiZmVubmVjX2p3dCIsImp0aSI6ImhqaXdgY2tmaHR1Y2lnZmN5XXZma1lwWnlfYWl5WVxcYyIsInN1YiI6Imp3dCJ9.RUGz_SLeAMUsTdniEUnMNQFxiiin-7HZRppmgBXMQ7Q");
}

void validateJwt(String token) {
  var result = '';
  try {
    final claimSet = verifyJwtHS256Signature(token, sharedSecret);
    claimSet.validate(issuer: 'fennec_jwt', audience: 'fennec_jwt@test.com');
    print('success');
  } catch (e) {
    print(e);
  }
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}
