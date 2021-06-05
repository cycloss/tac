import 'simple_client.dart';
import 'tac_server.dart';

Future<void> main() async {
  var ts = TacServer();
  await ts.start();
  var simpleClient = SimpleClient();
  // mines a block
  await simpleClient.runPost('/blocks');
  // gets all blocks
  await simpleClient.runGet('/blocks');

  await ts.stop();
  simpleClient.close();
}
