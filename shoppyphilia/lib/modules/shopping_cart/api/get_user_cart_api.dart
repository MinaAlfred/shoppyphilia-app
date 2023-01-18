import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetUserCartApi {
  Future<String>  getUserCart(userId) async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'carts/user/$userId'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
