///***************************************************************************
/// AppException
///***************************************************************************
class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

///***************************************************************************
/// FetchDataException
///***************************************************************************
class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error during communication: ");
}

///***************************************************************************
/// BadRequestException
///***************************************************************************
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

///***************************************************************************
/// UnauthorizedException
///***************************************************************************
class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, "Unauthorized: ");
}

///***************************************************************************
/// InvalidInputException
///***************************************************************************
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
