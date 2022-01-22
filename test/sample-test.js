const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFT Staking", function () {


  let nftCoreContract;
  let NFTStakingContract;
  let battleBotContract;
  let battleDroneContract, battleGearContract, battleSuiteContract, battleWeaponContract;
  let Ecio2EpicWarriorsCollectionContract;
  let spaceCampContract;
  let headContract;

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


    //BattlePowerData
    const BattleBot = await ethers.getContractFactory("BattleBot");
    battleBotContract = await BattleBot.deploy();
    await battleBotContract.connect(owner).initialize();

    const BattleDrone = await ethers.getContractFactory("BattleDrone");
    battleDroneContract = await BattleDrone.deploy();
    await battleDroneContract.connect(owner).initialize();

    const BattleGear = await ethers.getContractFactory("BattleGear");
    battleGearContract = await BattleGear.deploy();
    await battleGearContract.connect(owner).initialize();

    const BattleSuite = await ethers.getContractFactory("BattleSuite");
    battleSuiteContract = await BattleSuite.deploy();
    await battleSuiteContract.connect(owner).initialize();

    const BattleWeapon = await ethers.getContractFactory("BattleWeapon");
    battleWeaponContract = await BattleWeapon.deploy();
    await battleWeaponContract.connect(owner).initialize();

    const SpaceCamp = await ethers.getContractFactory("SpaceCamp");
    spaceCampContract = await SpaceCamp.deploy();
    await spaceCampContract.connect(owner).initialize();

    const Head = await ethers.getContractFactory("Head");
    headContract = await Head.deploy();
    await headContract.connect(owner).initialize();


    await nftCoreContract.connect(owner).safeMint(owner.address, "00000000001510010000010006"); //5000

    await nftCoreContract.connect(owner).safeMint(addr1.address, "00000000001510010000010006"); //5001
    await nftCoreContract.connect(owner).safeMint(addr1.address, "00000000001510010000010006"); //5002
    await nftCoreContract.connect(owner).safeMint(addr1.address, "00000000001510010000010006"); //5003

    await nftCoreContract.connect(owner).safeMint(addr2.address, "00000000001510010000010006"); //5004
    await nftCoreContract.connect(owner).safeMint(addr2.address, "00000000001510010000010006"); //5005
    await nftCoreContract.connect(owner).safeMint(addr2.address, "00000000001510010000010006"); //5006

    expect(await nftCoreContract.balanceOf(owner.address)).to.equal(1);
    expect(await nftCoreContract.balanceOf(addr1.address)).to.equal(3);
    expect(await nftCoreContract.balanceOf(addr2.address)).to.equal(3);

    const NFTStaking = await ethers.getContractFactory("NFTStaking");
    NFTStakingContract = await NFTStaking.deploy();

    const Ecio2EpicWarriorsCollection = await ethers.getContractFactory("Ecio2EpicWarriorsCollection");
    Ecio2EpicWarriorsCollectionContract = await Ecio2EpicWarriorsCollection.deploy();



    await NFTStakingContract.connect(owner).setupContract(nftCoreContract.address, nftCoreContract.address);
    await nftCoreContract.connect(owner).addOperatorAddress(NFTStakingContract.address);

    await NFTStakingContract.connect(owner).updateBattleBotContract(battleBotContract.address);
    await NFTStakingContract.connect(owner).updateBattleDroneContract(battleDroneContract.address);
    await NFTStakingContract.connect(owner).updateBattleGearContract(battleGearContract.address);
    await NFTStakingContract.connect(owner).updateBattleSuiteContract(battleSuiteContract.address);
    await NFTStakingContract.connect(owner).updateBattleWeaponContract(battleWeaponContract.address);
    await NFTStakingContract.connect(owner).updateCampContract(spaceCampContract.address);
    await NFTStakingContract.connect(owner).updateHeadContract(headContract.address);

    // await NFTStakingContract.connect(owner).addNewCollection(EcioOneLegendaryCollectionContract.address, "EcioOneLegendaryCollectionContract");
  });

  it("Register Challege and Check Challege List", async function () {
    //Register new challenge
    await NFTStakingContract.connect(owner).addNewChallenge(Ecio2EpicWarriorsCollectionContract.address, "Challenge 1th");
    await NFTStakingContract.connect(owner).addNewChallenge(Ecio2EpicWarriorsCollectionContract.address, "Challenge 2nd");

    //Asset
    await NFTStakingContract.getChallenges().then((data) => {
      //console.log(data)
      //Challenge 1th
      expect("0").to.equal(data[0].challengeId);
      expect("Challenge 1th").to.equal(data[0].name);
      expect(false).to.equal(data[0].isDisabled);

      //Challenge 2nd
      expect("1").to.equal(data[1].challengeId);
      expect("Challenge 2nd").to.equal(data[1].name);
      expect(false).to.equal(data[1].isDisabled);
    })


  });

  it("Stake 1th NFT", async function () {
    //Stake
    await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5001);
    await NFTStakingContract.connect(addr1).joinWarrior(5001);

    //Asset
    await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
      console.log(data)
      expect("5001").to.equal(data[0].tokenId);
    })

  });

  it("Stake All and check challenge matching", async function () {
    //Stake
    await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5002);
    await NFTStakingContract.connect(addr1).joinWarrior(5002);

    //Asset
    let challenge1 = 0; //Challenge 1th
    await NFTStakingContract.checkChallenge(addr1.address, challenge1).then((data) => {
      console.log(data)
      expect("2").to.equal(data[0]);
      expect("2").to.equal(data[1]);
    })
    let challenge2 = 1; //Challenge 2nd
    await NFTStakingContract.checkChallenge(addr1.address, challenge2).then((data) => {
      console.log(data)
      expect("2").to.equal(data[0]);
      expect("2").to.equal(data[1]);
    })

    await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
      console.log(data)
      expect("5002").to.equal(data[1].tokenId);
    })


  })

  // it("Stake", async function () {
  //   expect(0).to.equal(await NFTStakingContract.getTotalBattlePower(addr1.address));
  //   await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
  //     console.log(data)
  //   })

  //   await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5001);
  //   await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5002);

  //   await NFTStakingContract.connect(addr1).joinWarrior(5001);
  //   await NFTStakingContract.connect(addr1).joinWarrior(5002);

  //   await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
  //     console.log(data)
  //   })
  //   await NFTStakingContract.totalChallengeBonus(addr1.address).then((data) => {
  //     console.log(data)
  //   })


  //   expect("4820000000000000000000").to.equal(await NFTStakingContract.getTotalBattlePower(addr1.address));

  //   /* 
  //    00 00 00 00 00 15 10 01 00 00 01 00 06
  //    00 00 00 00 01 03 00 01 00 04 02 00 06
  //    00  PC_RESERVED2
  //    00  PC_RESERVED1
  //    00  PC_EQUIPMENT
  //    00  PC_STAR
  //    01  PC_WEAPON
  //    03  PC_GENOME
  //    00  PC_BOT
  //    01  PC_SUITE
  //    00  PC_DRONE
  //    04  PC_GEAR
  //    02  PC_CAMP
  //    00  PC_KINGDOM
  //    06  PC_NFT_TYPE
  //    */



  //   // expect("2410000000000000000000").to.equal(await NFTStakingContract.calculateBattlePower(nftCoreContract.address, 5001));
  //   // expect("2410000000000000000000").to.equal(await NFTStakingContract.calculateBattlePower(nftCoreContract.address, 5002));

  //   // expect("4820000000000000000000").to.equal(await NFTStakingContract.battlePowerBalances(addr1.address));

  //   // await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
  //   //   console.log(data)
  //   //   expect(data.length).to.equal(2);
  //   // })




  //   // expect("0").to.equal(await NFTStakingContract.battlePowerBalances(addr1.address));


  //   // await NFTStakingContract.splitPartCode("00000000000100040001000006").then((data)=>{
  //   //   console.log(data)
  //   // })

  //   // expect(2).to.equal(await NFTStakingContract.getTotalBattlePower(addr1.address));
  //   // expect(2).to.equal(await NFTStakingContract.SplitPartCode("00000000000100040001000006"));

  //   //expect(100).to.equal(await NFTStakingContract.totalCollectionBonus(addr1.address));

  //   // expect(await NFTStakingContract.getMyStakedNFTs(addr1.address).length).to.equal(2);
  //   // expect(await nftCoreContract.balanceOf(NFTPoolContract.address)).to.equal(1);

  // });

  // it("getChallenges", async function () {
  //   await NFTStakingContract.getChallenges().then((data) => {
  //     console.log(data)

  //   });
  // });

  // it("unstake", async function () {

  //   await NFTStakingContract.connect(addr1).unJoinAllWarrior();
  //   // await NFTStakingContract.connect(addr1).unJoinWarrior(5001);
  //   // await NFTStakingContract.connect(addr1).unJoinWarrior(5002);
  //   await NFTStakingContract.getMyStakedNFTs(addr1.address).then((data) => {
  //     console.log(data)
  //   })
  //   expect(0).to.equal(await NFTStakingContract.getTotalBattlePower(addr1.address));
  // });

  // it("Ranking", async function () {
  //   await NFTStakingContract.getTop50Ranking().then((data) => {
  //     console.log(data)

  //   });
  // });

  // it("claimReward", async function () {
  //   //expect(28920).to.equal(await NFTStakingContract.rewards(addr1.address));
  //   expect(false).to.equal(await NFTStakingContract.canClaimReward(addr1.address));
  //   // await NFTStakingContract.connect(addr1).claimReward();
  // });



  // it("Test joinAllWarrior", async function () {
  //   await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5001);
  //   await nftCoreContract.connect(addr1).approve(NFTStakingContract.address, 5002);
  //   await NFTStakingContract.connect(addr1).joinAllWarrior([5001, 5002]);
  // });

});
