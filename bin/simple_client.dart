import 'dart:convert';
import 'dart:io';

class SimpleClient {
  var client = HttpClient();

  Future<void> runQuery(String query, String route) async {
    var request = await client.get('localhost', 8080, route);
    var response = await request.close();
    print('Netowrk node response:');
    await printResponseBody(response);
  }

  Future<void> printResponseBody(HttpClientResponse resp) async =>
      print(await resp.transform(utf8.decoder).join());

  void close() => client.close();
}
