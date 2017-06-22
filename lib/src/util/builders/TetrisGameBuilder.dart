part of tetris;

class TetrisGameBuilder extends Builder<TetrisGame> {

  TetrisGameBuilder(Reader reader) :super(reader) {}

  TetrisGame build(String id) {
    Map<String, Object> modelConfiguration = _reader.readModelConfiguration();
    if (modelConfiguration['id'] != id) {
      window.alert('Could not find a TetrisGame configuration with the '
          'id: "${id}" in the file: "${_reader.dataUri}". Please make sure '
          'your game configuration file is correct. You can find the manual '
          'and a sample configuration file at: '
          'https://github.com/Kuli935/WebTech');
      return null;
    }
    TetrisGame model = new TetrisGame(modelConfiguration['fieldWidth'],
        modelConfiguration['fieldHeight'],
        _reader);
    //alle Level der Konfigurationsdatei erstellen und zum Spiel hinzufuegen
    _reader.readAllLevelIds().forEach((levelId) {
      LevelBuilder levelBuilder = new LevelBuilder(_reader, model);
      model.addLevel(levelBuilder.build(levelId));
    });

    return model;
  }
}