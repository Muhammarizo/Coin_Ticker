import 'package:http/http.dart';
import 'dart:convert';

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '905AAEA3-2972-42BC-84BA-FC6CE92827F0';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GPB',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String selectedvalue) async {
    // funksiyani tipi future bolyapti sababi bunga bogliq bowqa funksiya bor. u buni kutib turiw kere. uwancun bu future

    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedvalue?apikey=$apiKey';

// String requestURL =  '$coinAPIURL/BTC/$selectedvalue?apikey=$apiKey';
      Response response = await get(Uri.parse(requestURL)); // bu qator response json faylni uziga uzlawtiradi. agar body qisa alabatta ya'ni response.body

      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        double lastPrice = decodeData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
