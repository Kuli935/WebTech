part of tetris;

class PowerUpUser {
  List<PowerUp> _powerUps;

  PowerUpUser() :_powerUps = new List();

  /**
   * Hinzufügen eines PowerUps
   * @param PowerUp newPowerUp = PowerUp Klasse
   */
  void addPowerUp(PowerUp newPowerUp) {
    _powerUps.add(newPowerUp);
  }

  /**
   * Verwenden des PowerUps
   * @param Map<String, Object> kwargs = enthaelt Daten, die benoetigt werden, um zu ueberpruefen ob
   * die Bedingung erfuellt wurde
   */
  void consumeAllPowerUps(Map<String, Object> kwargs) {
    _powerUps.forEach((powerUp) {
      powerUp.consume(kwargs);
    });
  }
}