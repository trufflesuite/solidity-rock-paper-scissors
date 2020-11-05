const RockPaperScissors = artifacts.require("RockPaperScissors");

module.exports = function(deployer) {
  return deployer.then(() => deployer.deploy(RockPaperScissors));
};
