const { ethers } = require("hardhat");

async function main() {
  const splitsFactory = await ethers.getContractFactory("Splits");

  // Start deployment, returning a promise that resolves to a contract object
  const splits = await splitsFactory.deploy();
  console.log("Contract deployed to address:", splits.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
