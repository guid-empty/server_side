import 'dart:io';

import 'package:server_side/src/15_api_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

Future<void> main() async {
  final pipeline = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(createStaticHandler('public'));

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
}
