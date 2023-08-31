import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  final router = Router()
    ..get('/json', _jsonHandler)
    ..get('/echo/<message>', _echoHandler);

  final pipeline = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(createAuthenticationCheckMiddleware())
      .addHandler(router);

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
}

Middleware createAuthenticationCheckMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      //  выполним проверку, если что-то не в порядке, то вернем 403
      if (request.requestedUri.pathSegments.contains('json')) {
        final oauthToken = request.headers[HttpHeaders.authorizationHeader];
        if (oauthToken == null || oauthToken.isEmpty) {
          return Response.forbidden('Not authroized request');
        }
      }

      //  все хорошо, позволим нашему pipeline отработать дальше
      final response = await innerHandler(request);
      return response.change(
        headers: {
          'X-My-service-Request': 1.toString(),
        },
      );
    };
  };
}

Future<Response> _echoHandler(Request request) async {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _jsonHandler(Request request) async {
  return Response.ok(
    jsonEncode(
      {'operation_details': 10},
    ),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}
