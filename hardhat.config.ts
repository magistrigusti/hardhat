import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "./tasks/sample_tasks";

const config: HardhatUserConfig = {
  solidity: "0.8.27",
  networks: {
    hardhat: {
      chainId: 133
    }
  },
  // namedAccounts: {
  //   deployer: 0,
  //   user: 1,
  // }
};

export default config;
