import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as prefix;
import 'package:shoplocalto/utils/logger.dart';

String dioErrorHandle(DioError error) {
  UtilLogger.log("ERROR", error);
  print(
      '......................dioerror...........................UtilError$error');
  switch (error.type) {
    case DioErrorType.response:
      return error.response?.data['message'].toString() ?? 'Unknown error';

    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return "request_time_out";

    default:
      return "connect_to_server_fail";
  }
}

class HTTPManager {
  prefix.FlutterSecureStorage flutterSecureStorage =
      prefix.FlutterSecureStorage();
  BaseOptions baseOptions = BaseOptions(
    baseUrl: "http://www.listar.passionui.com/index.php/wp-json",
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {},
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  ///Post method
  Future<dynamic> post({
    String url,
    Map<String, dynamic> data,
    Options options,
  }) async {
    UtilLogger.log("POST URL", url);
    UtilLogger.log("DATA", data);
    Dio dio = new Dio(baseOptions);
    getToken();
    //  await Future.delayed(Duration(seconds: 1));
    print(
        '888888888888888888rrrrrr888888888888888888888888888 headers token${baseOptions.headers}');
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      response.statusCode;


      print("request option ${response.requestOptions.uri.toString()}");
      // print("request option data ${response.requestOptions.data}");
      return response.data;
    } on DioError catch (error) {
      return {"message": dioErrorHandle(error)};
    }
  }

  Future<dynamic> noTokenPost({
    String url,
    Map<String, dynamic> data,
    Options options,
  }) async {
    UtilLogger.log("POST URL", url);
    UtilLogger.log("DATA", data);
    Dio dio = new Dio(baseOptions);
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      print("request option ${response.requestOptions.uri.toString()}");

      return response.data;
    } on DioError catch (error) {
      return {"message": dioErrorHandle(error)};
    }
  }

  ///Get method
  Future<dynamic> get({
    String url,
    Map<String, dynamic> params,
    Options options,
  }) async {
    UtilLogger.log("GET URL", url);
    UtilLogger.log("PARAMS", params);
    Dio dio = new Dio(baseOptions);
    getToken();

    print(
        '9999999999999999999999999999999999999999999999${baseOptions.headers}');
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      print("request option1 ${response.requestOptions.uri.toString()}");
      return response.data;
    } on DioError catch (error) {
      return {"message": dioErrorHandle(error)};
    }
  }

  Future<dynamic> getToken() async {
    Map<String, dynamic> headerParams = {};
    bool isLoggedIn = await flutterSecureStorage.containsKey(key: 'token');
    if (isLoggedIn) {
      String token = await flutterSecureStorage.read(key: 'token');
      headerParams = {'Authorization': 'Bearer $token'};
    }
    final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;
    baseOptions.headers = nullableHeaderParams;
    return baseOptions.headers;
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
