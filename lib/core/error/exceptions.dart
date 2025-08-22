//date
class ServerException implements Exception {}

class CacheException implements Exception {}

class TooManyRequestsException implements Exception {}

class NoUserException implements Exception {}

class TimeoutException implements Exception {}

//route
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}