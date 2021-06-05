import 'dart:io';

import 'package:pin/pin.dart';

import 'network_node.dart';
import 'simple_client.dart';

@Route('/blocks')
class BlockRoute extends RouteController {
  @override
  void get(HttpRequest request, Context ctxt, Map<String, String> params) {
    var node = ctxt.getService<NetworkNode>();
    request.response.write(node.blockChain);
  }
}

class TacServer {
  NetworkNode node = NetworkNode();
  App app = App();

  Future<void> start() async {
    node.addNextBlock('hello');
    node.addNextBlock('world');
    app.addService(node);
    app.addRoute(BlockRoute);
    await app.start();
  }

  Future<void> stop() async {
    await app.stop();
  }
}

Future<void> main() async {
  var ts = TacServer();
  await ts.start();
  var simpleClient = SimpleClient();
  await simpleClient.runQuery('', '/blocks');
  await ts.stop();
}
