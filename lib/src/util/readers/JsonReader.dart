part of tetris;

class JsonReader extends Reader{

  Map<String, Object> _gameConfiguration;

  JsonReader(String dataUri):super(dataUri){}

  Future loadGameConfiguration() async{
    await HttpRequest.getString(_dataUri).then((flatConfig){
      _gameConfiguration = JSON.decode(flatConfig);
    }).catchError((){
      /*
      TODO: implement error handling:
          -maybe load a default config (or abort)
          -show the user an error in a nice message
      */
    });
  }

  Map<String, Map> readModelConfiguration(){
    return _gameConfiguration['gameConfiguration'];
  }

  List<String> readAllTetrominoIds(){
    List<String> tetrominoIds = new List();
    List<Map<String, Object>> tetrominoConfigurations = _gameConfiguration['tetrominoes'];
    tetrominoConfigurations.forEach((tetrominoConfiguration){
      tetrominoIds.add(tetrominoConfiguration['id']);
    });
    return tetrominoIds;
  }

  Map<String, Object> readTetrominoeConfiguration(String id){
    List<Map<String, Object>> tetrominoConfigurations = _gameConfiguration['tetrominoes'];
    for(int i=0; i < tetrominoConfigurations.length; i++){
      if(tetrominoConfigurations[i]['id'] == id){
        return tetrominoConfigurations[i];
      }
    }
    return null;
  }
}