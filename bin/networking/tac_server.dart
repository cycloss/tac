import 'dart:io';

import 'package:pin/pin.dart';

import 'network_node.dart';

@Route('/blocks')
class BlockRoute extends RouteController {
  @override
  void get(HttpRequest request, Context ctxt, Map<String, String> params) {
    var node = ctxt.getService<NetworkNode>();
    request.response.write(node.blockChain);
  }

  @override
  void post(HttpRequest request, Context ctxt, Map<String, String> params) {
    // mines a block
    var data = request.uri.queryParameters['data'];
    if (data == null) {
      request.response
          .write('Please add a data query parameter to post request');
      return;
    }
    var node = ctxt.getService<NetworkNode>();
    node.addNextBlock(data);
    request.response.write('Successfully added a block with data $data');
  }
}

class TacServer {
  NetworkNode node = NetworkNode();
  App app = App();

  Future<void> start() async {
    app.addService(node);
    app.addRoute(BlockRoute);
    await app.start();
  }

  Future<void> stop() async {
    await app.stop();
  }
}
