import 'dart:convert';
import 'dart:developer';
import 'dart:io';

Future<void> main(List<String> args) async {
  final server = await HttpServer.bind('0.0.0.0', 8080);
  server.listen((request) async {
    final uri = request.requestedUri;
    final segments = uri.pathSegments;
    try {
      if (segments[0] != 'hello') {
        request.response.statusCode = HttpStatus.badRequest;
      } else {
        int? id = segments.length > 1 ? int.tryParse(segments[1]) : null;
        String method = request.method;
        log('Request: $method[$id]');

        final response = {'body': 'data'};
        request.response.headers.add(
          HttpHeaders.contentTypeHeader,
          'application/json',
        );
        request.response.write(jsonEncode(response));
      }
    } catch (e, s) {
      log('$e, $s');
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.writeln(e);
    }
    await request.response.close();
  });
}
