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
    //TODO: set levels
    TetrisGame model = new TetrisGame(modelConfiguration['fieldWidth'],
                                      modelConfiguration['fieldHeight'],
                                      _reader);
    return model;
  }
}