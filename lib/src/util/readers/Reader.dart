part of tetris;

abstract class Reader{
  final String _dataUri;

  Reader(String dataUri):_dataUri = dataUri{}

  Future loadGameConfiguration();

  Map<String, Map> readModelConfiguration();

  List<String> readAllTetrominoIds();

  Map<String, Object> readTetrominoeConfiguration(String id);

  List<String> readAllLevelIds();

  Map<String, Object> readLevelConfiguration(String id);

  get dataUri => _dataUri;
}