import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'network.dart';



class ApiProvider extends BaseApiProvider
{
  Dio _dio = Dio();
  ApiProvider(){
    print("base url:: ${ApiEndpoints.apiBaeUrl}");
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.apiBaeUrl));
  }

  static final ApiProvider apiClient = ApiProvider._internal();


  ApiProvider._internal() {
    print("base url:: ${ApiEndpoints.apiBaeUrl}");
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.apiBaeUrl));
  }


  @override
  Future<dynamic> get({required String url, Map<String, dynamic>? queryParameters,  required Map<String, dynamic> body, bool attachBarrierToken = false}) async
  {
    print(url);
    Map<String, dynamic> headers = {};
    if(attachBarrierToken){
      headers = {
        "Authorization": "Bearer accessToken",
      };
    }
    dynamic response;
    if(await checkInternetAccess()){
      try {
        final formData = FormData.fromMap(body);
        response = await _dio.get(
            url,
            data: formData,
            queryParameters: queryParameters,
            options: Options(
                headers: headers
            ),
            onReceiveProgress: (x, y) {
              debugPrint(
                  "Progress : ${((x / y) * 100).roundToDouble().toStringAsFixed(
                      2)} %");
            }
        );
      }
      on DioException catch(e)
      {
        _getDioErrorResponse(e);
        response = e.response;
      }
    }
    return response;
  }

  @override
  Future<dynamic> post({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, required Map<String, PlatformFile> files, bool attachBarrierToken = false}) async
  {

    Map<String, dynamic> headers = {
      "Content-Type" : "application/json"
    };
    if(attachBarrierToken){
      headers = {
        "Authorization": "Bearer accessToken",
      };
    }
    dynamic response;
    if(await checkInternetAccess())
      {
        try {
          // client.options.followRedirects = false;
          Map<String, dynamic> data = {};

          if(files.isNotEmpty)
          {
            for (var key in files.keys) {
              PlatformFile? value = files[key];
              if(value != null)
              {
                dynamic x;
                if(kIsWeb)
                {
                  x =  MultipartFile.fromBytes(value.bytes!.toList(), filename: value.name, );
                }
                else
                {
                  x =  await MultipartFile.fromFile(value.path.toString(), filename: value.name, );
                }
                data[key] = x;
              }
            }
            headers["Content-Type"] = "multipart/form-data";
          }

          body.forEach((key, value) {
            data[key] = value;
          });
          final formData = FormData.fromMap(data);
          response = await _dio.post(
            url,
            queryParameters: queryParameters,
            data: data,
            onSendProgress: (x,y)
            {
              debugPrint("Sent : ${((x/y)*100).roundToDouble().toStringAsFixed(2)} %");
            },
            options: Options(
                headers: headers
            ),
          );

        }
        on DioException catch(e)
        {
          _getDioErrorResponse(e);
          response = e.response;
        }
      }

    return response;
  }

  @override
  Future<dynamic> put({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, required Map<String, PlatformFile> files, bool attachBarrierToken = false}) async
  {

    Map<String, dynamic> headers = {};
    if(attachBarrierToken){
      headers = {
        "Authorization": "Bearer accessToken",
      };
    }
    dynamic response;
    if(await checkInternetAccess()){
      try {
        Map<String, dynamic> data = {};

        if(files.isNotEmpty)
        {
          for (var key in files.keys) {
            PlatformFile? value = files[key];
            if(value != null)
            {
              dynamic x;
              if(kIsWeb)
              {
                x =  MultipartFile.fromBytes(value.bytes!.toList(), filename: value.name, );
              }
              else
              {
                x =  await MultipartFile.fromFile(value.path.toString(), filename: value.name, );
              }
              data[key] = x;
            }
          }
          headers["Content-Type"] = "multipart/form-data";
        }
        body.forEach((key, value) {
          data[key] = value;
        });

        final formData = FormData.fromMap(data);
        response = await _dio.put(
            url,
            queryParameters: queryParameters,
            data: formData,
            options: Options(
                headers: headers
            ),
            onSendProgress: (x,y)
            {
              debugPrint("Progress : ${((x/y)*100).roundToDouble().toStringAsFixed(2)} %");
            }
        );
      }
      on DioException catch(e)
      {
        response = e.response;
        _getDioErrorResponse(e);
      }
    }
    return response;
  }

  @override
  Future<dynamic> patch({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, required Map<String, PlatformFile> files, bool attachBarrierToken = false}) async
  {
    Map<String, dynamic> headers = {};
    if(attachBarrierToken){
      headers = {
        "Authorization": "Bearer accessToken",
      };
    }
    dynamic response;
    if(await checkInternetAccess()){
      try {
        Map<String, dynamic> data = {};

        if(files.isNotEmpty)
        {
          for (var key in files.keys) {
            PlatformFile? value = files[key];
            if(value != null)
            {
              dynamic x;
              if(kIsWeb)
              {
                x =  MultipartFile.fromBytes(value.bytes!.toList(), filename: value.name, );
              }
              else
              {
                x =  await MultipartFile.fromFile(value.path.toString(), filename: value.name, );
              }
              data[key] = x;
            }
          }
          headers["Content-Type"] = "multipart/form-data";
        }

        body.forEach((key, value) {
          data[key] = value;
        });
        final formData = FormData.fromMap(data);
        response = await _dio.patch(
            url,
            queryParameters: queryParameters,
            data: formData,
            options: Options(
                headers: headers
            ),
            onSendProgress: (x,y)
            {
              debugPrint("Progress : ${((x/y)*100).roundToDouble().toStringAsFixed(2)} %");
            }
        );
      }
      on DioException catch(e)
      {
        response = e.response;
        _getDioErrorResponse(e);
      }
    }
    return response;
  }

  @override
  Future<dynamic> delete({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, bool attachBarrierToken = false }) async
  {
    Map<String, dynamic> headers = {};
    if(attachBarrierToken){
      headers = {
        "Authorization": "Bearer accessToken",
      };
    }
    dynamic response;
    if(await checkInternetAccess()){
      try {
        final formData = FormData.fromMap(body);
        response = await _dio.delete(
          url,
          data: formData,
          queryParameters: queryParameters,
          options: Options(
              headers: headers
          ),
        );
      }
      on DioException catch(e)
      {
        response = e.response;
        _getDioErrorResponse(e);
      }
    }

    return response;
  }

  Future<bool> checkInternetAccess() async {
    try {
      final response = await _dio.get('https://www.google.com');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }


  _getDioErrorResponse(DioException e) {
    var response = e.response;
    var statusCode = response?.statusCode;

    if (response?.data != null) {
      try {
        if (statusCode != null && statusCode == 401 || statusCode == 403 || statusCode! >= 500) {
          if (statusCode! == 401) {
            print("User is unauthorised.");
          }
          if (statusCode >= 500) {
            print("Internal server error");
          }
        }
        else{
          print("${e.message}");
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print(e.message);
    }

  }

  Future<void> sendNotification({required String deviceToken, required Map body}) async{
    try{
      if(deviceToken.isNotEmpty)
        {
          var doc = {
            "to" : deviceToken,
            "priority" : "high",
            "notification" : body,
            "data": {}
          };

          var headers = {
            "Content-Type" : "application/json; charset=UTF-8",
            "Authorization" : "key=AAAAkE_QHH4:APA91bHdI-zTEfOlLxsK24zJGh8jWzx2jz2MB2QcaWTqXYRRxrd8PjpM0YfBSOcSbiOT8Rafagym9KIdSCXviTVzALXVFj0OVqHdqX3NAApYfVv5qOPt3azWqQMsf0NrBwEpuFHf0ABd",
          };
          var url = "https://fcm.googleapis.com/fcm/send";
          await _dio.post(
              url,
              data: doc,
          options: Options(
            headers: headers
          )
          );
        }
    }
    on DioException catch(e)
    {
      if (kDebugMode) {
        print(e.response);
        print(e.requestOptions.data);
        print(e.type);
      }
    }
  }

}