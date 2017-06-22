part of tetris;

/// Abstrahiert das Instanzieren und Konfigurieren von Klassen vom Typ T.
/// Instanzen koennen beim Erstellen mit Hilfe des zugehoerigen [Reader]
/// konfiguriert werden.
abstract class Builder<T> {

  /// Der [Reader] stellt eine Schnittstelle fuer die Konfiguration von zu
  /// erstellenden Instanzen bereit.
  final Reader _reader;

  /// Erstellt eine neue Builder Instanz, welche die Konfiguration fuer die zu
  /// erstellenden Instnazen von dem uebergebenen [reader] erhaelt.
  Builder(Reader reader) :_reader = reader {}

  /// Erstellt eine Instanz vom Typ T. Die im [Reader] vorliegende Konfiguration
  /// fuer diese Instanz wird ueber die [id] identifiziert.
  T build(String id);
}