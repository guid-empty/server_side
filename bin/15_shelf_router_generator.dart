import 'dart:io';

import 'package:server_side/src/15_api_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

Future<void> main() async {
  final pipeline =
      Pipeline()
        .addMiddleware(logRequests())
        .addHandler(ApiService().router);

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
}
