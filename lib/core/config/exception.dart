class CacheException extends Error {
  final String message;

  CacheException(this.message);
}

class ServerException extends Error {
  final String message;

  ServerException(this.message);
}

enum AppStatus { initial, loading, failed, success }
