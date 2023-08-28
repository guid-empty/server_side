import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) =>
    serve((_) => Response.ok('Hello, World!\n'), InternetAddress.anyIPv4, 8080);
