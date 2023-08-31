import 'dart:convert';
import 'dart:developer';
import 'dart:io';

///
/// any request
///
Future<void> main() async {
  final server = await HttpServer.bind('0.0.0.0', 8080);
  server.listen((request) async {
    print(request.requestedUri);
    request.response.close();
  });
}
