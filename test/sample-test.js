const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFT Staking", function () {


  let nftCoreContract;
  let NFTStakingContract;



  //Accounts
  let owner;
  let addr1;
  let addr2;
  let addrs;

  before(async function () {
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    const ECIONFTCore = await ethers.getContractFactory("ECIONFTCore");
    nftCoreContract = await ECIONFTCore.deploy();
    await nftCoreContract.connect(owner).initialize();

    await nftCoreContract.connect(owner).safeMint(owner.address, "00000000000100040001000006"); //5000

    await nftCoreContract.connect(owner).safeMint(addr1.address, "00000000000100040001000006"); //5001
    await nftCoreContract.connect(owner).safeMint(addr1.address, "00000000000100040001000006"); //5002
    await nftCoreContract.connect(owner).safeMint(addr1.address, "00000000000100040001000006"); //5003

    await nftCoreContract.connect(owner).safeMint(addr2.address, "00000000000100040001000006"); //5004
    await nftCoreContract.connect(owner).safeMint(addr2.address, "00000000000100040001000006"); //5005
    await nftCoreContract.connect(owner).safeMint(addr2.address, "00000000000100040001000006"); //5006

    expect(await nftCoreContract.balanceOf(owner.address)).to.equal(1);
    expect(await nftCoreContract.balanceOf(addr1.address)).to.equal(3);
    expect(await nftCoreContract.balanceOf(addr2.address)).to.equal(3);



    const NFTStaking = await ethers.getContractFactory("NFTStaking");
    NFTStakingContract = await NFTStaking.deploy();

    await NFTStakingContract.connect(owner).setupContract(nftCoreContract.address, nftCoreContract.address);
    await nftCoreContract.connect(owner).addOperatorAddress(NFTStakingContract.address);

  });


  it("Stake", async function () {


    // NFTStakingContract.stake()
    await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5001);
    await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5002);
    await NFTStakingContract.connect(addr1).stake(5001);
    await NFTStakingContract.connect(addr1).stake(5002);

    await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
      // console.log(data)
      expect(data.length).to.equal(2);
    })

    // expect(await NFTStakingContract.getMyStakedNFTs(addr1.address).length).to.equal(2);
    // expect(await nftCoreContract.balanceOf(NFTPoolContract.address)).to.equal(1);

  });

  // it("Canceled Order Testing", async function () {
  //   await marketContract.connect(owner).cancelOrder(1);
  //   expect(await nftCoreContract.balanceOf(owner.address)).to.equal(1);
  //   expect(await nftCoreContract.balanceOf(NFTPoolContract.address)).to.equal(0);
  // });

  // it("Successfull Order Testing", async function () {

  //    await nftCoreContract.connect(owner).approve(marketContract.address, 5000);
  //   await marketContract.connect(owner).createOrder(
  //     nftCoreContract.address,
  //     5000,
  //     100000000000,
  //     BUSDContract.address
  //   );

  //    await BUSDContract.connect(addr1).approve(marketContract.address, 1000000000);
  //    await marketContract.connect(addr1).createSale(2);
  //   // expect(await nftCoreContract.balanceOf(NFTPoolContract.address)).to.equal(0);


  // });
});
