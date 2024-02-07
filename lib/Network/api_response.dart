
import 'network.dart';

class ApiResponse<T>
{
  ResponseStatus? status;
  T? data;
  String? message;
  ApiResponse({this.status, this.data, this.message});

  //implement the api response status
  ApiResponse.initial(this.message) : status = ResponseStatus.initial;
  ApiResponse.loading(this.message) : status = ResponseStatus.loading;
  ApiResponse.completed(this.data, this.message) : status = ResponseStatus.completed;
  ApiResponse.error(this.message) : status = ResponseStatus.error;

  @override
  String toString()
  {
    return "Status: $status \n message : $message \n data: $data";
  }

}