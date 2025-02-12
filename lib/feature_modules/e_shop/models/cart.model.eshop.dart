
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';

class Cart {

  final String orderReference;
  final String orderDate;
  final String state;
  final double total;
  final String invoiceReference;
  final List<OrderLine> orderLine;

  Cart({
    required this.orderReference,
    required this.orderDate,
    required this.state,
    required this.total,
    required this.invoiceReference,
    required this.orderLine,
  });


}

Cart mapCart(dynamic payload){

  List<OrderLine> orderLine = [];

  if(payload["order_line"] != null && payload["order_line"] is! String ){
    payload["order_line"].forEach((element) {
      if(element != null){
        orderLine.add(mapOrderLine(element));
      }
    });
  }

  return Cart(
      orderReference :payload["order_reference"]??"",
      orderDate :payload["order_date"]??"",
      state :payload["state"]??"",
      total :payload["total"]??0.0,
      invoiceReference :payload["invoice_reference"]??"",
      orderLine:orderLine
  );
}




class OrderLine {

  final int mealId;
  final String imageUrl;
  final String mealName;
  final String mealNameArabic;
  final int quantity;
  final double price;


  OrderLine({
    required this.mealId,
    required this.imageUrl,
    required this.mealName,
    required this.mealNameArabic,
    required this.quantity,
    required this.price
  });

  Map<String, dynamic> toJson() => {
    "meal_id": mealId,
    "quantity": quantity,

  };

}

OrderLine mapOrderLine(dynamic payload){


  return OrderLine(
    mealId :payload["meal_id"]??-1,
    imageUrl :payload["image"]!= null?payload["image"].toString():ASSETS_SAMPLEFOOD,
    mealName :payload["meal_name"]!= null && payload["meal_name"]!= false?payload["meal_name"] :"",
    mealNameArabic :payload["meal_arabic_name"]!= null && payload["meal_arabic_name"]!= false?payload["meal_arabic_name"] :"",
    quantity :payload["quantity"] !=null?double.parse(payload["quantity"].toString()).round():0,
      price :payload["price"] !=null?double.parse(payload["price"].toString()) :0.0
  );
}
