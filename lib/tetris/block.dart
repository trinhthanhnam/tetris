import 'package:flutter/material.dart';
import 'package:tetris_match/tetris/config.dart';
import 'package:tetris_match/tetris/board.dart';

class Block {
  TypeOfBlock type;

  Block({required this.type});

  // the block is just a list of interger represent the shape in the grid
  List<int> position = [];

  Color get color {
    return BlockColors[type] ?? Colors.grey;
  }

  void initBlock() {

    List<int> aboveTheScreen = [30, 30, 30, 30, 30];

    if      (type == TypeOfBlock.L) {
      position = [4, 14, 24, 25];
    }
    else if (type == TypeOfBlock.J) {
      position = [5, 15, 25, 24];
    }
    else if (type == TypeOfBlock.I) {
      position = [23, 24, 25, 26];
    }
    else if (type == TypeOfBlock.O) {
      position = [14, 15, 24, 25];
    }
    else if (type == TypeOfBlock.S) {
      position = [14, 15, 23, 24];
    }
    else if (type == TypeOfBlock.Z) {
      position = [14, 15, 25, 26];
    }
    else if (type == TypeOfBlock.T) {
      position = [14, 15, 16, 25];
    }
    // keeping new block appear above the screen
    for (int i = 0; i < position.length; i++) {
      position[i] -= aboveTheScreen[i];
    }
  }

  void empty() {
    position = [];
  }
  void moveBlock(Direction direction) {
    if      (direction == Direction.left) {
      for(int i = 0; i < position.length; i++) {
        position[i] -= 1;
      }
    }
    else if (direction == Direction.right) {
      for(int i = 0; i < position.length; i++) {
        position[i] += 1;
      }
    }
    else if (direction == Direction.down) {
      for(int i = 0; i < position.length; i++) {
        position[i] += rowLength;
      }
    }
  }

  int rotationState = 1;
  bool isValidPosition(int position) {
    int row = (position/rowLength).floor();
    int col = position % rowLength;
    // if the new position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null ) {
      return false;
    }
    return true;
  }

  bool isValidBlockRotation(List<int> position) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for(int pos in position) {
      if(isValidPosition(pos) == false) {
        return false;
      }
      int col = pos % rowLength;
      if(col == 0) {
        firstColOccupied = true;
      }
      if(col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
   return !(firstColOccupied && lastColOccupied);
  }

  void rotateBlock() {
    List<int> newPos = [];
    if      (type == TypeOfBlock.L) {
      if(rotationState == 0) {
        newPos = [
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength + 1,
        ];
      }
      else if (rotationState == 1) {
        newPos = [
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
        ];
      }
      else if (rotationState == 2) {
        newPos = [
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - rowLength + 1,
        ];
      }
      else if (rotationState == 3) {
        newPos = [
          position[1] - rowLength + 1,
          position[1],
          position[1] + 1,
          position[1] - 1,
        ];
      }
    }
    else if (type == TypeOfBlock.J) {
      if(rotationState == 0) {
        newPos = [
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength - 1,
        ];
      }
      else if (rotationState == 1) {
        newPos = [
          position[1] - rowLength - 1,
          position[1],
          position[1] - 1,
          position[1] + 1,
        ];
      }
      else if (rotationState == 2) {
        newPos = [
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - rowLength + 1,
        ];
      }
      else if (rotationState == 3) {
        newPos = [
          position[1] + 1,
          position[1],
          position[1] - 1,
          position[1] + rowLength + 1,
        ];
      }
    }
    else if (type == TypeOfBlock.I) {
      if(rotationState == 0) {
        newPos = [
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + 2,
        ];
      }
      else if (rotationState == 1) {
        newPos = [
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + 2 * rowLength,
        ];
      }
      else if (rotationState == 2) {
        newPos = [
          position[1] + 1,
          position[1],
          position[1] - 1,
          position[1] - 2,
        ];
      }
      else if (rotationState == 3) {
        newPos = [
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - 2 * rowLength,
        ];
      }
    }
    else if (type == TypeOfBlock.O) {
      return;
    }
    else if (type == TypeOfBlock.S) {
      if(rotationState == 0) {
        newPos = [
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
          position[1] + rowLength,
        ];
      }
      else if (rotationState == 1) {
        newPos = [
          position[0] - rowLength,
          position[0],
          position[0] + 1,
          position[0] + rowLength + 1,
        ];
      }
      else if (rotationState == 2) {
        newPos = [
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
          position[1] + rowLength,
        ];
      }
      else if (rotationState == 3) {
        newPos = [
          position[0] - rowLength,
          position[0],
          position[0] + 1,
          position[0] + rowLength + 1,
        ];
      }
    }
    else if (type == TypeOfBlock.Z) {
      if(rotationState == 0) {
        newPos = [
          position[0] + rowLength - 2,
          position[1],
          position[2] + rowLength - 1,
          position[3] + 1,
        ];
      }
      else if (rotationState == 1) {
        newPos = [
          position[0] - rowLength + 2,
          position[1],
          position[2] - rowLength + 1,
          position[3] - 1,
        ];
      }
      else if (rotationState == 2) {
        newPos = [
          position[0] + rowLength - 2,
          position[1],
          position[2] + rowLength - 1,
          position[3] + 1,
        ];
      }
      else if (rotationState == 3) {
        newPos = [
          position[0] - rowLength + 2,
          position[1],
          position[2] - rowLength + 1,
          position[3] - 1,
        ];
      }
    }
    else if (type == TypeOfBlock.T) {
      if(rotationState == 0) {
        newPos = [
          position[2] - rowLength,
          position[2],
          position[2] + 1,
          position[2] + rowLength,
        ];
      }
      else if (rotationState == 1) {
        newPos = [
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + rowLength,
        ];
      }
      else if (rotationState == 2) {
        newPos = [
          position[1] - rowLength,
          position[1] - 1,
          position[1],
          position[1] + rowLength,
        ];
      }
      else if (rotationState == 3) {
        newPos = [
          position[2] - rowLength,
          position[2] - 1,
          position[2],
          position[2] + 1,
        ];
      }
    }

    if(isValidBlockRotation(newPos) == true) {
      position = newPos;
      // update rotationState
      if (rotationState < 3) rotationState = (rotationState + 1) % 4;
      else rotationState = 0;
    }
  }
}