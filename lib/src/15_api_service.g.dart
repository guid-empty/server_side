// GENERATED CODE - DO NOT MODIFY BY HAND

part of '15_api_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ApiServiceRouter(ApiService service) {
  final router = Router();
  router.add(
    'GET',
    r'/hello/<message>',
    service.hello,
  );
  router.add(
    'GET',
    r'/json',
    service.json,
  );
  return router;
}
