import 'dart:convert';

import 'package:crypto_hash/crypto_hash.dart';

import 'utils.dart';

class Block {
  final int index;
  // hashing with previous hash means that no block can be modified without changing every consecutive block
  final int timestamp;
  final String data;
  final String? prevHash;
  late final String hash;

  static final Block genesis = Block._genesis();

  Block(this.index, this.prevHash, this.timestamp, this.data) {
    hash = getHash();
  }

  Block._genesis()
      : index = 0,
        prevHash = null,
        timestamp = msSinceEpoc(),
        data = 'tac',
        hash = ShaOne.hashString('tac');

  /// Hashes together the block data in their field order
  String getHash() {
    if (this == genesis) {
      return genesis.hash;
    }
    var indexBytes = bytesFromInt64(index);
    var tsBytes = bytesFromInt64(timestamp);
    var dataBytes = utf8.encode(data);
    var prevHashBytes = utf8.encode(prevHash!);
    var bytes =
        List<int>.from(indexBytes + tsBytes + dataBytes + prevHashBytes);
    return ShaOne.hashBytes(bytes);
  }

  @override
  String toString() {
    var displayData = data.length < 20 ? data : data.substring(0, 20);
    var formatted =
        'Block: $index\n  Hash: $hash\n  Previous hash: $prevHash\n  Timestamp: $timestamp\n  Data: $displayData\n' +
            '-' * 60;
    return formatted;
  }

  @override
  bool operator ==(other) {
    if (other is Block) {
      return other.index == index &&
          other.hash == hash &&
          other.prevHash == prevHash &&
          other.timestamp == timestamp &&
          other.data == data;
    } else {
      return false;
    }
  }
}
