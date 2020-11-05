pragma solidity ^0.6.0;

contract RockPaperScissors {
  struct Player {
    address payable playerAddress;
    uint8 move;
  }

  bool public player1Turn;
  Player public player1;
  Player public player2;

  constructor() public {
    player1Turn = true;
  }

  function makeMove(uint8 move) public payable {
    require(msg.value >= 1000000000000000000, "Did not pay at least 1 ETH");

    if (player1Turn) {
      player1.playerAddress = msg.sender;
      player1.move = move;
    } else {
      player2.playerAddress = msg.sender;
      player2.move = move;

      pickWinner();
    }
  }

  function pickWinner() private {
    address payable winner = 0x0000000000000000000000000000000000000000;

    if (
      (player1.move == 0 && player2.move == 2) ||
      (player1.move == 1 && player2.move == 0) ||
      (player1.move == 2 && player2.move == 1)
     ) {
      winner = player1.playerAddress;
    } else if (
      (player2.move == 0 && player1.move == 2) ||
      (player2.move == 1 && player1.move == 0) ||
      (player2.move == 2 && player1.move == 1)
    ) {
      winner = player2.playerAddress;
    }

    if (winner != 0x0000000000000000000000000000000000000000) {
      winner.transfer(address(this).balance);
    }
  }
}
