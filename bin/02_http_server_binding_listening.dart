import 'dart:convert';
import 'dart:developer';
import 'dart:io';

///
/// hello/<int> parsing scheme
///
Future<void> main() async {
  final server = await HttpServer.bind('0.0.0.0', 8080);
  server.listen((request) async {
    final uri = request.requestedUri;
    final segments = uri.pathSegments;
    try {
      if (segments[0] != 'hello') {
        request.response.statusCode = HttpStatus.badRequest;
      } else {
        final id = segments.length > 1 ? int.tryParse(segments[1]) : null;

        final response = {
          'body': 'data',
          'your id is': id,
        };
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
