import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_open_api/shelf_open_api.dart';
import 'package:shelf_router/shelf_router.dart';

part '17_open_api_service.g.dart';

class OpenApiService {
  Router get router => _$OpenApiServiceRouter(this);

  @Route.get('/echo/<message>')
  @OpenApiRoute()
  Future<Response> echo(Request request) async {
    final message = request.params['message'];
    return Response.ok('$message\n');
  }

  @Route.get('/test/<message>')
  @OpenApiRoute()
  Future<Response> test(Request request) async {
    final message = request.params['message'];
    return Response.ok('$message\n');
  }

  @Route.get('/json')
  @OpenApiRoute()
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
