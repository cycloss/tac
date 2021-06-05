import 'dart:io';

import 'block.dart';

/// Connected to other nodes and responsible for correctness of ledger data
class NetworkNode {
  List<Block> blockChain = [];

  NetworkNode() {
    blockChain.add(Block.genesis);
  }

  void addNextBlock(String data) {
    var prevHash = currentBlock.hash;
    var ts = DateTime.now().millisecondsSinceEpoch;
    var newBlock = Block(nextIndex, prevHash, ts, data);
    if (isValidBlock(newBlock, currentBlock)) {
      blockChain.add(newBlock);
    } else {
      stderr.writeln('Invalid block received');
    }
  }

  // used to check blocks from other nodes to see if we accept them
  bool isValidBlock(Block block, Block previousBlock) {
    var validIndex = block.index == previousBlock.index + 1;
    var validPrevHash = block.prevHash == previousBlock.hash;
    var validHash = block.hash == block.getHash();
    return validIndex && validPrevHash && validHash;
  }

  /// Resolves conflicting chains my choosing the longer chain. Only accept a chain from the outside when it is longer than our chain
  void replaceChain(List<Block> newChain) {
    if (isValidChain(newChain) && newChain.length > blockChain.length) {
      print('Valid longer blockchain received. Replacing blockchain');
      blockChain = newChain;
      broadcastLatest();
    } else {
      print('Invalid blockchain received');
    }
  }

  bool isValidChain(List<Block> chainToValidate) {
    var validGenesis = Block.genesis == chainToValidate[0];
    if (!validGenesis) {
      return false;
    }
    for (var i = 1; i < chainToValidate.length; i++) {
      if (!isValidBlock(chainToValidate[i], chainToValidate[i - 1])) {
        return false;
      }
    }
    return true;
  }

  int get nextIndex => blockChain.length;

  Block get currentBlock => blockChain[nextIndex - 1];

  // when a node generates a new block it broadcasts it to the network

  void broadcastLatest() {}

  void printChain() {
    for (var block in blockChain) {
      print(block);
    }
  }
}
