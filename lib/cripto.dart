import 'dart:convert';
import 'package:http/http.dart' as http;
import 'coin_data.dart';

const keyAPI = 'E88D2E0C-EA72-46F0-986F-B7FF88DDAB90';
const urlAPI = 'https://rest.coinapi.io/v1/exchangerate/';

class CriptoPrice {
  CriptoPrice();

  Future<dynamic> getCriptoPrice(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      NetworkHelper networkHelper =
          NetworkHelper('$urlAPI$crypto/$currency?apikey=$keyAPI');
      var criptoData = await networkHelper.getData();
      double criptoPrice = criptoData['rate'];
      cryptoPrices[crypto] = criptoPrice.toStringAsFixed(0);
    }
    return cryptoPrices;
  }
}

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
