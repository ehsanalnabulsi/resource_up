import 'package:dio/dio.dart';
import 'package:resource_up/core/constant/end_point.dart';
import 'package:resource_up/core/services/local/cache_helper.dart';

class DioHelper {
  static Dio dio = Dio(BaseOptions(
    baseUrl: baseurl,
    receiveDataWhenStatusError: true,
    // connectTimeout: const Duration(milliseconds: 5000),
    // receiveTimeout: const Duration(milliseconds: 5000),
  ));

  static Future<Response> getHttp({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'authorization': CacheHelper.getData(key: 'token'),
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postHttp({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': CacheHelper.getData(key: 'token'),
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> deleteHttp({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': CacheHelper.getData(key: 'token'),
    };
    return await dio.delete(url, data: data, queryParameters: query);
  }
}
