part of tetris;

class JsonReader extends Reader{

  Map<String, Object> _gameConfiguration;

  JsonReader(String dataUri):super(dataUri){}

  Map<String, Object> readModelConfiguration(){
    return _gameConfiguration['gameConfiguration'];
  }

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
}