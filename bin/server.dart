import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'create_jwt.dart';
import 'validate_jwt.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/token', _getToken)
  ..post('/token/<message>', _validateToken)
  ..post('/login', _login);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}


Response _getToken(Request req) {
  var token = createJWT();
  return Response.ok("$token");
}

Response _validateToken(Request req) {
  final message = req.params['message'];
  if (message != null) {
    var token = validateJWT(message);
    return Response.ok("$token");
  }
  return Response.notFound('Erro no endpoint');
}

Response _login(Request req) {
  final data = req.url.data;
  if (true) {
    var email = data!.uri.data;
    var password = data;
    return Response.ok(data);
    // return Response.ok("$email - $password");
  }
}
Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
