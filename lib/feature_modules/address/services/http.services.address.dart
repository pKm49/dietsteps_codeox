  import 'package:dietsteps/feature_modules/address/constants/http_request_endpoints.constant.address.dart';
import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';

class AddressHttpService {

  Future<List<Address>> getUserAddressess(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(AddressHttpRequestEndpoint_Address,params);

      List<Address> tempAddressList = [];
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempAddressList.add(mapAddress(response.data[i]));
        }
      }

      return tempAddressList;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }

  }

  Future<bool> auditAddress(Address address, String mobile, bool isCreate) async {

    try{
      if(isCreate){

        AppHttpResponse response = await postRequest(AddressHttpRequestEndpoint_Address, address.toJsonForPost(mobile));
        if(response.statusCode != 200){
          showSnackbar(Get.context!, response.message, "error");
        }
        return response.statusCode == 200;
      }else{

        AppHttpResponse response = await patchRequest(AddressHttpRequestEndpoint_Address, address.toJsonForPatch(mobile));
        if(response.statusCode != 200){
          showSnackbar(Get.context!, response.message, "error");
        }
        return response.statusCode == 200;
      }


    }catch (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }

  }

  Future<bool> deleteUserAddressess(int addressId) async {

    try{
      Map<String, dynamic> params = {};
      params["address_id"]=addressId;
      AppHttpResponse response =
      await deleteRequest(AddressHttpRequestEndpoint_Address, params);
      return response.statusCode == 200;

    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }


  Future<List<GeneralItem>> getAreas( ) async {

    try{

      AppHttpResponse response =
      await getRequest(AddressHttpRequestEndpoint_GetAreas,null);

      List<GeneralItem> tempAreas = [];
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempAreas.add(mapGeneralItem(response.data[i]));
        }
      }

      return tempAreas;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }

  Future<List<GeneralItem>>  getBlocks(int areaId) async {


    try{
      Map<String, dynamic> params = {};
      params["area"]=areaId;
      AppHttpResponse response =
      await getRequest(AddressHttpRequestEndpoint_GetBlocks,params);

      List<GeneralItem> tempBlocks = [];
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempBlocks.add(mapGeneralItem(response.data[i]));
        }
      }

      return tempBlocks;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }


}
