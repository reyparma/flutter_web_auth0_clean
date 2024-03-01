class ServerException implements Exception {
  final String message;
  ServerException(this.message) {
    print("ServerException: $message");
  }
}

