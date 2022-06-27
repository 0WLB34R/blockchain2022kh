require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks:{
    rinkeby:{
      url:'https://eth-rinkeby.alchemyapi.io/v2/vrqXl8rTR2SEBAZ4IzuJo4kb7CSWGYgc',
      accounts:['']
    },
    goerli:{
      url:'https://eth-goerli.alchemyapi.io/v2/vrqXl8rTR2SEBAZ4IzuJo4kb7CSWGYgc',
      accounts:['']
    },
    bscTestnet:{
      url:'https://data-seed-prebsc-1-s1.binance.org:8545',
      accounts:{mneumonic:''}
    },
    bsc: {
      url: 'https://bsc-dataseed.binance.org',
      chainId: 56,
      accounts: {
        mnemonic: mnemonic
      }
    },
    eth: {
      url: "https://eth-mainnet.alchemyapi.io/v2/IslHFjdsGv0e4bIv-922_xpByaMihNoF",
      accounts:['']
    }

  },
  paths:{
    sources:"./src/ethereum-hardhat/contracts",
    tests:"./src/ethereum-hardhat/test",
    cache:"./src/ethereum-hardhat/cache",
    artifacts:"./src/ethereum-hardhat/artifacts",
  }
}
