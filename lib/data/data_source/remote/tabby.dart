import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class TabbyData {
  Crud crud;
  TabbyData(this.crud);

  preScoringTabby(
      {required String id,
      required String amount,
      required String desc,
      required String userPhone,
      required String userEmail,
      required String userName,
      required String city,
      required String taxAmount,
      required String updateAt}) async {
    String merchantCode = '';
    var response = await crud.postDataTabby(ApiLinks.tabbyCheckout, {
      "payment": {
        "amount": amount,
        "currency": "SAR",
        "description": desc,
        "buyer": {
          "phone": userPhone,
          "email": userEmail,
          "name": userName,
          "dob": "2000-08-24"
        },
        "shipping_address": {
          "city": city,
          "address": "saudi arabia",
          "zip": "22230"
        },
        "order": {
          "tax_amount": taxAmount,
          "shipping_amount": "0.00",
          "discount_amount": "0.00",
          "updated_at": updateAt, //"2019-08-24T14:15:22Z"
          "reference_id": id,
          "items": [
            {
              "title": "string",
              "description": "string",
              "quantity": 1,
              "unit_price": "0.00",
              "discount_amount": "0.00",
              "reference_id": "string",
              "image_url": "http://example.com",
              "product_url": "http://example.com",
              "gender": "Male",
              "category": "string",
              "color": "string",
              "product_material": "string",
              "size_type": "string",
              "size": "string",
              "brand": "string"
            }
          ]
        },
        "buyer_history": {
          "registered_since": "2019-08-24T14:15:22Z",
          "loyalty_level": 0,
          "wishlist_count": 0,
          "is_social_networks_connected": true,
          "is_phone_number_verified": true,
          "is_email_verified": true
        },
        "order_history": [],
        "meta": {"order_id": null, "customer": null},
        "attachment": {
          "body":
              "{\"flight_reservation_details\": {\"pnr\": \"TR9088999\",\"itinerary\": [...],\"insurance\": [...],\"passengers\": [...],\"affiliate_name\": \"some affiliate\"}}",
          "content_type": "application/vnd.tabby.v1+json"
        }
      },
      "lang": "ar",
      "merchant_code": merchantCode
    });

    return response.fold((l) => l, (r) => r);
  }
}
