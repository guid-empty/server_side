import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  final router = Router()
    ..get('/', _rootHandler)
    ..get('/json', _jsonHandler)
    ..get('/echo/<message>', _echoHandler);

  final pipeline = Pipeline().addMiddleware(logRequests()).addHandler(router);

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
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

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}
