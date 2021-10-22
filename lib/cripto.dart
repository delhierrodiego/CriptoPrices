import 'dart:convert';
import 'package:http/http.dart' as http;

const keyAPI = 'E88D2E0C-EA72-46F0-986F-B7FF88DDAB90';
const urlAPI = 'https://rest.coinapi.io/v1/exchangerate/';

class CriptoPrice {
  CriptoPrice();

  Future<dynamic> getCriptoPrice(String cripto, String currency) async {
    NetworkHelper networkHelper =
        NetworkHelper('$urlAPI$cripto/$currency?apikey=$keyAPI');
    var criptoData = await networkHelper.getData();
    double criptoPrice = criptoData['rate'];
    return criptoPrice;
  }
}

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
