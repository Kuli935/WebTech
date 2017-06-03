part of tetris;

class TetrominoBuilder extends Builder<Tetromino>{

  TetrisGame _model;

  TetrominoBuilder(Reader reader, TetrisGame model):_model = model, super(reader){}

  Tetromino build(String id){
    Map<String, Object> tetrominoConfig = _reader.readTetrominoeConfiguration(id);
    if(tetrominoConfig == null){
      //TODO: raise error
      window.console.log('Could not find a Tetromino configuration with the '
          'id: "${id}" in the file: "${_reader.dataUri}".');
      return null;
    }
    Tetromino tetromino = new Tetromino(_model,
        tetrominoConfig['stones'],
        tetrominoConfig['transitions'],
        tetrominoConfig['preview'],
        tetrominoConfig['color']);

    List<String> powerUpIds = tetrominoConfig['powerUps'];
    powerUpIds.forEach((powerUpId){
      PowerUp powerUp = new PowerUpBuilder(_reader, _model, tetromino).build(powerUpId);
      tetromino.addPowerUp(powerUp);
    });
    return tetromino;
  }

}