import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class UpdateProductCartApi {
  Future<String>  updateProductCart(cartId,map) async {
    http.Response response = await http.put(
      Uri.parse(ApiUrl.apiUrl + 'carts/$cartId'),
      headers: {"Accept" : "application/json"},
      body: map
    );
    return response.body;
  }
}
