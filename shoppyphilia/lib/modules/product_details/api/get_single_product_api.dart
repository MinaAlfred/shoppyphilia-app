import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetSingleProductApi {
  Future<String> getSingleProduct(int productID) async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'products/$productID'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
