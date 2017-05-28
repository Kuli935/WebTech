part of tetris;

class PowerUpUser{
  List<PowerUp> _powerUps;

  PowerUpUser():_powerUps = new List();

  void addPowerUp(PowerUp newPowerUp){
    _powerUps.add(newPowerUp);
  }
  void consumeAllPowerUps(Map<String, Object> kwargs){
    _powerUps.forEach((powerUp){
      powerUp.consume(kwargs);
    });
  }
}