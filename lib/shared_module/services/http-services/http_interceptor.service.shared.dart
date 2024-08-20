import 'dart:convert';
import 'dart:io';
import 'package:dietsteps/shared_module/services/http-services/http.service.shared.dart';
import 'package:http/src/base_request.dart';
import 'package:http/src/base_response.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dietsteps/env.dart' as env;

class AppHttpInterceptor implements InterceptorContract {

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var Bearer = await sharedPreferences.getString("access_token");

      request.headers["Accept"] = "*/*";
      request.headers["Content-Type"] = "application/json";

      if (Bearer != null && Bearer != "") {
        request.headers["Authorization"] = "Bearer $Bearer";
      }
      print("interceptRequest");
      print(request.headers);
    } catch (e) {
      print(e);
    }
    return request;

  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    // TODO: implement interceptResponse
    try {
      print("interceptResponse");
      print(response.statusCode);
      if (response is Response) {

        var httpResponseBody = json.decode(response.body.toString());

        if (httpResponseBody['payload'] != null) {

          if (httpResponseBody['payload'] is String &&
              httpResponseBody["payload"].toString().contains('UNAUTHORIZED')) {
            var sharedHttpService = new SharedHttpService();
            await sharedHttpService.getAccessToken();
          } else {
            if(httpResponseBody['payload'] is! String){
              if(httpResponseBody['payload'].length>0){
                if (httpResponseBody['payload'][0]['access_token'] != null) {
                  var sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString("access_token",
                      httpResponseBody['payload'][0]['access_token'].toString());
                }
              }
            }


          }
        }
      }
    } catch (e,stc) {
      print(e);
      print(stc);
    }
    return response;

  }

   @override
  Future<bool> shouldInterceptRequest() {
     return Future.value(true);

  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.value(true);

  }
}
