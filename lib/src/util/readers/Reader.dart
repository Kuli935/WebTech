part of tetris;

abstract class Reader{
  final String _dataUri;

  Reader(String dataUri):_dataUri = dataUri{}

  Map<String, Object> readModelConfiguration();

  Future loadGameConfiguration();

}