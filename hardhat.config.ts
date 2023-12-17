import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: '0.8.17',
        settings: {
          optimizer: {
            enabled: true,
            runs: 1300,
          },
        },
      },
       

      // for DummyOldResolver contract
      {
        version: '0.4.11',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
   networks: {
    goerli: {
      // Configuration for the Hardhat network (for local development)
      chainId: 5,
            accounts: [`0x${process.env.ROPSTEN_PRIVATE_KEY}`]

    }
    // You can add more networks here (e.g., mainnet, rinkeby, etc.)
  },
};

export default config;
