// GENERATED CODE - DO NOT MODIFY BY HAND

part of '17_open_api_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$OpenApiServiceRouter(OpenApiService service) {
  final router = Router();
  router.add(
    'GET',
    r'/echo/<message>',
    service.echo,
  );
  router.add(
    'GET',
    r'/test/<message>',
    service.test,
  );
  router.add(
    'GET',
    r'/json',
    service.json,
  );
  return router;
}
