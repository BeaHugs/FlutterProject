import 'package:FlutterProject/project/service/api/base_models.dart';
import 'package:FlutterProject/project/service/config/storage_manager.dart';
import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'config/http_config.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url,
      {String method = "get",
      Map<String, dynamic> params,
      Interceptor inter}) async {
    // 1.创建单独配置
    final options = Options(method: method);

    // 全局拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(onRequest: (options) {
      return options;
    }, onResponse: (response) {
      //BaseResponse<T> baseResponse = BaseResponse<T>.fromJson(response.data);
      return response;
    }, onError: (err) {
      //print("错误拦截");
      return err;
    });

    var cookieManager = CookieManager(
        PersistCookieJar(dir: StorageManager.temporaryDirectory.path));

    List<Interceptor> inters = [dInter, cookieManager];

    // 请求单独拦截器
    if (inter != null) {
      inters.add(inter);
    }

    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);

    // 2.发送网络请求
    try {
      Response response =
          await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }

  static Future<BaseResponse<T>> requests<T>(String url,
      {String method = "get",
      Map<String, dynamic> params,
      Interceptor inter}) async {
    // 1.创建单独配置
    final options = Options(method: method);

    // 全局拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(onRequest: (options) {
      return options;
    }, onResponse: (response) {
      return response;
    }, onError: (err) {
      //print("错误拦截");
      return err;
    });

    var cookieManager = CookieManager(
        PersistCookieJar(dir: StorageManager.temporaryDirectory.path));

    List<Interceptor> inters = [dInter, cookieManager];

    // 请求单独拦截器
    if (inter != null) {
      inters.add(inter);
    }

    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);

    // 2.发送网络请求
    try {
      Response response =
          await dio.request(url, queryParameters: params, options: options);
      BaseResponse baseResponse = BaseResponse<T>.fromJson(response.data);
      return baseResponse;
    } catch (e) {
      return BaseResponse(errorCode: BaseResponse.parse_error, errorMsg: "数据出错!!!",data: null);
    }
  }
}
