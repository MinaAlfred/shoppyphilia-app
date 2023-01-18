import 'package:http/http.dart' as http;
import 'package:shoppyphilia/Data_access_layer/base_url.dart';

class GetAllCategoriesApi {
  Future<String> allCategories() async {
    http.Response response = await http.get(
        Uri.parse(ApiUrl.apiUrl + 'products/categories'),
        headers: {"Accept" : "application/json"},
    );
    return response.body;
  }
}
