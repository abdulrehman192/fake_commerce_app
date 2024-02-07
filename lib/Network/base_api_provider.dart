

import 'package:file_picker/file_picker.dart';

abstract class BaseApiProvider
{
  Future<dynamic> get({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, });
  Future<dynamic> post({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, required Map<String, PlatformFile> files, required bool attachBarrierToken});
  Future<dynamic> put({required String url, Map<String, dynamic>? queryParameters,  required Map<String, dynamic> body, required Map<String, PlatformFile> files, });
  Future<dynamic> patch({required String url, Map<String, dynamic>? queryParameters,  required Map<String, dynamic> body, required Map<String, PlatformFile> files, });
  Future<dynamic> delete({required String url, Map<String, dynamic>? queryParameters, required Map<String, dynamic> body, });
}