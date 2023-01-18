import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetAllProductsApi {
  Future<String> getAllProducts() async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'products'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
