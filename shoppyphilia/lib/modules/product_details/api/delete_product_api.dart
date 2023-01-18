import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class DeleteProductApi {
  Future<String> deleteProduct(int productID) async {
    http.Response response = await http.delete(
      Uri.parse(ApiUrl.apiUrl + 'products/$productID'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
