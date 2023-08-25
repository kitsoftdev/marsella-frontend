import 'constants.dart';

///Excepciones utilizadas por el sistema.

///Para excepciones relacionadas con el localStorage (Cache)
class CacheException implements Exception {}

///Para excepciones relacionadas con la conectividad (network)
class ConnectionException implements Exception {}

///Para excepciones relacionadas con la base de datos.
class DatabaseException implements Exception {}

///Para excepciones relacionadas con el backend.
class ServerException implements Exception {
  final int statusCode;
  ServerException({required this.statusCode});

  String get getMessage { 
    switch (statusCode) {
    case 400:
      return ExceptionMessage.statusCode400;
    case 401:
      return ExceptionMessage.statusCode401;
    case 402:
      return ExceptionMessage.statusCode402;
    case 403:
      return ExceptionMessage.statusCode403;
    case 404:
      return ExceptionMessage.statusCode404;
    case 405:
      return ExceptionMessage.statusCode405;
    case 406:
      return ExceptionMessage.statusCode406;
    case 407:
      return ExceptionMessage.statusCode407;
    case 408:
      return ExceptionMessage.statusCode408;
    case 409:
      return ExceptionMessage.statusCode409;
    case 410:
      return ExceptionMessage.statusCode410;
    case 411:
      return ExceptionMessage.statusCode411;
    case 412:
      return ExceptionMessage.statusCode412;
    case 413:
      return ExceptionMessage.statusCode413;
    case 414:
      return ExceptionMessage.statusCode414;
    case 415:
      return ExceptionMessage.statusCode415;
    case 416:
      return ExceptionMessage.statusCode416;
    case 417:
      return ExceptionMessage.statusCode417;
    case 418:
      return ExceptionMessage.statusCode418;
    case 421:
      return ExceptionMessage.statusCode421;
    case 422:
      return ExceptionMessage.statusCode422;
    case 423:
      return ExceptionMessage.statusCode423;
    case 424:
      return ExceptionMessage.statusCode424;
    case 426:
      return ExceptionMessage.statusCode426;
    case 428:
      return ExceptionMessage.statusCode428;
    case 429:
      return ExceptionMessage.statusCode429;
    case 431:
      return ExceptionMessage.statusCode431;
    case 451:
      return ExceptionMessage.statusCode451;
    case 500:
      return ExceptionMessage.statusCode500;
    case 501:
      return ExceptionMessage.statusCode501;
    case 502:
      return ExceptionMessage.statusCode502;
    case 503:
      return ExceptionMessage.statusCode503;
    case 504:
      return ExceptionMessage.statusCode504;
    case 505:
      return ExceptionMessage.statusCode505;
    case 506:
      return ExceptionMessage.statusCode506;
    case 507:
      return ExceptionMessage.statusCode507;
    case 508:
      return ExceptionMessage.statusCode508;
    case 510:
      return ExceptionMessage.statusCode510;
    default:
      return ExceptionMessage.statusCodeDefault;
    }
  }
}