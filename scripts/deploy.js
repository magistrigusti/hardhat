const hre = require('hardhat');
const ethers = hre.ethers;

async function main() {
  const [signer] = await ethers.getSigners();
  const Transfers = await ethers.getContractFactory('Transfers', signer);

  // Развертываем контракт с аргументом конструктора (например, 3)
  const transfers = await Transfers.deploy(3);

  // Ожидание завершения транзакции развертывания контракта
  await transfers.waitForDeployment();

  console.log( transfers.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
