const hre = require('hardhat');
const ethers = hre.ethers;

async function main() {
  const [signer] = await ethers.getSigners();

  const Transfers = await ethers.getContractFactory('Transfers', signer); // Имя контракта должно быть с заглавной буквы 'T'
  const transfers = await Transfers.deploy(3);
  
  // Ожидание завершения транзакции развертывания
  await transfers.deployed();
  
  console.log("Contract deployed to address:", transfers.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });