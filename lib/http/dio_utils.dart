import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/generated/json/login_response_entity_helper.dart';
import 'package:jwt/http/base_entity.dart';

import 'dio_interceptor.dart';


class DioUtils {
  static var dio;
  static var httpUtil;

  static DioUtils get instance => _getInstance();
  static DioUtils _getInstance() {
    if (httpUtil == null) {
      httpUtil = DioUtils();
    }
    return httpUtil;
  }

  static const String API_PREFIX = 'https://novel.dkvirus.com/api/v1';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 10000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';


  /// @ url 请求链接
  ///@ parameters 请求参数
  ///@ metthod 请求方式
  ///@ onSuccess 成功回调
  ///@ onError 失败回调
  Future<Map> request<T>(String url,
      {parameters,
        method,
        Function(T t) onSuccess,
        Function(String error) onError}) async {
    parameters = parameters ?? {};
    method = method ?? 'GET';

    /// 请求处理
    parameters.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    Dio dio = createInstance();
    //请求结果
    var result;
    try {
      Response response = await dio.request(url,
          data: parameters, options: new Options(method: method));
      result = response.data;
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          var data = json.decode(response.data) ;
          onSuccess(data);
        }
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
      onError(e.toString());
    }

    return result;
  }
  /// 初始化DIO
  Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      var options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        //responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        contentType: Headers.jsonContentType
      );
      dio = new Dio(options);
      /// 增加拦截器并添加 token
      dio.interceptors.add(LogInterceptors(dio));
      /// 增加token拦截器
    }
    return dio;
  }
  ///Get请求
  void getHttp <T>({String url, parameters, Function(T t) onSuccess,  Function(String error) onError, }) async {
    try {
      Dio dio = createInstance();
      Response response = await dio.get(URLConfig.BASE_URL);
      response=  await dio.get((url==null || url.isEmpty)? URLConfig.BASE_URL : url,queryParameters: parameters);
      getResponse(url: url,method :GET ,parameters: parameters,onSuccess: onSuccess,onError: onError);
    } catch (e) {
      print(e);
    }
  }
  ///Post请求 && put delect...
  Future<T> postHttp<T>({String url, String method, parameters, Function(T t) onSuccess, Function(String error) onError}) async {
    ///定义请求参数
    parameters = parameters ?? {};
    return getResponse(url: url,parameters: parameters,onSuccess: onSuccess,onError: onError);
  }

  Future<T> getResponse<T>({  String url, String method, parameters, Function(T t) onSuccess,  Function(String error) onError}) async {
    try {
      Response response;
      Dio dio = createInstance();
      switch(method){
        case GET:
          response =  await dio.get((url == null || url.isEmpty ) ? URLConfig.BASE_URL : url, queryParameters: parameters);
          break;
        case PUT:
          response =  await dio.put(( url == null || url.isEmpty ) ? URLConfig.BASE_URL : url, queryParameters: parameters);
          break;
        case PATCH:
          response =  await dio.patch(( url == null || url.isEmpty ) ? URLConfig.BASE_URL : url, queryParameters: parameters);
          break;
        case DELETE:
          response =  await dio.delete(( url == null || url.isEmpty ) ? URLConfig.BASE_URL : url, queryParameters: parameters);
          break;
        default:
          response =  await dio.post((url == null || url.isEmpty ) ? URLConfig.BASE_URL : url, data: parameters);
          break;
      }
      BaseEntity<T> bean = BaseEntity.fromJson(response.data);
      return bean.returnData;
      /// 拦截http层异常码
      print(response.statusCode);
      if (response.statusCode == 200) {
        ///这里做BaseEntity泛型解析，封装 并拦截后台code异常码，可拦截自定义处理
        BaseEntity<T> bean = BaseEntity.fromJson(response.data);
        print(bean.returnCode);
        if(bean.returnCode == 1 && onSuccess != null){
          ///返回泛型Bean
          onSuccess(bean.returnData);
          //return bean.returnData;
        }else{
          onError(bean.returnMsg);
        }
      } else {
        throw Exception('statusCode:${response.statusCode}+${response.statusMessage}');
      }
    } catch (e) {
      print('请求出错：' + e.toString());
      onError(e.toString());
    }
  }

  /// 清空 dio 对象
  clear() {
    dio = null;
  }
}