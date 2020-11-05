const RockPaperScissors = artifacts.require("RockPaperScissors");

contract("RockPaperScissors", function (accounts) {
  it("makes a move", async () => {
    const instance = await RockPaperScissors.deployed();
    await instance.makeMove(0, { value: 1000000000000000000 });
    const player1 = await instance.player1();
    assert.equal(player1.move, 0);
  });
});
