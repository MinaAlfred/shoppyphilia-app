import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class UpdateProductApi {
  Future<String> updateProduct(map,productID) async {
    http.Response response = await http.put(
       Uri.parse(ApiUrl.apiUrl + 'products/7'),
        headers: {"Accept" : "application/json"},
        body: map
    );
    return response.body;
  }
}
