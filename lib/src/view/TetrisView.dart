part of tetris;

/**
 * Ein Tetrisobjekt interagiert mit dem DOM tree
 */
//TODO: why are all attributes public? could they be private instead?
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
   * Elemente mit der ID '#overlay' im DOM tree.
   * Verwendet um das Display abzudunkeln
   */
  final overlay = querySelector("#overlay");


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
   * Elemente mit der ID '#nextstone' im DOM tree.
   * Wird verwendet um das Feld von Nächsten-Tetromino-Feld zu visualisieren als eine HTML Tabelle.
   */
  final nextStone = querySelector('#nextstone');

  /**
   * Elemente mit der ID '#holdstone' im DOM tree.
   * Wird verwendet um das Feld von Gehalteten-Tetromino-Feld zu visualisieren als eine HTML Tabelle.
   */
  final holdStone = querySelector('#holdstone');

  /**
   * Ziel des Levels.
   */
  HtmlElement get goal => querySelector('#goal');

  /**
   * Beschreibund des Levelziels.
   */
  HtmlElement get goalDescription => querySelector('#goalDescription');

  /**
   * Forschritt des Levels.
   */
  HtmlElement get goalProgress => querySelector('#goalProgress');

  /**
   * Ziel des Levels als Zahl.
   */
  HtmlElement get bonusPoints => querySelector('#bonusPoints');

  /**
   * Anzeige des aktuellen Levels
   */
  HtmlElement get levelParagraph => querySelector('#level');


  /**
   * Start Button für das Spiel.
   */
  HtmlElement get startButton => querySelector('#start');

  /**
   * Menü Button für das Spiel.
   */
  HtmlElement get menuButton => querySelector('#menu');

  /**
   * Direkter Fall Button für das Spiel.
   */
  HtmlElement get hardDropButton => querySelector('#hard_drop');

  /**
   * Links Rotation Button für das Spiel.
   */
  HtmlElement get leftRotationButton => querySelector('#left_rotation');

  /**
   * Rechts Rotation Button für das Spiel.
   */
  HtmlElement get rightRotationButton => querySelector('#right_rotation');

  /**
   * Stein halten Button für das Spiel.
   */
  HtmlElement get holdButton => querySelector('#hold');

  /**
   * Nach links Button für das Spiel.
   */
  HtmlElement get leftButton => querySelector('#left');

  /**
   * Nach unten Button für das Spiel.
   */
  HtmlElement get downButton => querySelector('#down');

  /**
   * Nach rechts Button für das Spiel.
   */
  HtmlElement get rightButton => querySelector('#right');


  /**
   * Fortsetzen Button.
   */
  HtmlElement get continueButton => querySelector('#continue');

  /**
   * Neues Spiel Button.
   */
  HtmlElement get newGameButton => querySelector('#newGame');

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
   * Enthält alle TD-Elemente des Feldes für den Gehalteten-Tetromino-Feld.
   */
  List<List<HtmlElement>> holdStoneFields;

  /**
   * Aktualisiert die View nach dem Modelstatus.
   *
   * - [startButton] am Anfang zeigen
   * - Spielfeld anzeigen nachdem Modelstatus
   */
  void update(TetrisGame model) {
    // Startfenster ausblenden
    container_start.style.display = "none";
    // Spielfeld einblenden
    container_game.style.display = "block";
    // Steuerungsbild einblenden
    control_image.style.display = "block";
    // Abdunkeln ausblenden
    overlay.style.display = "none";
    // Game Nachrichten ausblenden
    container_message.style.display = "none";


    // Prüfen ob Pause aufgerufen wurde
    if (model.paused) {
      // Pause einblenden
      overlay.style.display = "block";
      continueButton.style.display = "block";
      newGameButton.style.display = "block";
      container_message.style.display = "block";
      message.innerHtml = "<h1>Menü</h1>"
          "<p>Das Spiel wurde pausiert!</p>";
    }

    // landscape unterbinden
    if (window.innerWidth > window.innerHeight && window.innerHeight < 481) {
      model.pause();
      newGameButton.style.display = "none";
      continueButton.style.display = "none";
      message.innerHtml = "<p>Das Spiel wurde pausiert!</p>"
          "<p>Zum Fortsetzen des Spiels, drehe das Smartphone in den Portrait-Modus!</p>";
    }

    // Prüfen ob das Spiel gestoppt wurde (Game Over)
    if (model.stopped) {
      // Game Over einblenden
      overlay.style.display = "block";
      continueButton.style.display = "none";
      container_message.style.display = "block";
      message.innerHtml = "<h1>Game Over</h1>"
          "<p>Dein Punktestand beträgt: <h2>" + model.score.toString() +
          "</h2></p>"
              "<p>Vielen Dank für's Spielen!</p>";
    }

    // Punkteanzahl
    this.scoreParagraph.text = model.score.toString();

    // Spielfeld aktualisieren
    final field = model.fieldRepresentation;
    updateFields(field, 1);

    // Nächster-Tetromino-Feld aktualisieren
    final nextStoneField = model.nextStoneField;
    updateFields(nextStoneField, 2);

    // Gehalteten-Tetromino-Feld aktualisieren
    final holdStoneField = model.holdStoneField;
    updateFields(holdStoneField, 3);

    // Ziel als Zahl erreicht
    this.goalDescription.text = model.currentLevel.goals[0].description;
    this.goalProgress.text =
        model.currentLevel.goals[0].getProgress().toString();
    this.goal.text = model.currentLevel.goals[0].goalValue.toString();
    this.bonusPoints.text = model.currentLevel.bonusPoints.toString();

    this.levelParagraph.text = model.levelCount.toString();
  }

  /**
   * Aktualisiert die Tabllen nach dem Model. Je nachdem wo sich Tetrominoes befinden.
   * @param List<List<Symbol>> field = Modelzustand wo sich die Tetrominoes befinden
   * @param int generateFieldModus = Welches Feld geändert werden soll
   * 1 = Spielfeld, 2 = Nächster-Tetromino-Feld, 3 = Gehalteten-Tetromino-Feld
   */
  void updateFields(List<List<Symbol>> field, int generateFieldModus) {
    List<List<HtmlElement>> fields;
    if (generateFieldModus == 1) {
      fields = this.fields;
    }
    if (generateFieldModus == 2) {
      fields = this.nextStoneFields;
    }
    if (generateFieldModus == 3) {
      fields = this.holdStoneFields;
    }

    // Das Spielfeld aktualisieren
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
  }


  /**
   * Generiert ein Spielfeld entsprechend dem Model Zustand.
   * @param final field = Modelzustand wo sich die Tetrominoes befinden
   * @param int generateFieldModus = Welches Feld geändert werden soll
   * 1 = Spielfeld, 2 = Nächster-Tetromino-Feld, 3 = Gehalteten-Tetromino-Feld
   * @param var nameID = ID Name um die TD's die Farben zuzuweisen
   */
  void generateField(final field, int generateFieldModus, var nameID) {
    List<List<HtmlElement>> fields;
    String table = "";
    for (int row = 0; row < field.length; row++) {
      final positionPow = nameID + "_row_${row}";
      table += "<tr id='$positionPow'>";
      for (int col = 0; col < field[row].length; col++) {
        final assignment = field[row][col];
        final position = nameID + "_${row}_${col}";
        //For the play field is build of complex cells. The additional fields
        //for the preview and the hold box are simple symbols. The redering of
        // the cells is different, which is the reason for the following
        // statements.
        if (assignment is Cell) {
          Cell cell = assignment as Cell;
          String color = cell.color.toString();
          table += "<td id='$position' class='$color'></td>";
        } else {
          table += "<td id='$position' class='$assignment'></td>";
        }
      }
      table += "</tr>";
    }
    final selectedDOMTree = querySelector('#' + nameID);
    //selectedDOMTree.innerHtml = table;
    selectedDOMTree.setInnerHtml(table);

    // Speichert alle generieten TD Elemente in dem Feld
    // vermeidet so zeitintensive querySelector Anrufe in der Update Methode
    fields = new List<List<HtmlElement>>(field.length);
    for (int row = 0; row < field.length; row++) {
      fields[row] = [];
      for (int col = 0; col < field[row].length; col++) {
        fields[row].add(
            selectedDOMTree.querySelector("#" + nameID + "_${row}_${col}"));
      }
    }

    // Ermitteln um welche Feldgeneriung es sich handelt und Variable setzen
    if (generateFieldModus == 1) {
      this.fields = fields;
    }
    if (generateFieldModus == 2) {
      this.nextStoneFields = fields;
    }
    if (generateFieldModus == 3) {
      this.holdStoneFields = fields;
    }
  }

}
