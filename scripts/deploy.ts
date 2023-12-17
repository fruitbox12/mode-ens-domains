import { ethers } from "hardhat";

async function main() {
  // Deployer account information
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Deployment parameters
  const name = "ZapNameService"; // Replace with your desired NFT name
  const symbol = "ZNS"; // Replace with your desired NFT symbol
  const zapTokenContractAddress = "0x6781a0f84c7e9e846dcb84a9a5bd49333067b104"; // Replace with the actual ZAP token contract address

  // Deploying NameRegistry contract
  const NameRegistry = await ethers.getContractFactory("NameRegistry");
  const nameRegistry = await NameRegistry.deploy(name, symbol, zapTokenContractAddress);

  // Waiting for the contract to be deployed
  await nameRegistry.deployed();

  console.log("NameRegistry deployed to:", nameRegistry.address);
}

// Error handling
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
