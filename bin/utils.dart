int msSinceEpoc() => DateTime.now().millisecondsSinceEpoch;

List<int> bytesFromInt64(int int64) {
  var bytes = <int>[];
  var byteMask = 0xff;
  for (var i = 64 - 8; i >= 0; i -= 8) {
    var byte = (int64 >> i) & byteMask;
    bytes.add(byte);
  }
  return bytes;
}
