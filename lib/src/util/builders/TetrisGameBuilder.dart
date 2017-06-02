part of tetris;

class TetrisGameBuilder extends Builder<TetrisGame>{

  TetrisGameBuilder(Reader reader):super(reader){}

  TetrisGame build(String id){
    Map<String, Object> modelConfiguration = _reader.readModelConfiguration();
    if(modelConfiguration['id'] != id){
      //TODO: raise error and shos it in gui
      window.console.log('Could not find a TetrisGame configuration with the '
          'id: "${id}" in the file: "${_reader.dataUri}".');
      return null;
    }
    TetrisGame model = new TetrisGame(modelConfiguration['fieldWidth'],
                                      modelConfiguration['fieldHeight'],
                                      _reader);
    //alle Level der Konfigurationsdatei erstellen und zum Spiel hinzufuegen
    //TODO: add power ups for model and tetrominoes
    //maybe add a PowerUp builder
    _reader.readAllLevelIds().forEach((levelId){
      LevelBuilder levelBuilder = new LevelBuilder(_reader, model);
      model.addLevel(levelBuilder.build(levelId));
    });

    return model;
  }
}