import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  final router = Router()..get('/fibonacci', _fibonacciHandler);

  final pipeline = Pipeline().addMiddleware(logRequests()).addHandler(router);

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
}

int _fibonacci(int n) => n <= 2 ? 1 : _fibonacci(n - 2) + _fibonacci(n - 1);

Future<Response> _fibonacciHandler(Request request) async =>
    Response.ok(_fibonacci(32).toString());