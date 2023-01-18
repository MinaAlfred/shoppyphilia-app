import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class DeleteCartApi {
  Future<String>  deleteCart(cartId) async {
    http.Response response = await http.delete(
      Uri.parse(ApiUrl.apiUrl + 'carts/$cartId'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
