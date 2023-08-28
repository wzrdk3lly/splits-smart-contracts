const { BigNumber } = require("ethers");
const { ethers } = require("hardhat");

async function main() {
  const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;
  let splitsContract, deployer;

  // grabs the signer we have in hardhat.config
  [deployer] = await ethers.getSigners();
  // grabs the abi data from artifacts
  splitsContract = await ethers.getContractAt(
    "Splits",
    CONTRACT_ADDRESS,
    deployer
  );

  const toAddress = "0xbC99e9cb0ca4884208F86A4434fDb5CED16e084c";

  //   console.log("Grab the splits contract... ", splitsContract);

  // Now we can make calls to our contract as the signer from this point on
  // lets retrive half the balance for the from address
  let balanceToSend = BigNumber.from(
    ((await ethers.provider.getBalance(deployer.address)) / 2).toString()
  );

  let balanceToEth = ethers.utils.formatUnits(balanceToSend);

  console.log("Balance to send in eth", balanceToEth);

  // lets perform a split and send the split to another dev account - needs message.value to be sent with transaction
  let txperformSplit = await splitsContract.sendSplit(toAddress, {
    value: balanceToSend,
    gasLimit: 5000000,
  });

  let performSplitReceipt = await txperformSplit.wait();

  console.log("perform split receipt", performSplitReceipt);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
