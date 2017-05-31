part of tetris;

abstract class Reader{
  final String _dataUri;

  Reader(String dataUri):_dataUri = dataUri{}

  Future loadGameConfiguration();

  Map<String, Map> readModelConfiguration();

  Map<String, Object> readTetrominoeConfiguration(String id);

  List<String> readAllTetrominoIds();

  get dataUri => _dataUri;
}