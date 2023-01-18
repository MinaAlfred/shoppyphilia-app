import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetAllProductsBySortApi {
  Future<String> getAllProductsBySort(String sortType) async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'products?sort=$sortType'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
