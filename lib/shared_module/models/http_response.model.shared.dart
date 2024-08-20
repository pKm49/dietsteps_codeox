class AppHttpResponse{

  final num statusCode;
  final String message;
  final dynamic data;


  AppHttpResponse({
    required this.statusCode,
    required this.message,
    required this.data});

}