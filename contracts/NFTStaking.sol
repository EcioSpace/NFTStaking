//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

interface ECIONFTCore {
    function tokenInfo(uint256 _tokenId)
        external
        view
        returns (string memory, uint256);
}

interface BattlePowor {
    function getValue(string memory codeNumber, uint256 attributeId)
        external
        view
        returns (uint256);
}

contract NFTStaking {
    uint256 constant HP = 0;
    uint256 constant ATK = 1;
    uint256 constant DEF = 2;
    uint256 constant ASPD = 3;
    uint256 constant RANGE = 4;
    uint256 constant BONUS_HP = 5;
    uint256 constant BONUS_ATK = 6;
    uint256 constant BONUS_DEF = 7;
    uint256 constant BONUS_ASPD = 8;
    uint256 constant CRIT = 9;
    uint256 constant DODGE = 10;
    uint256 constant LIFESTEAL = 11;

    struct StakedNFT {
        uint256 tokenId;
        address contractAddress;
        uint256 timestamp;
        address owner;
        bool isStaked;
    }

    address public NFTCoreV1;
    address public NFTCoreV2;

    mapping(address => uint256[]) public userNFTIds;
    mapping(address => uint256) public userStakedNFTCount;
    mapping(address => mapping(uint256 => bool)) userNFTOwner;
    mapping(uint256 => uint256) public nftStakedNFTIds;

    StakedNFT[] public stakedNFTs;

    constructor() {}

    address BattleBotContract;
    address BattleDroneContract;
    address BattleGearContract;
    address BattleSuiteContract;
    address BattleWeaponContract;
    address SpaceCrewContract;

    //Setup
    function updateBattleBotContract(address contractAddress) public {
        BattleBotContract = contractAddress;
    }

    function updateBattleDroneContract(address contractAddress) public {
        BattleDroneContract = contractAddress;
    }

    function updateBattleGearContract(address contractAddress) public {
        BattleGearContract = contractAddress;
    }

    function updateBattleSuiteContract(address contractAddress) public {
        BattleSuiteContract = contractAddress;
    }

    function updateBattleWeaponContract(address contractAddress) public {
        BattleWeaponContract = contractAddress;
    }

    function updateSpaceCrewContract(address contractAddress) public {
        SpaceCrewContract = contractAddress;
    }

    function setupContract(address nftCoreV1, address nftCoreV2) public {
        NFTCoreV1 = nftCoreV1;
        NFTCoreV2 = nftCoreV2;
    }

    function addCollection(address collectionAddress) public {}

    function removeCollection(address collectionAddress) public {}

    function stake(uint256 tokenId) public {
        //Owner validation
        address ownerV1 = ERC721(NFTCoreV1).ownerOf(tokenId);
        address ownerV2 = ERC721(NFTCoreV2).ownerOf(tokenId);

        require(
            ownerV1 == msg.sender || ownerV2 == msg.sender,
            "You is not owner"
        );

        address nftCoreAddress;
        if (ownerV1 == msg.sender) {
            nftCoreAddress = NFTCoreV1;
        } else if (ownerV2 == msg.sender) {
            nftCoreAddress = NFTCoreV2;
        }

        //Transfer token to this contract
        ERC721(nftCoreAddress).transferFrom(msg.sender, address(this), tokenId);

        stakedNFTs.push(
            StakedNFT(
                tokenId,
                nftCoreAddress,
                block.timestamp,
                msg.sender,
                true
            )
        );

        uint256 id = getStakedNFTId();

        userNFTIds[msg.sender].push(id);

        userStakedNFTCount[msg.sender] += 1;

        userNFTOwner[msg.sender][tokenId] = true;

        nftStakedNFTIds[tokenId] = id;
    }

    function unStake(uint256 tokenId) public {
        
        require(userNFTOwner[msg.sender][tokenId], "You is not nft owner.");

        uint256 stakedNFTId = nftStakedNFTIds[tokenId];

        StakedNFT memory stakedNFT = stakedNFTs[stakedNFTId];

        ERC721(stakedNFT.contractAddress).transferFrom(
            address(this),
            msg.sender,
            tokenId
        );

        delete userNFTIds[msg.sender][stakedNFTId];
        userStakedNFTCount[msg.sender] -= 1;
    }

    function getReward() public {}

    function calculateReward() public {}

    function calculateBattlePower(address contractAddress, uint256 tokenId)
        public
        view
        returns (uint256)
    {
        string memory partCode;
        uint256 id;
        (partCode, id) = ECIONFTCore(contractAddress).tokenInfo(tokenId);
        BattlePowor battleBotContract = BattlePowor(BattleBotContract);
        uint256 hpValue = battleBotContract.getValue("00", HP);
        uint256 atkValue = battleBotContract.getValue("00", ATK);
        uint256 defValue = battleBotContract.getValue("00", DEF);
        uint256 aspdValue = battleBotContract.getValue("00", ASPD);
        uint256 rangeValue = battleBotContract.getValue("00", RANGE);
        uint256 bonusHpValue = battleBotContract.getValue("00", BONUS_HP);
        uint256 bonusAtkValue = battleBotContract.getValue("00", BONUS_ATK);
        uint256 bonusDefValue = battleBotContract.getValue("00", BONUS_DEF);
        uint256 bonusAspdValue = battleBotContract.getValue("00", BONUS_ASPD);
        uint256 critValue = battleBotContract.getValue("00", CRIT);
        uint256 dodgeValue = battleBotContract.getValue("00", DODGE);
        uint256 lifeStealValue = battleBotContract.getValue("00", LIFESTEAL);

        // battlePower =  HP + ((ATK/ASPD)*10) + (DEF*15)
        uint256 battlePower = hpValue + ((atkValue / aspdValue) * 10) + (defValue * 15);

        return battlePower;
    }

    //View
    function getMyStakedNFTs(address account)
        public
        view
        returns (StakedNFT[] memory)
    {
        uint256 count = 0;
        StakedNFT[] memory results = new StakedNFT[](
            userStakedNFTCount[account]
        );

        for (uint256 index = 0; index < userNFTIds[account].length; index++) {
            results[count] = stakedNFTs[userNFTIds[account][index]];
            count++;
        }

        return results;
    }

    function getStakedNFTId() internal view returns (uint256) {
        return stakedNFTs.length - 1;
    }

    function batchStake(uint256[] memory ids) public {}

    function joinedWarriors(address account) public {}

    function totalBattlePower(address account) public {}

    function rewards(address account) public {}
}
