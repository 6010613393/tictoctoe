import 'package:flutter/material.dart';
import 'package:tictoctoe/ai/ai.dart';

void main() => runApp(TictactoeUI());

class TictactoeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Tic-tac", home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Image(
                    width: 300,
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/f/f6/Tic_Tac_Toe.png')),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('   VS Player     '),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Playerpage()));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('VS Computer'),
                      onPressed: () {
                        //Navigator.push(context,
                            //MaterialPageRoute(builder: (context) => Botpage()));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Playerpage extends StatefulWidget {
  @override
  _PlayerpageState createState() => _PlayerpageState();
}

class _PlayerpageState extends State<Playerpage> {
  String result = '<<< ผลลัพธ์ >>>';
  List<List> _matrix;

  _PlayerpageState() {
    _CreateInitMatrix();
  }

  _CreateInitMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Play with Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildElement(0, 0),
                  _buildElement(0, 1),
                  _buildElement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildElement(1, 0),
                  _buildElement(1, 1),
                  _buildElement(1, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildElement(2, 0),
                  _buildElement(2, 1),
                  _buildElement(2, 2),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(result),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Back to Menu'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    child: Text('Restart Game'),
                    onPressed: () {
                      setState(() {
                        _CreateInitMatrix();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text('Created by Rateepat Prajonthong 6010613393'),
            ],
          ),
        ));
  }

  String lastChar = 'O';

  _buildElement(int i, int j) {
    return GestureDetector(
        onTap: () {
          _XorO(i, j);
          _CheckWinner(i, j);
        },
        child: Container(
          width: 90.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black)),
          child: Center(
            child: Text(
              _matrix[i][j],
              style: TextStyle(fontSize: 92.0),
            ),
          ),
        ));
  }

  _XorO(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (lastChar == 'O') {
          _matrix[i][j] = 'X';
        } else
          _matrix[i][j] = 'O';

        lastChar = _matrix[i][j];
      }
    });
  }

  _CheckWinner(int x, int y) {
    var column = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) column++;
      if (_matrix[i][x] == player) row++;
      if (_matrix[i][i] == player) diag++;
      if (_matrix[i][n - 1] == player) rdiag++;
    }
    if (row == n + 1 || column == n + 1 || diag == n + 1 || rdiag == n + 1) {
      result = '$player WON';
    }
  }
}

/*class Botpage extends StatefulWidget {
  @override
  _BotpageState createState() => _BotpageState();
}

class _BotpageState extends State<Botpage> {
  AI ai;
  String aiChar = 'O';
  String result = '<<< ผลลัพธ์ >>>';
  List<List> matrix;

  _BotpageState() {
    _CreateInitMatrix();
  }

  _CreateInitMatrix() {
    matrix = List<List>(3);
    for (var i = 0; i < matrix.length; i++) {
      matrix[i] = List(3);
      for (var j = 0; j < matrix[i].length; j++) {
        matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ai = AI(matrix, playerChar, aiChar);
    return Scaffold(
        appBar: AppBar(
          title: Text('Play with Computer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildElement(0, 0),
                  _buildElement(0, 1),
                  _buildElement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildElement(1, 0),
                  _buildElement(1, 1),
                  _buildElement(1, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildElement(2, 0),
                  _buildElement(2, 1),
                  _buildElement(2, 2),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(result),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Back to Menu'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    child: Text('Restart Game'),
                    onPressed: () {
                      setState(() {
                        _CreateInitMatrix();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text('Created by Rateepat Prajonthong 6010613393'),
            ],
          ),
        ));
  }

  String playerChar = 'X';

  _buildElement(int i, int j) {
    return GestureDetector(
        onTap: () {
          _XorO(i, j);
          _CheckWinner(i, j);
          _AiTurn();
        },
        child: Container(
          width: 90.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black)),
          child: Center(
            child: Text(
              matrix[i][j],
              style: TextStyle(fontSize: 92.0),
            ),
          ),
        ));
  }

  _XorO(int i, int j) {
    setState(() {
      if (matrix[i][j] == ' ') {
        if (playerChar == 'X') {
          matrix[i][j] = 'X';
        }
      }
    });
  }

  _AiTurn() {
    // AI turn
    var aiDecision = ai.getDecision();
    matrix[aiDecision.row][aiDecision.column] = aiChar;
  }

  _CheckWinner(int x, int y) {
    var column = 0, row = 0, diag = 0, rdiag = 0;
    var n = matrix.length - 1;
    var player = matrix[x][y];

    for (int i = 0; i < matrix.length; i++) {
      if (matrix[x][i] == player) column++;
      if (matrix[i][x] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - 1] == player) rdiag++;
    }
    if (row == n + 1 || column == n + 1 || diag == n + 1 || rdiag == n + 1) {
      result = '$player WON';
    }
  }
}*/
