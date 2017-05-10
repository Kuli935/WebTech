part of tetris;

/**
 *  Definiert ein Tetromino im Tetris Spiel.
 */
class Tetromino {

  /**
   * Verweist auf das Spiel.
   */
  final TetrisGame _game;

  /**
   * Liste der Stein Elemente von dem Tetromino
   */
  var _stone = [];

  /**
   * Liste der Stein Elemente von dem Tetromino für das Nächste-Tetris-Stein-Feld
   */
  var _nextstone = [];

  /**
   * Liste der Stein Elemente von dem Tetromino für das Gehalteten-Tetris-Stein-Feld
   */
  var _holdstone = [];

  /**
   * Farbe des Tetromino im Spielfeld
   */
  Symbol _stoneColor;

  /**
   * Farbe des Tetromino im Nächsten-Tetromino-Feld
   */
  Symbol _nextstoneColor;

  /**
   * Temporäre Farbe des Tetromino
   */
  Symbol _tempColor;

  /**
   * Vertikale, Reihe (row), Bewegung von dem Tetromino. Mögliche Richtung nur nach unten: +1.
   */
  int _dr;

  /**
   * Horizontale, Spalte (col), Bewegung von dem Tetromino. Mögliche Richtungen: links, bleiben, rechts:  -1, 0, 1.
   */
  int _dc;

  /**
   * Variable für den ersten Tetromino. Damit der nächste Tetromino um einen versetzt ist für die Vorschau
   */
  bool _firstStone = true;

  /**
   * Temporäre Nummer des Tetromino
   */
  int _tempStone;

  /**
   * Konstuktor um ein [Tetromino] Objekt für ein [TetrisGame] zu erzeugen.
   * @param _game = TetrisGame Objekt
   */
  Tetromino.on(this._game) {
    nextTetromino();
    down();
  }

  /**
   * Generiert einen zufälligen Tetromino.
   */
  void nextTetromino() {
    final r = new Random();
    this._game.incrementTetrominoCount();

    // Prüfe ob es der aller erste Tetromino ist
    if (_firstStone) {
      // generie den ersten zufalls Tetromino
      final random = r.nextInt(7);
      _stone = randomTetromino(random, 0, this._game._sizeWidth);
      // Farbe setzen
      _stoneColor = _tempColor;
      _firstStone = false;

      _stone.forEach((cell){
        this._game._field[cell['row']][cell['col']].isActive = true;
      });

      // Vorschau auf den nächsten Tetromino
      _tempStone = r.nextInt(7);
      _nextstone = randomTetromino(_tempStone, this._game.extraFieldHeight - 1, this._game.extraFieldWidth);
      // Farbe setzen
      _nextstoneColor = _tempColor;
    }

    // sonst alle anderen Tetromino
    // Den normalen Tetromino erzeugen
    _stone = randomTetromino(_tempStone, 0, this._game.sizeWidth);

    //Die Zellen, welche von dem aktuellen Tetromino belegt sind als aktiv
    //makieren
    _stone.forEach((cell){
      this._game._field[cell['row']][cell['col']].isActive = true;
    });
    // Farbe setzen
    _stoneColor = _nextstoneColor;
    // Vorschau auf den nächsten Tetromino
    _tempStone = r.nextInt(7);
    _nextstone = randomTetromino(_tempStone, this._game.extraFieldHeight - 1, this._game.extraFieldWidth);
    // Farbe setzen
    _nextstoneColor = _tempColor;
  }

  /**
   * Generiert einen zufälligen Tetromino.
   * @param int random = Zufallswert von 0-6, Zahl ermittelt den Tetromino
   * @param int height = Höhe
   * @param int width = Breite
   * @return Liste des Tetromino
   */
  List<Map<String, int>> randomTetromino(int random, int height, int width){
    List<Map<String, int>> temp;
    switch(random) {
      case 0:
        // Erzeugt ein I Tetromino in der Farbe hellblau
        _tempColor = #cyan;
        temp = [
          { 'row' : height ~/ 2,    'col' : width ~/ 2 - 2 },
          { 'row' : height ~/ 2,    'col' : width ~/ 2 - 1 }, // Drehpunkt von vertikal nach horizontal
          { 'row' : height ~/ 2,    'col' : width ~/ 2     }, // Drehpunkt von horizontal nach vertikal
          { 'row' : height ~/ 2,    'col' : width ~/ 2 + 1 }
        ];
        break;
      case 1:
        // Erzeugt ein J Tetromino in der Farbe blau
        _tempColor = #blue;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }
        ];
        break;
      case 2:
        // Erzeugt ein L Tetromino in der Farbe orange
        _tempColor = #orange;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  }
        ];
        break;
      case 3:
        // Erzeugt ein O Tetromino in der Farbe gelb
        _tempColor = #yellow;
        temp = [
          { 'row' : height ~/ 2,      'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2 + 1,  'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2,      'col' : width ~/ 2     },
          { 'row' : height ~/ 2 + 1,  'col' : width ~/ 2     }
        ];
        break;
      case 4:
        // Erzeugt ein S Tetromino in der Farbe grün
        _tempColor = #green;
          temp = [
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  }, // Drehpunkt
            { 'row' : height ~/ 2,       'col' : width ~/ 2      },
            { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 2  }
          ];
          break;
      case 5:
        // Erzeugt ein T Tetromino in der Farbe lila
        _tempColor = #purple;
        temp = [
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  }
        ];
        break;
      case 6:
        // Erzeugt ein Z Tetromino in der Farbe rot
        _tempColor = #red;
        temp = [
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }

        ];
        break;
    }
    return temp;
  }


    /**
     * Drehen des Tetromino
     * @param int angle = winkel
     *
     * Anmerkungen:
     * Rotationsformal um einen Punkt um einen Drehpunkt mit einem Winkel alpha rotieren zu lassen.
     * Wobei x0 und y0 die Koordinaten für den Drehpunkt sind und x und y für den zu rotierenden Stein
     * x' = x0 + (x - x0) * cos(alpha) - (y - y0) * sin(alpha)
     * y' = y0 + (x - x0) * sin(alpha) + (y - y0) * cos(alpha)
     * Der Computer erwartet als Eingabe für sin() und cos() keinen Winkel,
     * sondern ein Bogenmass, also den Umfang des Kreisabschnittes.
     * Um also aus dem Winkel das Bogenmass zu erhalten,
     * rechnen wir: Winkel / 180 * PI
     * Y-Achse | row | height
     * X-Achse | col | width
     **/
    void rotate(angle){
      // Wenn das Spiel gestoppt wurde ist keine Rotation möglich
      if (this._game.stopped || this._game.paused) return;

      // Liste der Tetromino für die Rotation
      var _rotate;

      // Prüfen ob der Tetromino, nicht das O Tetromino ist
      // 1. Sonderfall keine Rotation nötig!
      if(!(_stone.elementAt(0)['row'] == _stone.elementAt(2)['row'] && _stone.elementAt(1)['row'] == _stone.elementAt(3)['row'] &&  _stone.elementAt(0)['col'] == _stone.elementAt(1)['col'] && _stone.elementAt(2)['col'] == _stone.elementAt(3)['col'])){


        // 2. Sonderfall extra Rotation nötig!
        // Prüfen ob es das I Tetromino in horizontaler Form ist
        if(_stone.elementAt(0)['row'] == stone.elementAt(1)['row'] && stone.elementAt(0)['row'] == _stone.elementAt(2)['row'] && _stone.elementAt(0)['row'] == stone.elementAt(3)['row']) {
          // Rotation in die vertikale Form
          // Tetromino von oben nach unten erzeugen

          _rotate = [
            { 'row' : (_stone.elementAt(2)['row'] + (_stone.elementAt(0)['col'] - _stone.elementAt(2)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(0)['row'] - _stone.elementAt(2)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(2)['col'] + (_stone.elementAt(0)['col'] - _stone.elementAt(2)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(0)['row'] - _stone.elementAt(2)['row']) * sin(angle / 180 * PI)).round() },
            { 'row' : (_stone.elementAt(2)['row'] + (_stone.elementAt(1)['col'] - _stone.elementAt(2)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(1)['row'] - _stone.elementAt(2)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(2)['col'] + (_stone.elementAt(1)['col'] - _stone.elementAt(2)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(1)['row'] - _stone.elementAt(2)['row']) * sin(angle / 180 * PI)).round() },
            { 'row' : (_stone.elementAt(2)['row'] + (_stone.elementAt(2)['col'] - _stone.elementAt(2)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(2)['row'] - _stone.elementAt(2)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(2)['col'] + (_stone.elementAt(2)['col'] - _stone.elementAt(2)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(2)['row'] - _stone.elementAt(2)['row']) * sin(angle / 180 * PI)).round() },
            { 'row' : (_stone.elementAt(2)['row'] + (_stone.elementAt(3)['col'] - _stone.elementAt(2)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(3)['row'] - _stone.elementAt(2)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(2)['col'] + (_stone.elementAt(3)['col'] - _stone.elementAt(2)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(3)['row'] - _stone.elementAt(2)['row']) * sin(angle / 180 * PI)).round() }
          ];

          // Prüfen ob es das I Tetromino in vertikaler Form ist
        } else if(_stone.elementAt(0)['col'] == stone.elementAt(1)['col'] && stone.elementAt(0)['col'] == _stone.elementAt(2)['col'] && _stone.elementAt(0)['col'] == stone.elementAt(3)['col']){
          // Rotation in die horizontale Form
          // Tetromino von links nach rechts erzeugen

          _rotate = [
            { 'row' : (_stone.elementAt(1)['row'] + (_stone.elementAt(0)['col'] - _stone.elementAt(1)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(0)['row'] - _stone.elementAt(1)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(1)['col'] + (_stone.elementAt(0)['col'] - _stone.elementAt(1)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(0)['row'] - _stone.elementAt(1)['row']) * sin(angle / 180 * PI)).round() },
            { 'row' : (_stone.elementAt(1)['row'] + (_stone.elementAt(1)['col'] - _stone.elementAt(1)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(1)['row'] - _stone.elementAt(1)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(1)['col'] + (_stone.elementAt(1)['col'] - _stone.elementAt(1)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(1)['row'] - _stone.elementAt(1)['row']) * sin(angle / 180 * PI)).round() },
            { 'row' : (_stone.elementAt(1)['row'] + (_stone.elementAt(2)['col'] - _stone.elementAt(1)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(2)['row'] - _stone.elementAt(1)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(1)['col'] + (_stone.elementAt(2)['col'] - _stone.elementAt(1)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(2)['row'] - _stone.elementAt(1)['row']) * sin(angle / 180 * PI)).round() },
            { 'row' : (_stone.elementAt(1)['row'] + (_stone.elementAt(3)['col'] - _stone.elementAt(1)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(3)['row'] - _stone.elementAt(1)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(1)['col'] + (_stone.elementAt(3)['col'] - _stone.elementAt(1)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(3)['row'] - _stone.elementAt(1)['row']) * sin(angle / 180 * PI)).round() }
          ];


        } else {

        // Alle anderen Tetromino nach der Rotationsformel
         _rotate = [
              { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(0)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(0)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(0)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(0)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() },
              { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(1)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(1)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(1)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(1)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() },
              { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(2)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(2)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(2)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(2)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() },
              { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(3)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(3)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(3)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(3)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() }
             ];

        }

        // Methode aufrufen um Kollisionen zu prüfen,
        // wenn Ja neuer Tetromino fallen lassen
        // ansonsten Stein Setzen
        if(tetrominoCollision(_rotate)) return;
        checkCollisionsAndMoveTetromino(_rotate);

      }

    }

    /**
     * Bewegungen von dem Tetromino und seine Richtungen (down, left, right)
     */
    void move() {
      //naechste Position des aktuellen Tetrominoes berechnen
      var _move = [
        { 'row' : _stone.elementAt(0)['row'] + _dr,  'col' : _stone.elementAt(0)['col'] + _dc  },
        { 'row' : _stone.elementAt(1)['row'] + _dr,  'col' : _stone.elementAt(1)['col'] + _dc  },
        { 'row' : _stone.elementAt(2)['row'] + _dr,  'col' : _stone.elementAt(2)['col'] + _dc  },
        { 'row' : _stone.elementAt(3)['row'] + _dr,  'col' : _stone.elementAt(3)['col'] + _dc  }
      ];

      //pruefen, ob die berechnete Position valide ist
      checkCollisionsAndMoveTetromino(_move);
    }

  /**
   * Bewegt den aktuellen Tetromino auf gegebene Position und aendert dabei
   * den Zustand des Spielfeldes.
   */
  void moveToNewPosition(List move){
      this._stone.forEach((piece) {
        this._game._field[piece['row']][piece['col']].isActive = false;
        this._game._field[piece['row']][piece['col']].color = #empty;
      });
      _stone = move;
      this._stone.forEach((piece) {
        this._game._field[piece['row']][piece['col']].isActive = true;
      });
    }

    /**
     * Teilt dem Tetromino keine Bewegung mit, somit stoppt der Tetromino.
     */
    void stop()  { _dr =  0; _dc =  0; }

    /**
     * Teilt dem Tetromino die Bewegung nach unten mit.
     */
    void down()  { _dr =  1; _dc =  0; }

    /**
     * Teilt dem Tetromino die Bewegung nach links mit.
     */
    void left()  { _dr =  0; _dc = -1; }

    /**
     * Teilt dem Tetromino die Bewegung nach rechts mit.
     */
    void right() { _dr =  0; _dc =  1; }



  /**
   * Die Bewegungen des Tetromino auf Kollisionen prüfen.
   * Bei einer Kollision einen neuen Tetromino fallen lassen.
   * @param var move = neue Position vom Tetromino
   */
  void checkCollisionsAndMoveTetromino(var move) {
    //TODO: further refactoring to seperate functionality would be nice
    if(notOnSide(move)){
      if(notOnGround(move)){
        if(!tetrominoCollision(move)){
          this.moveToNewPosition(move);
        } else{
          // Prüfen auf Game Over
          if(_stone.elementAt(0)['row'] == 0 || _stone.elementAt(0)['row'] == 1 ||
              _stone.elementAt(1)['row'] == 0 || _stone.elementAt(1)['row'] == 1 ||
              _stone.elementAt(2)['row'] == 0 || _stone.elementAt(2)['row'] == 1 ||
              _stone.elementAt(3)['row'] == 0 || _stone.elementAt(3)['row'] == 1){
            _game.stop();
          }


          bool movesSideways = (this._dc != 0);
          if(movesSideways){
            //ungueltige seitwaerts Bewegung rueckgaening machen
            move.forEach((piece) {piece['col'] -= this._dc;});
            this.moveToNewPosition(move);
          } else{
            //Tetromino in der Position fest setzen
            this._stone.forEach((piece) {
              this._game._field[piece['row']][piece['col']].isActive = false;
            });
            //TODO: check if a row was completed
            //falls eine oder mehrere Reihen vervollstaendigt sind mussen diese
            //entfernt werden und alle Reihen darueber nachrutschen
            this._game.removeCompletedRows();
            nextTetromino();
          }
        }
      } else{
        //falls der Tetrmino aud den Boden faellt wird er gesetzt
        this._stone.forEach((piece) {
          this._game._field[piece['row']][piece['col']].isActive = false;
        });
        this._game.removeCompletedRows();
        nextTetromino();
      }
    }
    this._game.updateField();
  }



  /**
   * Überprüfen ob der Tetromino an den Seiten angekommen ist
   * @param var move = neue Position vom Tetromino
   * @return bool true = Seite nicht erreicht, false = Seite erreicht
   */

  bool notOnSide(var move) {
    bool stoneOne = move.elementAt(0)['row'] >= 0 &&
        move.elementAt(0)['col'] >= 0 &&
        move.elementAt(0)['col'] < this._game._sizeWidth;

    bool stoneTwo = move.elementAt(1)['row'] >= 0 &&
        move.elementAt(1)['col'] >= 0 &&
        move.elementAt(1)['col'] < this._game._sizeWidth;

    bool stoneThree = move.elementAt(2)['row'] >= 0 &&
        move.elementAt(2)['col'] >= 0 &&
        move.elementAt(2)['col'] < this._game._sizeWidth;

    bool stoneFour = move.elementAt(3)['row'] >= 0 &&
        move.elementAt(3)['col'] >= 0 &&
        move.elementAt(3)['col'] < this._game._sizeWidth;

    return stoneOne && stoneTwo && stoneThree && stoneFour;
  }

    /**
     * Überprüfen ob der Tetromino am Grund angekommen ist
     * @param var move = neue Position vom Tetromino
     * @return bool true = nicht den Boden berührt, false = Boden berührt
     */
    bool notOnGround(var move) {
      bool stoneOne = move.elementAt(0)['row'] >= 0 &&
          move.elementAt(0)['row'] < this._game._sizeHeight;

      bool stoneTwo = move.elementAt(1)['row'] >= 0 &&
          move.elementAt(1)['row'] < this._game._sizeHeight;

      bool stoneThree = move.elementAt(2)['row'] >= 0 &&
          move.elementAt(2)['row'] < this._game._sizeHeight;

      bool stoneFour = move.elementAt(3)['row'] >= 0 &&
          move.elementAt(3)['row'] < this._game._sizeHeight;

      return stoneOne && stoneTwo && stoneThree && stoneFour;
    }

  /**
   * Ueberpruefen, ob der Tetromino mit einem bereits gesetzten Tetromino
   * kollidiert.
   * @param var move = neue Position vom Tetromino
   * @return bool true = Kollision, false = keine Kollision
   */
  bool tetrominoCollision(List move){
    //look at all move to cells
    //if they are not empty and inactive -> collision
    for(int cellIndex=0; cellIndex < move.length; cellIndex++){
      var cell = move[cellIndex];
      //window.console.log('[$cellIndex]ACTIVE: ${this._game.field[cell['row']][cell['col']].isActive} '
      //    'COLOR: ${this._game.field[cell['row']][cell['col']].color}');
      if(this._game.field[cell['row']][cell['col']].color != #empty &&
          !this._game.field[cell['row']][cell['col']].isActive){
          return true;
      }
    }

    return false;

  }

    /**
     * Gibt die Farbe des Tetromino im Spielfeld zurück.
     */
    Symbol get stoneColor => _stoneColor;

  /**
   * Gibt die Farbe des Tetromino im Nächsten-Tetromino-Feld zurück.
   */
  Symbol get nextstoneColor => _nextstoneColor;

  /**
   * Gibt die Elemente des Tetromino und die Position zurück.
   */
   get stone => _stone;

  /**
   * Gibt die Elemente des Tetromino für den nächsten Tetromino und die Position zurück.
   */
  get nextstone => _nextstone;

  /**
   * Gibt die Elemente des Tetromino für den gehalteten Tetromino und die Position zurück.
   */
  get holdstone => _holdstone;

}