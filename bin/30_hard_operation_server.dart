import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  final router = Router()
    ..get('/', _rootHandler)
    ..get('/json', _jsonHandler)
    ..get('/fibonacci', _fibonacciHandler)
    ..get('/echo/<message>', _echoHandler);

  final pipeline = Pipeline().addMiddleware(logRequests()).addHandler(router);

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
}

Future<Response> _echoHandler(Request request) async {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

int _fibonacci(int n) => n <= 2 ? 1 : _fibonacci(n - 2) + _fibonacci(n - 1);

Future<Response> _fibonacciHandler(Request request) async =>
    Response.ok(_fibonacci(32).toString());

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

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}
