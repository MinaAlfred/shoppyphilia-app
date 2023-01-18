import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetAllProductsByLimitApi {
  Future<String> getAllProductsByLimit(String limit) async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'products?limit=$limit'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
