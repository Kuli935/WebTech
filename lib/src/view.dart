part of tetris;

/**
 * Ein Tetrisobjekt interagiert mit dem DOM tree
 */
class TetrisView {

  /**
   * Elemente mit der Klasse '.container_start' im DOM tree.
   * Soll nur gezeigt werden wenn das Spiel nicht läuft
   */
  final container_start = querySelector(".container_start");

  /**
   * Elemente mit der Klasse '.container_message' im DOM tree.
   * Wird verwendet um das Feld für Nachrichten sichtbar zu machen.
   */
  final container_message = querySelector('.container_message');

  /**
   * Elemente mit der ID '#message' im DOM tree.
   * Verwendet für Spiel Meldungen
   */
  final message = querySelector("#message");

  /**
   * Elemente mit der Klasse '.container_game' im DOM tree.
   * Wird verwendet um das Spiel anzuzeigen
   */
  final container_game = querySelector('.container_game');

  /**
   * Elemente mit der ID '#field' im DOM tree.
   * Wird verwendet um das Feld von Tetris zu visualisieren als eine HTML Tabelle.
   */
  final game = querySelector('#field');

  /**
   * Start Button für das Spiel.
   */
  HtmlElement get startButton => querySelector('#startButton');


  /**
   * Enthält alle TD-Elemente des Feldes.
   */
  List<List<HtmlElement>> fields;



  /**
   * Aktualisiert die view nach dem Modelstatus.
   *
   * - [startButton] am Anfang zeigen
   * - Spielfeld anzeigen nachdem Modelstatus
   */
  void update(TetrisGame model, { List<Map> scores: const [] }) {

    querySelector("#copy").innerHtml = "<strong>Funny, I was created by Dart</strong>";

    container_start.style.display = "none";
    container_game.style.display = "block";

    // Updates the field
    final field = model.field;
    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        final td = fields[row][col];
        if (td != null) {
          td.classes.clear();
          td.classes.add('empty');
        }
      }
    }
  }


  /**
   * Generiert ein Feld entsprechend dem Model Zustand.
   * Eine HTML Tabelle (n x m)
   */
  void generateField(TetrisGame model) {
    final field = model.field;
    String table = "";
    for (int row = 0; row < field.length; row++) {
      table += "<tr>";
      for (int col = 0; col < field[row].length; col++) {
        final assignment = field[row][col];
        final pos = "field_${row}_${col}";
        table += "<td id='$pos' class='$assignment'></td>";
      }
      table += "</tr>";
    }
    game.innerHtml = table;

    // Saves all generated TD elements in field to
    // avoid time intensive querySelector calls in update().
    // Thanks to Johannes Gosch, SoSe 2015.
    fields = new List<List<HtmlElement>>(field.length);
    for (int row = 0; row < field.length; row++) {
      fields[row] = [];
      for (int col = 0; col < field[row].length; col++) {
        fields[row].add(game.querySelector("#field_${row}_${col}"));
      }
    }
  }

}