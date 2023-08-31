import 'dart:convert';
import 'dart:developer';
import 'dart:io';

///
/// just Hello part in path
///
Future<void> main() async {
  final server = await HttpServer.bind('0.0.0.0', 8080);
  await for (final request in server) {
    final uri = request.requestedUri;
    final segments = uri.pathSegments;
    try {
      if (segments[0] != 'hello') {
        request.response.statusCode = HttpStatus.badRequest;
      } else {
        final response = {'body': 'data'};
        request.response.write(jsonEncode(response));
      }
    } catch (e, s) {
      log('$e, $s');
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.writeln(e);
    }
    await request.response.close();
  }
}
