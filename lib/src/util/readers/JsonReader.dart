part of tetris;

class JsonReader extends Reader {

  Map<String, Object> _gameConfiguration;

  JsonReader(String dataUri) :super(dataUri) {}

  Future loadGameConfiguration() async {
    await HttpRequest.getString(_dataUri).then((flatConfig) {
      _gameConfiguration = JSON.decode(flatConfig);
    }).catchError(() {
      window.alert('Could not load the configuration file. Please make sure '
          'you have placed it in the same directory as the tetrisclient.dart '
          'file. For more information visit:'
          'https://github.com/Kuli935/WebTech');
    });
  }

  Map<String, Map> readModelConfiguration() {
    return _gameConfiguration['gameConfiguration'];
  }

  List<String> readAllTetrominoIds() {
    List<String> tetrominoIds = new List();
    List<Map<String,
        Object>> tetrominoConfigurations = _gameConfiguration['tetrominoes'];
    tetrominoConfigurations.forEach((tetrominoConfiguration) {
      tetrominoIds.add(tetrominoConfiguration['id']);
    });
    return tetrominoIds;
  }

  Map<String, Object> readTetrominoeConfiguration(String id) {
    List<Map<String,
        Object>> tetrominoConfigurations = _gameConfiguration['tetrominoes'];
    for (int i = 0; i < tetrominoConfigurations.length; i++) {
      if (tetrominoConfigurations[i]['id'] == id) {
        return tetrominoConfigurations[i];
      }
    }
    return null;
  }

  List<String> readAllLevelIds() {
    List<String> levelIds = new List();
    List<
        Map<String, Object>> levelConfigurations = _gameConfiguration['levels'];
    levelConfigurations.forEach((levelConig) {
      levelIds.add(levelConig['id']);
    });
    return levelIds;
  }

  Map<String, Object> readLevelConfiguration(String id) {
    List<
        Map<String, Object>> levelConfigurations = _gameConfiguration['levels'];
    for (int i = 0; i < levelConfigurations.length; i++) {
      if (levelConfigurations[i]['id'] == id) {
        return levelConfigurations[i];
      }
    }
    return null;
  }
}