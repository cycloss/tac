import 'simple_client.dart';
import 'tac_server.dart';

Future<void> main() async {
  var ts = TacServer();
  await ts.start();
  var simpleClient = SimpleClient();
  await simpleClient.runQuery('', '/blocks');
  await ts.stop();
  simpleClient.close();
}
