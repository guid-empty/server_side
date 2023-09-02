import 'dart:convert';
import 'dart:developer';
import 'dart:io';

///
/// any request
///
Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  server.listen((request) async {
    print(request.requestedUri);
    request.response.close();
  });
}