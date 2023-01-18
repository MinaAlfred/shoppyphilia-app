import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetSingleProfileApi {
  Future<String> getSingleProfile() async {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'users/1'),
      headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
