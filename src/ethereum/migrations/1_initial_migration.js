const Amazon = artifacts.require("Amazon");

module.exports = function (deployer) {
  deployer.deploy(Amazon);
};
