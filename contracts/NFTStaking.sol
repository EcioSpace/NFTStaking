//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface ECIOERC721 {
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

interface CollectionBonus {
    function bonus(
        address account,
        address[] memory contracts,
        uint256[] memory tokenIds
    ) external view returns (uint256);
}

contract NFTStaking is Ownable {
    using Counters for Counters.Counter;

    uint256 constant REWARD_POOL = 30000000000000000000000000;
    uint256 constant REWARD_RATE = 30000000000000000000000000;
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

    // Part Code Index
    uint256 constant PC_NFT_TYPE = 12;
    uint256 constant PC_KINGDOM = 11;
    uint256 constant PC_CAMP = 10;
    uint256 constant PC_GEAR = 9;
    uint256 constant PC_DRONE = 8;
    uint256 constant PC_SUITE = 7;
    uint256 constant PC_BOT = 6;
    uint256 constant PC_GENOME = 5;
    uint256 constant PC_WEAPON = 4;
    uint256 constant PC_STAR = 3;
    uint256 constant PC_EQUIPMENT = 2;
    uint256 constant PC_RESERVED1 = 1;
    uint256 constant PC_RESERVED2 = 0;

    IERC20 public rewardsTokenContract;

    uint256 public rewardRate = 100;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public tokenRewards;

    uint256 private _totalSupply;
    mapping(address => uint256) private _battlePowerBalances;

    struct StakedNFT {
        uint256 tokenId;
        address contractAddress;
        uint256 timestamp;
        address owner;
        bool isStaked;
    }

    struct Collection {
        uint256 collectionId;
        string name;
        address collectionAddress;
        bool isDisabled;
    }

    address public NFTCoreV1;
    address public NFTCoreV2;

    mapping(address => uint256[]) public userNFTIds;
    mapping(address => uint256) public userStakedNFTCount;
    mapping(address => mapping(uint256 => bool)) userNFTOwner;
    mapping(uint256 => uint256) public nftStakedNFTIds;

    StakedNFT[] public stakedNFTs;
    Collection[] public collections;
    Counters.Counter private collectionIdCounter;

    constructor() {}

    BattlePowor battleBotContract;
    BattlePowor battleDroneContract;
    BattlePowor battleGearContract;
    BattlePowor battleSuiteContract;
    BattlePowor battleWeaponContract;
    BattlePowor headContract;
    BattlePowor campContract;

    //Setup
    function updateRewardContract(address contractAddress) public onlyOwner {
        rewardsTokenContract = IERC20(contractAddress);
    }

    function updateBattleBotContract(address contractAddress) public onlyOwner {
        battleBotContract = BattlePowor(contractAddress);
    }

    function updateBattleDroneContract(address contractAddress)
        public
        onlyOwner
    {
        battleDroneContract = BattlePowor(contractAddress);
    }

    function updateBattleGearContract(address contractAddress)
        public
        onlyOwner
    {
        battleGearContract = BattlePowor(contractAddress);
    }

    function updateBattleSuiteContract(address contractAddress)
        public
        onlyOwner
    {
        battleSuiteContract = BattlePowor(contractAddress);
    }

    function updateBattleWeaponContract(address contractAddress)
        public
        onlyOwner
    {
        battleWeaponContract = BattlePowor(contractAddress);
    }

    function updateHeadContract(address contractAddress) public onlyOwner {
        headContract = BattlePowor(contractAddress);
    }

    function updateCampContract(address contractAddress) public onlyOwner {
        campContract = BattlePowor(contractAddress);
    }

    function setupContract(address nftCoreV1, address nftCoreV2)
        public
        onlyOwner
    {
        NFTCoreV1 = nftCoreV1;
        NFTCoreV2 = nftCoreV2;
    }

    function addNewCollection(address collectionAddress, string memory name)
        public
        onlyOwner
    {
        collections.push(
            Collection(
                collectionIdCounter.current(),
                name,
                collectionAddress,
                false
            )
        );
        collectionIdCounter.increment();
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return 0;
        }
        return
            rewardPerTokenStored +
            (((block.timestamp - lastUpdateTime) * rewardRate * 1e18) /
                _totalSupply);
    }

    function joinWarrior(uint256 tokenId) public updateReward(msg.sender) {
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

        uint256 battlePower = calculateBattlePower(nftCoreAddress, tokenId);
        _totalSupply += battlePower;
        _battlePowerBalances[msg.sender] += battlePower;
    }

    function unJoinWarrior(uint256 tokenId) public {
        require(userNFTOwner[msg.sender][tokenId], "You is not nft owner.");

        uint256 stakedNFTId = nftStakedNFTIds[tokenId];

        StakedNFT memory stakedNFT = stakedNFTs[stakedNFTId];

        ERC721(stakedNFT.contractAddress).transferFrom(
            address(this),
            msg.sender,
            tokenId
        );

        uint256 battlePower = calculateBattlePower(
            stakedNFT.contractAddress,
            tokenId
        );
        _totalSupply -= battlePower;
        _battlePowerBalances[msg.sender] -= battlePower;

        delete userNFTIds[msg.sender][stakedNFTId];
        userStakedNFTCount[msg.sender] -= 1;
    }

    function withdraw(uint256 _amount) external updateReward(msg.sender) {
        _totalSupply -= _amount;
        _battlePowerBalances[msg.sender] -= _amount;
        rewardsTokenContract.transfer(msg.sender, _amount);
    }

    function claimReward() external updateReward(msg.sender) {
        uint256 reward = tokenRewards[msg.sender];
        tokenRewards[msg.sender] = 0;
        rewardsTokenContract.transfer(msg.sender, reward);
    }

    function splitPartCode(string memory partCode)
        public
        view
        returns (string[] memory)
    {
        string[] memory result = new string[](bytes(partCode).length / 2);
        for (uint256 index = 0; index < bytes(partCode).length / 2; index++) {
            result[index] = string(
                abi.encodePacked(
                    bytes(partCode)[index * 2],
                    bytes(partCode)[(index * 2) + 1]
                )
            );
        }
        return result;
    }

    function calculateBattlePower(address contractAddress, uint256 tokenId)
        public
        view
        returns (uint256)
    {
        string memory partCode;
        uint256 id;
        (partCode, id) = ECIOERC721(contractAddress).tokenInfo(tokenId);
        string[] memory splittedPartCodes = splitPartCode(partCode);

        //HP = SHInfo.Hp * (SWInfo.BonusHp * SSInfo.BonusHp * SCInfo.BonusHp * SGInfo.BonusHp * SDInfo.BonusHp * SBInfo.BonusHp * rank * lv)
        uint256 hp = calculateHP(splittedPartCodes);

        // DEF = SSInfo.Def * (SHInfo.BonusDef * 	SWInfo.BonusDef *	SSInfo.BonusDef *	SCInfo.BonusDef *	SGInfo.BonusDef *	SDInfo.BonusDef *SBInfo.BonusDef *rank *	lv)
        uint256 def = calculateDef(splittedPartCodes);

        // ATK = SWInfo.Atk * (SHInfo.BonusAtk * 	SSInfo.BonusAtk *	SCInfo.BonusAtk *	SGInfo.BonusAtk *	SDInfo.BonusAtk *	SBInfo.BonusAtk *	rank *	lv)
        uint256 atk = calculateAtk(splittedPartCodes);

        // ASPD = SWInfo.Aspd / (SHInfo.BonusAspd *	SWInfo.BonusAspd *	SSInfo.BonusAspd *	SCInfo.BonusAspd *	SGInfo.BonusAspd *	SDInfo.BonusAspd *	SBInfo.BonusAspd *	rank *	lv)
        uint256 aspd = calculateAspd(splittedPartCodes);
        return (hp/10000)*1e18;
        return  hp + ((atk / aspd) * 10) + (def * 15);
    }

    function calculateHP(string[] memory splittedPartCodes)
        public
        view
        returns (uint256)
    {
        string memory botCode = splittedPartCodes[PC_BOT];
        string memory droneCode = splittedPartCodes[PC_DRONE];
        string memory gearCode = splittedPartCodes[PC_GEAR];
        string memory suiteCode = splittedPartCodes[PC_SUITE];
        string memory weaponCode = splittedPartCodes[PC_WEAPON];
        string memory headCode = splittedPartCodes[PC_GENOME];
        string memory campCode = splittedPartCodes[PC_CAMP];
        uint256 rank = 1;
        uint256 lv = 1;
        //HP = SHInfo.Hp * (SWInfo.BonusHp * SSInfo.BonusHp * SCInfo.BonusHp * SGInfo.BonusHp * SDInfo.BonusHp * SBInfo.BonusHp * rank * lv)
        // return  headContract.getValue(headCode, HP);
        // return battleWeaponContract.getValue(weaponCode, BONUS_HP);
        return
            headContract.getValue(headCode, HP) *
            (battleWeaponContract.getValue(weaponCode, BONUS_HP) *
                battleSuiteContract.getValue(suiteCode, BONUS_HP) *
                campContract.getValue(campCode, BONUS_HP) *
                battleGearContract.getValue(gearCode, BONUS_HP) *
                battleDroneContract.getValue(droneCode, BONUS_HP) *
                battleBotContract.getValue(botCode, BONUS_HP) *
                rank *
                lv);
    }

    function calculateDef(string[] memory splittedPartCodes)
        public
        view
        returns (uint256)
    {
        string memory botCode = splittedPartCodes[PC_BOT];
        string memory droneCode = splittedPartCodes[PC_DRONE];
        string memory gearCode = splittedPartCodes[PC_GEAR];
        string memory suiteCode = splittedPartCodes[PC_SUITE];
        string memory weaponCode = splittedPartCodes[PC_WEAPON];
        string memory headCode = splittedPartCodes[PC_GENOME];
        string memory campCode = splittedPartCodes[PC_CAMP];
        uint256 rank = 1;
        uint256 lv = 1;

        return
            battleSuiteContract.getValue(suiteCode, DEF) *
            (headContract.getValue(headCode, BONUS_DEF) *
                battleWeaponContract.getValue(weaponCode, BONUS_DEF) *
                battleSuiteContract.getValue(suiteCode, BONUS_DEF) *
                campContract.getValue(campCode, BONUS_DEF) *
                battleGearContract.getValue(gearCode, BONUS_DEF) *
                battleDroneContract.getValue(droneCode, BONUS_DEF) *
                battleBotContract.getValue(botCode, BONUS_DEF) *
                rank *
                lv);
    }

    function calculateAtk(string[] memory splittedPartCodes)
        public
        view
        returns (uint256)
    {
        string memory botCode = splittedPartCodes[PC_BOT];
        string memory droneCode = splittedPartCodes[PC_DRONE];
        string memory gearCode = splittedPartCodes[PC_GEAR];
        string memory suiteCode = splittedPartCodes[PC_SUITE];
        string memory weaponCode = splittedPartCodes[PC_WEAPON];
        string memory headCode = splittedPartCodes[PC_GENOME];
        string memory campCode = splittedPartCodes[PC_CAMP];
        uint256 rank = 1;
        uint256 lv = 1;

        return
            battleWeaponContract.getValue(weaponCode, BONUS_ATK) *
            (headContract.getValue(headCode, BONUS_ATK) *
                battleSuiteContract.getValue(suiteCode, BONUS_ATK) *
                campContract.getValue(campCode, BONUS_ATK) *
                battleGearContract.getValue(gearCode, BONUS_ATK) *
                battleDroneContract.getValue(droneCode, BONUS_ATK) *
                battleBotContract.getValue(botCode, BONUS_ATK) *
                rank *
                lv);
    }

    function calculateAspd(string[] memory splittedPartCodes)
        public
        view
        returns (uint256)
    {
        string memory botCode = splittedPartCodes[PC_BOT];
        string memory droneCode = splittedPartCodes[PC_DRONE];
        string memory gearCode = splittedPartCodes[PC_GEAR];
        string memory suiteCode = splittedPartCodes[PC_SUITE];
        string memory weaponCode = splittedPartCodes[PC_WEAPON];
        string memory headCode = splittedPartCodes[PC_GENOME];
        string memory campCode = splittedPartCodes[PC_CAMP];

        uint256 rank = 1;
        uint256 lv = 1;

        return
            battleWeaponContract.getValue(weaponCode, BONUS_ATK) /
            (headContract.getValue(headCode, BONUS_ATK) *
                battleWeaponContract.getValue(weaponCode, BONUS_ATK) *
                battleSuiteContract.getValue(suiteCode, BONUS_ATK) *
                campContract.getValue(campCode, BONUS_ATK) *
                battleGearContract.getValue(gearCode, BONUS_ATK) *
                battleDroneContract.getValue(droneCode, BONUS_ATK) *
                battleBotContract.getValue(botCode, BONUS_ATK) *
                rank *
                lv);
    }

    function totalCollectionBonus(address account)
        public
        view
        returns (uint256)
    {
        StakedNFT[] memory NFTs = getMyStakedNFTs(account);

        if (NFTs.length == 0) {
            return 0;
        }

        uint256[] memory tokenIds = new uint256[](NFTs.length);
        address[] memory contracts = new address[](NFTs.length);

        uint256 totalBonus;
        for (uint256 index = 0; index < NFTs.length; index++) {
            tokenIds[index] = NFTs[index].tokenId;
            contracts[index] = NFTs[index].contractAddress;
        }

        for (uint256 index = 0; index < collections.length; index++) {
            Collection memory collection = collections[index];
            totalBonus =
                totalBonus +
                CollectionBonus(collection.collectionAddress).bonus(
                    account,
                    contracts,
                    tokenIds
                );
        }

        return totalBonus;
    }

    //View
    function getMyStakedNFTs(address account)
        public
        view
        returns (StakedNFT[] memory)
    {
        if (userStakedNFTCount[account] == 0) {
            StakedNFT[] memory results;
            return results;
        }

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

    function getTotalBattlePower(address account)
        public
        view
        returns (uint256)
    {
        uint256 count = 0;
        uint256 battlePower = 0;
        StakedNFT[] memory results = new StakedNFT[](
            userStakedNFTCount[account]
        );

        for (uint256 index = 0; index < userNFTIds[account].length; index++) {
            StakedNFT memory stakedNFT = stakedNFTs[userNFTIds[account][index]];
            battlePower += calculateBattlePower(
                stakedNFT.contractAddress,
                stakedNFT.tokenId
            );
        }

        return battlePower;
    }

    function getStakedNFTId() internal view returns (uint256) {
        return stakedNFTs.length - 1;
    }

    function batchStake(uint256[] memory ids) public {}

    function joinedWarriors(address account) public {}

    function totalBattlePower(address account) public {}

    //Staking Functions
    function rewards(address account) public view returns (uint256) {
        return
            ((_battlePowerBalances[account] *
                (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) +
            tokenRewards[account];
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        tokenRewards[account] = rewards(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }
}
