// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../configurations/app_links.dart';
import '../configurations/token_interceptor.dart';
import '../models/token_model.dart';
import '../services/token_service.dart';

const String ACCEPT = "accept";
const String APPLICATION_JSON = "application/json";
const String AUTHORIZATION = "authorization";
const String CONTENT_TYPE = "content-type";

const Duration timeOut = Duration(seconds: 120);

class DioFactory {
  Dio getDio({TokenModel? token}) {
    Dio dio = Dio()..interceptors.add(TokenInterceptor());

    TokenService tokenService = Get.find<TokenService>();

    TokenModel? tokenModel = tokenService.tokenModel;

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      if (token != null || tokenModel?.aToken != null)
        AUTHORIZATION: "Bearer ${token?.aToken ?? tokenModel?.aToken}",
    };

    dio.options = BaseOptions(
      baseUrl: AppLinks.baseUrlProd,
      headers: headers,
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
    );

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
