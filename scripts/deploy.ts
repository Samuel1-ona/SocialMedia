import { ethers } from "hardhat";

async function main() {
  

  const Covalnft = await ethers.deployContract("CovalSocialMedia");

  await Covalnft.waitForDeployment();

  const CovalSocialMedia = await ethers.deployContract("CovalSocialMedia");

  await CovalSocialMedia.waitForDeployment();


  console.log(
    `CovalSocialMedia  deployed to ${Covalnft.target}`
  );

  console.log(
    `CovalSocialMedia  deployed to ${CovalSocialMedia.target}`

  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
