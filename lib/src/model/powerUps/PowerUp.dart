part of tetris;

///
/// Ein PoweUp kann Aspekte des Spiels manipulieren, wenn es aktiviert wird.
/// Der Versuch ein PowerUp zu aktivieren kann an fast allen Stellen des Spiels
/// passieren. Ob das PowerUp zu diesem Zeitpunkt wirklich genutzt werden kann,
/// muss in _isConsumable geprueft werden.
///
abstract class PowerUp {
  TetrisGame _model;

  ///
  /// Diese id wird genutzt, um in serialisierten Objekt dieses PowerUp zu
  /// referenzieren. (zB. kann in der JSON Datei eines Tetrominos diese id
  /// angegeben werden, damit dieser Tetromino dieses PowerUp besitzt)
  ///
  final String _id;

  ///
  /// Ein PoerUp muss wenigstens das Model kennen, welches es manipulieren soll.
  ///
  PowerUp(TetrisGame model, String id) :_id = id {
    _model = model;
  }

  ///
  /// Aktiviert das PowerUp. Jedes PowerUp muss eine individuelle Implementation
  /// vornehmen.
  ///
  void consume(Map<String, Object> kwargs);

  ///
  /// Implementier die Bedingung, welche zur Aktivierung des PowerUps notwending
  /// ist. [kwargs] enthaelt Daten, die benoetigt werden, um zu ueberpruefen ob
  /// die Bedingung erfuellt wurde.
  ///
  bool _isConsumable(Map<String, Object> kwargs);

  get id => _id;
}