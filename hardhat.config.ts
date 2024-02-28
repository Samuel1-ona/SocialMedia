import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const { URL, KEY ,ETH_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: URL,
      accounts: [KEY as string],
    },
    
  },
  etherscan: {
    apiKey: ETH_KEY,
  }
}


export default config;
