import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class AddProductApi {
  Future<String> addProduct(map) async {
    http.Response response = await http.post(
       Uri.parse(ApiUrl.apiUrl + 'products'),
        headers: {"Accept" : "application/json"},
        body: map
    );
    return response.body;
  }
}
