const hre = require('hardhat');
const ethers = hre.ethers;
const TransfersArtifact = require('../artifacts/contracts/Transfer.sol/Transfers.json');

async function currentBalance(address) {
  const rawBalance = ethers.provider.getBalance(address);
  console.log(msg, ethers.utils.formatEther(rawBalance));
}

async function main() {
  const [acc1, acc2] = await ethers.getSigners();
  const contractAddr = '0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2';
  const transfersContract = new ethers.Contract(
    contractAddr,
    TransfersArtifact.abi,
    acc1
  )
  const result = await transfersContract.connect(acc2).withdrawTo(acc2.address);
  console.log(result);
  // const result = await transferContract.getTransfer(0);
  // console.log(result['amount'], result[sender]);

  // const tx = {
  //   to: contractAddr.address,
  //   value: ethers.utils.parseEthers("1")
  // }

  // const txSend = await acc2.sendTransaction(tx);
  // await txSend.wait();

  await currentBalance(acc2.address, "Account 2 balance:")
  await currentBalance(contractAddr, "Contract balance:");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    recoverAddress.exit(1)
  })