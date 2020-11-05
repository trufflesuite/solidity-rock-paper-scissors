pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RockPaperScissors {
  struct Player {
    address payable playerAddress;
    uint8 move;
  }

  IERC20 private _token;
  bool public player1Turn;
  Player public player1;
  Player public player2;

  constructor() public {
    player1Turn = true;
    _token = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
  }

  function makeMove(uint8 move) public {
    require(_token.balanceOf(msg.sender) >= 1000000000000000000, "Need at least 1 DAI to play");

    _token.transferFrom(msg.sender, address(this), 1000000000000000000);

    if (player1Turn) {
      player1.playerAddress = msg.sender;
      player1.move = move;
    } else {
      player2.playerAddress = msg.sender;
      player2.move = move;

      pickWinner();
    }

    player1Turn = !player1Turn;
  }

  function pickWinner() private {
    address winner = 0x0000000000000000000000000000000000000000;

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
      _token.transferFrom(address(this), winner, _token.balanceOf(address(this)));
    }
  }
}
