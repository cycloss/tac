import 'dart:convert';
import 'dart:io';

class SimpleClient {
  var client = HttpClient();

  Future<void> runGet(String route) async {
    var request = await client.get('localhost', 8080, route);
    var response = await request.close();
    print('Netowrk node response:');
    await printResponseBody(response);
  }

  Future<void> runPost(String route) async {
    var reqUri = Uri.http('localhost:8080', route, {'data': 'hello world'});
    var request = await client.postUrl(reqUri);

    var response = await request.close();
    print('Netowrk node response:');
    await printResponseBody(response);
  }

  Future<void> printResponseBody(HttpClientResponse resp) async =>
      print(await resp.transform(utf8.decoder).join());

  void close() => client.close();
}
