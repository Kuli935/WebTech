part of tetris;

class LevelBuilder extends Builder<Level>{

  final TetrisGame _model;

  LevelBuilder(Reader reader, TetrisGame model): _model = model, super(reader){}

  Level build(String id){
    Map<String, Object> levelConfig = _reader.readLevelConfiguration(id);
    if(levelConfig == null){
      //TODO: raise error
      window.console.log('Could not find a Level configuration with the '
          'id: "${id}" in the file: "${_reader.dataUri}".');
      return null;
    }
    Level level = new Level(_model, levelConfig['availibleTetrominoes'],
        levelConfig['scoreMultiplier'],
        levelConfig['tetrominoSpeedInMs'],
        levelConfig['goals'],
        levelConfig['priority']);
    return level;
  }
}