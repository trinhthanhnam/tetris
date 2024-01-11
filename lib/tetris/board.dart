import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_match/tetris/block.dart';
import 'package:tetris_match/tetris/config.dart';
import 'package:tetris_match/tetris/tile.dart';

List<List<TypeOfBlock?>> gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  // current drop block
  late Block currentBlock;
  int droppingNewBlock = 1;
  int currentScore = 0;
  int currentFrame = 400;
  int level = 1;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    Random r = Random();
    TypeOfBlock randomType = TypeOfBlock.values[r.nextInt(TypeOfBlock.values.length)];
    currentBlock = Block(type: randomType);
    currentBlock.initBlock();
    // frameRate config
    Duration frameRate = Duration(milliseconds: currentFrame);
    loopGame(frameRate);
  }

  void loopGame(Duration rate) {
    Timer.periodic(rate,
            (timer) {
              // move the current block down
              setState(() {
                clearLines();
                checkLanding();
                if(droppingNewBlock == 0) {
                  timer.cancel();
                  showEndGameDialog();
                }
                currentBlock.moveBlock(Direction.down);      
              });
            });
  }

  // check for collision, return true if collision happen
  bool checkCollision(Direction direction) {
    int row = 0;
    int col = 0;
    for(int i = 0; i < currentBlock.position.length; i++) {
      row = ( currentBlock.position[i] / rowLength ).floor();
      col = currentBlock.position[i] % rowLength;
      // update location on the grid
      if      (direction == Direction.left) {
        col -= 1;
      }
      else if (direction == Direction.right) {
        col += 1;
      }
      else if (direction == Direction.down) {
        row += 1;
      }
      // check if block still inside the grid
      if ( row >= colLength || col < 0 || col >= rowLength ) {
        return true;
      }
      // check if this dropping block collision with landed block
      if ( row >= 0 && row < colLength && gameBoard[row][col] != null ) {
        return true;  
      }
    }
    return false;
  }

  void checkLanding() {
    int row = 0;
    int col = 0;
    if( checkCollision(Direction.down)) {
      for(int i = 0; i < currentBlock.position.length; i++) {
        row = ( currentBlock.position[i] / rowLength ).floor();
        col = currentBlock.position[i] % rowLength;
        if(row >= 0 && col >= 0) {
          gameBoard[row][col] = currentBlock.type;
        }
      }
      // check if end game
      if( row <= 1 ) {
        droppingNewBlock = 0;
      }
      // when landed , create a new block
      createNewBlock();
    }
  }

  void createNewBlock() {
    if(droppingNewBlock == 0) {
      currentBlock.empty();
      return;
    }
    //  create a random new block dropping
    Random r = Random();
    TypeOfBlock randomType = TypeOfBlock.values[r.nextInt(TypeOfBlock.values.length)];
    currentBlock = Block(type: randomType);
    currentBlock.initBlock();
  }

  void moveLeft() {
    if(!checkCollision(Direction.left)) {
      setState(() {
        currentBlock.moveBlock(Direction.left);
      });
    }
  }

  void moveRight() {
    if(!checkCollision(Direction.right)) {
      setState(() {
        currentBlock.moveBlock(Direction.right);
      });
    }
  }

  void rotateBlock() {
    setState(() {
      currentBlock.rotateBlock();
    });
  }

  void clearLines() {
    for(int i = colLength - 1; i >= 0; i--) {
      bool rowIsFull = true;
      for(int j = 0; j < rowLength; j++) {
        if(gameBoard[i][j] == null) {
          rowIsFull = false;
          break;
        }
      }
      if(rowIsFull == true) {
        for(int r = i; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r-1]);
        }
        // clear the top row
        gameBoard[0] = List.generate(i, (index) => null);
        // set the score
        currentScore ++;
      }
    }
  }

  void checkLevel() {
    int step = 50;
    if ( currentFrame < 150 ) {
      level ++;
      return;
    }
    else {
      level ++;
      currentFrame -= step;
    }
  }

  void showEndGameDialog() {
    showDialog(context: context, builder: (context) =>
     AlertDialog(
       title: const Text('Game Over'),
       content: Text('You score is: $currentScore'),
       actions: [
         TextButton(onPressed: () {
           resetGame();
           Navigator.pop(context);
         }, child: const Text('Retry with more challenger'))
       ],
     )
    );
  }

  void resetGame() {
    checkLevel();
    gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    droppingNewBlock = 1;
    currentScore = 0;
    createNewBlock();
    startGame();
    print("Current level is $level and framerate is $currentFrame");
  }

  @override
  Widget build ( BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
        Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = ( index / rowLength ).floor();
                  int col = index % rowLength;
                  if(currentBlock.position.contains(index)) {
                    return Tile(color: currentBlock.color, child: index);
                  }
                  else if (gameBoard[row][col] != null) {
                    final TypeOfBlock? typeLanded = gameBoard[row][col];
                    return Tile(color: BlockColors[typeLanded], child: '');
                  }
                  else {
                    return Tile(color: Colors.white70, child: index);
                  }
                },
              ),
            ),
            Text(
              'Score: $currentScore',
              style: const TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: moveLeft, icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(onPressed: rotateBlock, icon: const Icon(Icons.rotate_right)),
                  IconButton(onPressed: moveRight, icon: const Icon(Icons.arrow_forward)),
                ],
               ),
              ),

          ],
        ),
    );
  }
}