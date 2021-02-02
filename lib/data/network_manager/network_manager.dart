import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shrtcode/data/model/default_reponse.dart';
import 'package:shrtcode/resources/app_config.dart';


/// Hands and processes (online) API requests using the default [ResponseWrapper].
/// On a successful call, the [ResponseWrapper] is return and during a failed API call,
/// [ResponseWrapper] is thrown as well with the error field containing the error message
/// or reason expected to be presented to the UI

class APIResourceManager{
  static BaseOptions options = new BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  Dio client = new Dio(options);

  Future<ResponseWrapper> networkRequestManager(APIRequestType apiRequestType,String requestUrl, {dynamic body, queryParameters,
    BehaviorSubject<int> progressStream, File backFile}) async{

    ResponseWrapper apiResponse;
    var baseUrl =  BaseUrl.BASE_URL;
    String url = '$baseUrl$requestUrl';
     print("Bearer: n/a, Url: $url, Body: $body, Query: $queryParameters");

      try{
        switch(apiRequestType){
          case APIRequestType.GET:
            var response = await client
                .get(url,queryParameters: queryParameters);
            print("get: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
          case APIRequestType.POST:
            var response = await client
                .post(url,data: body,queryParameters: queryParameters, onSendProgress:(int count, int total){
              if(progressStream!=null){
                double percentage  = (count/total) * 100 ;
                progressStream.sink.add(percentage.toInt());
              }
            });
            print("post: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
          case APIRequestType.MULTI_PART_POST:
            client.interceptors.add(InterceptorsWrapper(
                onRequest: (Options options) async {
                  options.headers["Content-Type"] = "multipart/form-data";
                  return options;
                }
            ));
            var response = await client
                .post(url,data: body,queryParameters: queryParameters);
            print("post: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
          case APIRequestType.PUT:
            var response = await client
                .put(url,data: body,queryParameters: queryParameters);
            print("put: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
          case APIRequestType.PATCH:
            var response = await client
                .patch(url,data: body,queryParameters: queryParameters);
            print("put: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
          case APIRequestType.DELETE:
            var response = await client
                .delete(url,data: body,queryParameters: queryParameters);
            print("delete: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
          default:
            var response = await client
                .post(url,data: body,queryParameters: queryParameters);
            print("post: ${response.data.toString()}");
            apiResponse = ResponseWrapper.fromJson(response.data);
            break;
        }
        return apiResponse;
      }on TimeoutException {
        throw ("Connection failed, please check your network connection and try again");
      } on DioError catch(e){

        print("Internal Error response: $e ${e.message} ${e.response} ${e.request.path} ");

        if (DioErrorType.RECEIVE_TIMEOUT == e.type || DioErrorType.CONNECT_TIMEOUT == e.type) {
          print("Network Timeout Error response: $e");
          throw ("Network timed out, please check your network connection and try again");

        } else if (DioErrorType.DEFAULT == e.type) {

          if (e.message.contains('SocketException')) {
            print("No Network Error response: $e");
            throw ("No internet connection, please check your network connection and try again");
          }else{
            print("No Network Error response: $e");
            throw ("An message occured processing this request, please try again later");
          }
        }

        if (e.response.statusCode == 400 || e.response.statusCode == 422) {
          apiResponse = ResponseWrapper.fromJson(json.decode(e.response.toString()));
          throw ("${apiResponse.error}");

        }else if (e.response.statusCode == 401) {
          //This should not occur for the purpose of this project
          throw ("Invalid authorization credentials, please check your details and try again!");

        } else if (e.response.statusCode == 404) {
          //This should not occur for the purpose of this project
          throw ("Reason not found! Kindly contact your administrator");

        } else if (e.response.statusCode == 500) {
          throw ("We are unable to process request at this time, please try again later");
        }else if (e.response.statusCode == 502) {
          // If that call was not successful, throw an message.
          // print("Server 500 response: ${apiResponse.message}");
          throw ("We are unable to process request at this time, (Reason: Bad GateWay)");
        }else {
          // If that call was not successful, throw an message.
          apiResponse = ResponseWrapper.fromJson(json.decode(e.response.toString()));
          print("Network Unknown response: ${apiResponse.toJson()}");
          throw ("Unable to process request, ${apiResponse.error}");
        }
        //throw ("An message occurred while processing your request, please try again");
      }
      catch(e){
         print("Internal Error response: $e");
        throw ("An message occurred while processing this request");
      }

  }

}


enum APIRequestType {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  MULTI_PART_POST,
}