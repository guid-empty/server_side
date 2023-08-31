import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> _) =>
    serve((_) => Response.ok('Hello, World!\n'), InternetAddress.anyIPv4, 8080);
