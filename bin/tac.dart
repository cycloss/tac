import 'network_node.dart';

void main(List<String> arguments) {
  var node = NetworkNode();
  node.addNextBlock('hello');
  node.addNextBlock('world');
  node.printChain();
}
