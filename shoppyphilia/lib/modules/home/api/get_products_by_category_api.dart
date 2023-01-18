import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetAllProductsByCategoryApi {
  Future<String> getAllProductsByCategory(String categoryName) async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'products/category/$categoryName'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
