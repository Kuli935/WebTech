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
   * Wird verwendet um das Feld von Tetromino zu visualisieren als eine HTML Tabelle.
   */
  final game = querySelector('#field');

  /**
   * Elemente mit der ID '#nextStone' im DOM tree.
   * Wird verwendet um das Feld von Nächsten-Tetromino-Feld zu visualisieren als eine HTML Tabelle.
   */
  final nextStone = querySelector('#nextstone');

  /**
   * Start Button für das Spiel.
   */
  HtmlElement get startButton => querySelector('#startButton');

  /**
   * Fortsetzen Button.
   */
  HtmlElement get continueButton => querySelector('#continueButton');

  /**
   * Neues Spiel Button.
   */
  HtmlElement get newGameButton => querySelector('#newGameButton');

  /**
   * Anzeige fuer die Punktezahl
   */
  HtmlElement get scoreParagraph => querySelector('#points');

  /**
   * Elemente mit der ID '.container_control' im DOM tree.
   * Wird verwendet um ein Steuerungsbild zu zeigen.
   */
  final control_image = querySelector('.container_control');

  /**
   * Enthält alle TD-Elemente des Feldes.
   */
  List<List<HtmlElement>> fields;

  /**
   * Enthält alle TD-Elemente des Feldes für den Nächsten-Tetromino-Feld.
   */
  List<List<HtmlElement>> nextStoneFields;

  /**
   * Aktualisiert die View nach dem Modelstatus.
   *
   * - [startButton] am Anfang zeigen
   * - Spielfeld anzeigen nachdem Modelstatus
   */
  void update(TetrisGame model, {List<Map> scores: const []}) {
    // Startfenster ausblenden
    container_start.style.display = "none";
    // Spielfeld einblenden
    container_game.style.display = "block";
    // Steuerungsbild einblenden
    control_image.style.display = "block";

    // Prüfen ob Pause aufgerufen wurde
    if(model.paused){
      // Pause einblenden
      container_message.style.display = "block";
      message.innerHtml = "<img src='img/tetris_menu_logo.png'>"
          "<h1>Menü</h1>"
          "<p>Das Spiel wurde pausiert!</p>";
    } else {
      // Pause ausblenden
      container_message.style.display = "none";
    }

    this.scoreParagraph.text = model.score.toString();

    // Das Spielfeld aktualisieren
    final field = model.fieldRepresentation;
    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        final td = fields[row][col];
        if (td != null) {
          td.classes.clear();
          if (field[row][col] == #cyan)
            td.classes.add('cyan');
          else if (field[row][col] == #blue)
            td.classes.add('blue');
          else if (field[row][col] == #yellow)
            td.classes.add('yellow');
          else if (field[row][col] == #orange)
            td.classes.add('orange');
          else if (field[row][col] == #red)
            td.classes.add('red');
          else if (field[row][col] == #green)
            td.classes.add('green');
          else if (field[row][col] == #purple)
            td.classes.add('purple');
          else if (field[row][col] == #empty) td.classes.add('empty');
        }
      }
    }

    // Nächster-Tetromino-Feld aktualisieren
    final nextStoneField = model.nextStoneField;
    for (int row = 0; row < nextStoneField.length; row++) {
      for (int col = 0; col < nextStoneField[row].length; col++) {
        final td = nextStoneFields[row][col];
        if (td != null) {
          td.classes.clear();
          if (nextStoneField[row][col] == #cyan)
            td.classes.add('cyan');
          else if (nextStoneField[row][col] == #blue)
            td.classes.add('blue');
          else if (nextStoneField[row][col] == #yellow)
            td.classes.add('yellow');
          else if (nextStoneField[row][col] == #orange)
            td.classes.add('orange');
          else if (nextStoneField[row][col] == #red)
            td.classes.add('red');
          else if (nextStoneField[row][col] == #green)
            td.classes.add('green');
          else if (nextStoneField[row][col] == #purple)
            td.classes.add('purple');
          else if (nextStoneField[row][col] == #empty) td.classes.add('empty');
        }
      }
    }
  }

  /**
   * Generiert ein Nächstes-Tetromino-Feld.
   * Eine HTML Tabelle (4 x 4)
   */
  void generateNextStoneField(TetrisGame model) {
    final nextStoneField = model.nextStoneField;
    String table = "";
    for (int row = 0; row < nextStoneField.length; row++) {
      table += "<tr>";
      for (int col = 0; col < nextStoneField[row].length; col++) {
        final assignment = nextStoneField[row][col];
        final pos = "nextstone_${row}_${col}";
        table += "<td id='$pos' class='$assignment'></td>";
      }
      table += "</tr>";
    }
    nextStone.innerHtml = table;

    // Speichert alle generieten TD Elemente in dem Feld
    // vermeidet so zeitintensive querySelector Anrufe in der Update Methode
    nextStoneFields = new List<List<HtmlElement>>(nextStoneField.length);
    for (int row = 0; row < nextStoneField.length; row++) {
      nextStoneFields[row] = [];
      for (int col = 0; col < nextStoneField[row].length; col++) {
        nextStoneFields[row]
            .add(nextStone.querySelector("#nextstone_${row}_${col}"));
      }
    }
  }

  /**
   * Generiert ein Spielfeld entsprechend dem Model Zustand.
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

    // Speichert alle generieten TD Elemente in dem Feld
    // vermeidet so zeitintensive querySelector Anrufe in der Update Methode
    fields = new List<List<HtmlElement>>(field.length);
    for (int row = 0; row < field.length; row++) {
      fields[row] = [];
      for (int col = 0; col < field[row].length; col++) {
        fields[row].add(game.querySelector("#field_${row}_${col}"));
      }
    }
  }
}
