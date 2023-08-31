import 'dart:io';

import 'package:server_side/src/17_open_api_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

Future<void> main() async {
  final pipeline =
      Pipeline().addMiddleware(logRequests()).addHandler(OpenApiService().router
        ..mount('/public', createStaticHandler('public/'))
        ..mount(
          '/openapi/',
          SwaggerUI(
            'public/src/api.open_api.yaml',
            docExpansion: DocExpansion.list,
            syntaxHighlightTheme: SyntaxHighlightTheme.tomorrowNight,
            title: 'OpenApiService Demo Generation handler',
          ),
        ));

  await serve(pipeline, InternetAddress.anyIPv4, 8080);
}
