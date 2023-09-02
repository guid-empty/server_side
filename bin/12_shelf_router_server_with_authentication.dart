import 'dart:convert';
import 'dart:io';

import 'package:server_side/src/common/authentication_exception.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

///
/// http://localhost:8080/json
/// http://localhost:8080/echo/somemessage
/// http://localhost:8080/echo/somemessage/error
///
Future<void> main() async {
  final router = Router()
    ..get('/json', _jsonHandler)
    ..get('/echo/<message>', _echoHandler);

  await serve(router, InternetAddress.anyIPv4, 8080);
}

Future<void> _checkAuthentication(String? token) async {
  if (token?.contains('Bearer') ?? false) {
    //  some validation logic here
    return;
  }

  throw AuthenticationException();
}

Future<Response> _echoHandler(Request request) async {
  final message = request.params['message'];
  final oauthToken = request.headers[HttpHeaders.authorizationHeader];
  await _checkAuthentication(oauthToken);

  return Response.ok('$message\n');
  return Response.forbidden('Request is not authorized!');
}

Future<Response> _jsonHandler(Request request) async {
  final oauthToken = request.headers[HttpHeaders.authorizationHeader];
  await _checkAuthentication(oauthToken);

  return Response.ok(
    jsonEncode(
      {'operation_details': 10},
    ),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}
