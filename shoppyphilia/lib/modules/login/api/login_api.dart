import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class LoginApi {
  Future<String> login(map) async {
    http.Response response = await http.post(
        Uri.parse(ApiUrl.apiUrl + 'auth/login'),
        headers: {"Accept": "application/json"},
        body: map);
    return response.body;
  }
}
