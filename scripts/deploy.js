// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
/**
 * Judge,
        JurorA,
        JurorB,
        JurorC,
        Prosecution,
        Defense,
        Bailiff,
        Defendent
 */
const roles = [
  {
    Address: '0x04B022a51E4413181D8BeF4C06eC642a2C107e3F',
    Role: 'Judge'
  },
  {
    Address: '0xffd8fC86B43F3e7cD6F6184c85801C5cb31C2981',
    Role: 'Jury1'
  },
  {
    Address: '0xB6B3aEcaAaFF6034662CC70Ae3A581C9D4D21bec',
    Role: 'Jury2'
  },
  {
    Address: '0x50825D7609eFc95aEF4f68aF04905FaeF6E97b93',
    Role: 'Jury3'
  },
  {
    Address: '0xa8B30cC58fB9f287863BF435f51886D6b5F475C3',
    Role: 'Prosecutor'
  },
  {
    Address: '0x53E0A037E4b08f1Befa617d34EBB78cBb8015de9',
    Role: 'Defense'
  },
  {
    Address: '0x42f7B8Aa00D05daA58Dfd1c6060B97c0e0318Fe9',
    Role: 'Bailiff'
  },
  {
    Address: '0x51418Bb6de31558061635a4dA8Bca86B1E7D09fb',
    Role: 'Defandant'
  },
]

async function main() {

  const Router = await hre.ethers.getContractFactory("router");
  const router = await Router.deploy();

  await router.deployed();
  const NFT = await hre.ethers.getContractFactory("ERC721K");
  const r = await NFT.deploy(router.address);
  console.log(r.address);
  for (let i = 0; i < roles.length; i++) {
    console.log(i);
    const tx = await NFT.attach(r.address).safeMint(roles[i].Address, i, 1, { gasLimit: 150000});
    await tx.wait();
  }
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
