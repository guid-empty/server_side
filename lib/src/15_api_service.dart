import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part '15_api_service.g.dart';

class ApiService {
  Router get router => _$ApiServiceRouter(this);

  @Route.get('/hello/<message>')
  Future<Response> hello(Request request) async {
    final message = request.params['message'];
    return Response.ok('$message\n');
  }

  @Route.get('/json')
  Future<Response> json(Request request) async {
    return Response.ok(
      jsonEncode(
        {'operation_details': 10},
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}
