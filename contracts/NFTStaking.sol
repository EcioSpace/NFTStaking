//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./helper/Helper.sol";
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

    function getStrValue(string memory codeNumber, uint256 attributeId)
        external
        view
        returns (string memory);
}

interface ChallengeBonus {
    function bonus(
        address account,
        address[] memory contracts,
        uint256[] memory tokenIds
    ) external view returns (uint256);

    function staked(address[] memory contracts, uint256[] memory tokenIds)
        external
        view
        returns (uint256, uint256);
}

contract NFTStaking is Ownable, ECIOHelper {
    using Counters for Counters.Counter;
    uint256 stakingFee = 0.005 ether;

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
    uint256 constant NAME = 12;

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
    uint256 constant MINIMUM_AMOUNT_CLAIM = 12500 * 1e18;

    IERC20 public rewardsTokenContract;

    // uint256 public rewardRate = 1930000000000000000;
    uint256 public rewardRate = 500000000000000000000;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    uint256 public totalFee;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public tokenRewards;
    mapping(address => mapping(uint256 => bool)) public userChallenge;

    uint256 private _totalSupply;

    mapping(address => uint256) private _battlePowerBalances;

    mapping(address => uint256) public accountLastClaim;

    struct StakedNFT {
        uint256 tokenId;
        address contractAddress;
        uint256 timestamp;
        address owner;
        bool isStaked;
        uint256 battlePower;
        string name;
        uint256 hp;
        uint256 atk;
        uint256 aspd;
        uint256 def;
    }

    struct Challenge {
        uint256 challengeId;
        string name;
        address challengeAddress;
        bool isDisabled;
    }

    struct Rank {
        address account;
        uint256 totalBattlePower;
        uint256 amount;
    }

    address public NFTCoreV1;
    address public NFTCoreV2;

    mapping(address => uint256[]) public userNFTIds;
    mapping(address => uint256) public userStakedNFTCount;
    mapping(uint256 => address) nftAccounts;
    mapping(uint256 => uint256) public nftStakedNFTIds;

    mapping(uint256 => StakedNFT) public stakedNFTs;
    mapping(address => uint256) public userRankIds;
    mapping(address => bool) public userHasRank;

    Challenge[] public challenges;
    Rank[] public ranks;
    Counters.Counter public challengeIdCounter;
    Counters.Counter public stakedIdCounter;

    address payable public contractWallet;

    constructor() payable {
        contractWallet = payable(msg.sender);
    }

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

    function disableChallenge(uint256 challengeId) public onlyOwner {
        challenges[challengeId].isDisabled = false;
    }

    function enableChallenge(uint256 challengeId) public onlyOwner {
        challenges[challengeId].isDisabled = true;
    }

    function addNewChallenge(address challengeAddress, string memory name)
        public
        onlyOwner
    {
        challenges.push(
            Challenge(
                challengeIdCounter.current(),
                name,
                challengeAddress,
                false
            )
        );
        challengeIdCounter.increment();
    }

    uint256 private mockupTimestamp;

    function setMockupTimestamp(uint256 timestamp) public onlyOwner {
        mockupTimestamp = timestamp;
    }

    function getTimestamp() private view returns (uint256) {
        if (mockupTimestamp != 0) {
            return mockupTimestamp;
        }
        return block.timestamp;
    }

    function canClaimReward(address account) public view returns (bool) {
        //   return
        //     (rewards(account) >= MINIMUM_AMOUNT_CLAIM) &&
        //     (block.timestamp >= accountLastClaim[msg.sender] + 10 days);
        return
            (rewards(account) >= MINIMUM_AMOUNT_CLAIM) &&
            (getTimestamp() >= accountLastClaim[msg.sender] + 5 minutes);
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return 0;
        }
        return
            rewardPerTokenStored +
            (((getTimestamp() - lastUpdateTime) * rewardRate * 1e18) /
                _totalSupply);
    }

    function updateChallenge(
        uint256[] memory challengeBonus,
        uint256[] memory challengeIds
    ) private returns (uint256) {
        uint256 bonusBattlePower;
        for (uint256 index = 0; index < challengeBonus.length; index++) {
            if (userChallenge[msg.sender][challengeIds[index]]) {
                if (challengeBonus[index] == 0) {
                    userChallenge[msg.sender][challengeIds[index]] = false;
                }
            } else {
                if (challengeBonus[index] > 0) {
                    bonusBattlePower += challengeBonus[index];
                    userChallenge[msg.sender][challengeIds[index]] = true;
                }
            }
        }
        return bonusBattlePower;
    }

    function getContract(uint256 tokenId) internal view returns (address) {
        //Find NFT in account's wallet
        address ownerV1 = ERC721(NFTCoreV1).ownerOf(tokenId);
        address ownerV2 = ERC721(NFTCoreV2).ownerOf(tokenId);

        require(
            ownerV1 == msg.sender || ownerV2 == msg.sender,
            "You are not owner"
        );

        address nftCoreAddress;
        if (ownerV1 == msg.sender) {
            nftCoreAddress = NFTCoreV1;
        } else if (ownerV2 == msg.sender) {
            nftCoreAddress = NFTCoreV2;
        }

        return nftCoreAddress;
    }

    function joinWarrior(uint256 tokenId) public updateReward(msg.sender) {
        address nftCoreAddress = getContract(tokenId);

        //Transfer NFT to this contract
        ERC721(nftCoreAddress).transferFrom(msg.sender, address(this), tokenId);

        //Generate stakedId
        uint256 stakedId = stakedIdCounter.current();
        uint256 baseBattlePower;
        uint256 hp;
        uint256 def;
        uint256 atk;
        uint256 aspd;
        uint256 bonusBattlePower;
        uint256[] memory challengeBonus;
        uint256[] memory challengeIds;
        string memory name;

        (challengeBonus, challengeIds) = totalChallengeBonus(msg.sender);

        userNFTIds[msg.sender].push(stakedId);

        nftAccounts[tokenId] = msg.sender;

        (baseBattlePower, hp, def, atk, aspd, name) = calculateBattlePower(
            nftCoreAddress,
            tokenId
        );

        bonusBattlePower = updateChallenge(challengeBonus, challengeIds);

        stakedNFTs[stakedId] = StakedNFT(
            tokenId,
            nftCoreAddress,
            getTimestamp(),
            msg.sender,
            true,
            (baseBattlePower + bonusBattlePower),
            name,
            hp,
            def,
            atk,
            aspd
        );

        userStakedNFTCount[msg.sender] += 1;
        nftStakedNFTIds[tokenId] = stakedId;

        _totalSupply += (baseBattlePower + bonusBattlePower);
        _battlePowerBalances[msg.sender] += (baseBattlePower +
            bonusBattlePower);

        updateRank();
        stakedIdCounter.increment();
    }

    function updateRank() private {
        if (!userHasRank[msg.sender]) {
            userRankIds[msg.sender] = ranks.length;
            ranks.push(
                Rank(
                    msg.sender,
                    _battlePowerBalances[msg.sender],
                    userStakedNFTCount[msg.sender]
                )
            );
            userHasRank[msg.sender] = true;
        } else {
            uint256 rankId = userRankIds[msg.sender];
            ranks[rankId].totalBattlePower = _battlePowerBalances[msg.sender];
            ranks[rankId].amount = userStakedNFTCount[msg.sender];
        }
    }

    function getRank(address account) public view returns (uint256) {
        Rank[] memory results = new Rank[](ranks.length);
        for (uint256 index = 0; index < ranks.length; index++) {
            results[index] = ranks[index];
        }

        results = sort(results);

        for (uint256 index = 0; index < results.length; index++) {
            if (results[index].account == account) {
                return index + 1;
            }
        }
        return 0;
    }

    function getTopRanking(uint limit) public view returns (Rank[] memory) {
        Rank[] memory results = new Rank[](ranks.length);
        for (uint256 index = 0; index < ranks.length; index++) {
            results[index] = ranks[index];
        }

        results = sort(results);
        Rank[] memory top100 = new Rank[](limit);
        for (uint256 index = 0; index < results.length; index++) {
            
            if (index > limit-1) {
                break;
            }

            top100[index] = results[index];

           
        }

        return top100;
    }

    function sort(Rank[] memory data) private pure returns (Rank[] memory) {
        quickSort(data, int256(0), int256(data.length - 1));
        return data;
    }

    function quickSort(
        Rank[] memory arr,
        int256 left,
        int256 right
    ) private pure {
        int256 i = left;
        int256 j = right;
        if (i == j) return;
        Rank memory pivot = arr[uint256(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint256(i)].totalBattlePower > pivot.totalBattlePower)
                i++;
            while (pivot.totalBattlePower > arr[uint256(j)].totalBattlePower)
                j--;
            if (i <= j) {
                (arr[uint256(i)], arr[uint256(j)]) = (
                    arr[uint256(j)],
                    arr[uint256(i)]
                );
                i++;
                j--;
            }
        }
        if (left < j) quickSort(arr, left, j);
        if (i < right) quickSort(arr, i, right);
    }

    function joinAllWarrior(uint256[] memory tokenIds) public {
        for (uint256 index = 0; index < tokenIds.length; index++) {
            address ownerV1 = ERC721(NFTCoreV1).ownerOf(tokenIds[index]);
            address ownerV2 = ERC721(NFTCoreV2).ownerOf(tokenIds[index]);
            require(
                ownerV1 == msg.sender || ownerV2 == msg.sender,
                "You are not owner."
            );
            joinWarrior(tokenIds[index]);
        }
    }

    function unJoinAllWarrior() public {
        StakedNFT[] memory NFTs = getMyStakedNFTs(msg.sender);
        for (uint256 index = 0; index < NFTs.length; index++) {
            unJoinWarrior(NFTs[index].tokenId);
        }
    }

    function unJoinWarrior(uint256 tokenId) public updateReward(msg.sender) {
        require(nftAccounts[tokenId] == msg.sender, "You are not nft owner.");

        uint256 stakedNFTId = nftStakedNFTIds[tokenId];

        StakedNFT memory stakedNFT = stakedNFTs[stakedNFTId];

        require(stakedNFT.isStaked, "The NFT Not found");

        ERC721(stakedNFT.contractAddress).transferFrom(
            address(this),
            msg.sender,
            tokenId
        );

        uint256 battlePower = stakedNFT.battlePower;

        _totalSupply -= battlePower;
        _battlePowerBalances[msg.sender] -= battlePower;

        stakedNFTs[stakedNFTId].isStaked = false;

        nftAccounts[tokenId] = address(0);

        userStakedNFTCount[msg.sender] -= 1;

        uint256 rankId = userRankIds[msg.sender];
        ranks[rankId].totalBattlePower = _battlePowerBalances[msg.sender];
        ranks[rankId].amount = userStakedNFTCount[msg.sender];
    }

    // function withdraw(uint256 _amount) external updateReward(msg.sender) {
    //     _totalSupply -= _amount;
    //     _battlePowerBalances[msg.sender] -= _amount;
    //     rewardsTokenContract.transfer(msg.sender, _amount);
    // }

    function claimReward() external payable updateReward(msg.sender) {
        require(canClaimReward(msg.sender), "Can't claim");

        require(msg.value == stakingFee);

        totalFee += msg.value;

        uint256 reward = tokenRewards[msg.sender];
        tokenRewards[msg.sender] = 0;
        rewardsTokenContract.transfer(msg.sender, reward);

        accountLastClaim[msg.sender] = getTimestamp();
    }

    function calculateBattlePower(address contractAddress, uint256 tokenId)
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            string memory
        )
    {
        string memory partCode;
        uint256 id;
        (partCode, id) = ECIOERC721(contractAddress).tokenInfo(tokenId);
        string[] memory splittedPartCodes = splitPartCode(partCode);
        string memory headCode = splittedPartCodes[PC_GENOME];
        string memory name = headContract.getStrValue(headCode, NAME);
        uint256 hp = calculateHP(splittedPartCodes);
        uint256 def = calculateDef(splittedPartCodes);
        uint256 atk = calculateAtk(splittedPartCodes);
        uint256 aspd = calculateAspd(splittedPartCodes);

        return (
            hp + ((atk / aspd) * (10 * 1e18)) + (def * 15),
            hp,
            def,
            atk,
            aspd,
            name
        );
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

        return
            (((headContract.getValue(headCode, HP) *
                battleWeaponContract.getValue(weaponCode, BONUS_HP) *
                battleSuiteContract.getValue(suiteCode, BONUS_HP) *
                campContract.getValue(campCode, BONUS_HP) *
                battleGearContract.getValue(gearCode, BONUS_HP) *
                battleDroneContract.getValue(droneCode, BONUS_HP) *
                battleBotContract.getValue(botCode, BONUS_HP)) / (10000**5)) *
                1e18) / (10000**2);
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

        return
            (((battleSuiteContract.getValue(suiteCode, DEF) *
                (headContract.getValue(headCode, BONUS_DEF) *
                    battleWeaponContract.getValue(weaponCode, BONUS_DEF) *
                    battleSuiteContract.getValue(suiteCode, BONUS_DEF) *
                    campContract.getValue(campCode, BONUS_DEF) *
                    battleGearContract.getValue(gearCode, BONUS_DEF) *
                    battleDroneContract.getValue(droneCode, BONUS_DEF) *
                    battleBotContract.getValue(botCode, BONUS_DEF))) /
                (10000**6)) * 1e18) / (10000**2);
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

        return
            (((battleWeaponContract.getValue(weaponCode, ATK) *
                (headContract.getValue(headCode, BONUS_ATK) *
                    battleSuiteContract.getValue(suiteCode, BONUS_ATK) *
                    campContract.getValue(campCode, BONUS_ATK) *
                    battleGearContract.getValue(gearCode, BONUS_ATK) *
                    battleDroneContract.getValue(droneCode, BONUS_ATK) *
                    battleBotContract.getValue(botCode, BONUS_ATK))) /
                (10000**5)) * 1e18) / (10000**2);
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

        return
            (battleWeaponContract.getValue(weaponCode, ASPD) * 1e18) /
            ((headContract.getValue(headCode, BONUS_ASPD) *
                battleWeaponContract.getValue(weaponCode, BONUS_ASPD) *
                battleSuiteContract.getValue(suiteCode, BONUS_ASPD) *
                campContract.getValue(campCode, BONUS_ASPD) *
                battleGearContract.getValue(gearCode, BONUS_ASPD) *
                battleDroneContract.getValue(droneCode, BONUS_ASPD) *
                battleBotContract.getValue(botCode, BONUS_ASPD)) / (10000**6));
    }

    function getChallenges() public view returns (Challenge[] memory) {
        return challenges;
    }

    function checkChallenge(address account, uint256 challengeId)
        public
        view
        returns (uint256, uint256)
    {
        StakedNFT[] memory NFTs = getMyStakedNFTs(account);

        uint256[] memory tokenIds = new uint256[](NFTs.length);
        address[] memory contracts = new address[](NFTs.length);

        for (uint256 index = 0; index < NFTs.length; index++) {
            tokenIds[index] = NFTs[index].tokenId;
            contracts[index] = NFTs[index].contractAddress;
        }

        uint256 amount;
        uint256 from;
        (amount, from) = ChallengeBonus(
            challenges[challengeId].challengeAddress
        ).staked(contracts, tokenIds);

        return (amount, from);
    }

    function totalChallengeBonus(address account)
        public
        view
        returns (uint256[] memory, uint256[] memory)
    {
        StakedNFT[] memory NFTs = getMyStakedNFTs(account);

        uint256[] memory tokenIds = new uint256[](NFTs.length);
        address[] memory contracts = new address[](NFTs.length);
        uint256[] memory challengeBonus = new uint256[](challenges.length);
        uint256[] memory challengeIds = new uint256[](challenges.length);

        for (uint256 index = 0; index < NFTs.length; index++) {
            tokenIds[index] = NFTs[index].tokenId;
            contracts[index] = NFTs[index].contractAddress;
        }

        for (uint256 index = 0; index < challenges.length; index++) {
            Challenge memory challenge = challenges[index];

            if (!challenge.isDisabled) {
                challengeBonus[index] = ChallengeBonus(
                    challenge.challengeAddress
                ).bonus(account, contracts, tokenIds);
                challengeIds[index] = challenge.challengeId;
            }
        }

        return (challengeBonus, challengeIds);
    }

    //View
    function getMyStakedNFTs(address account)
        public
        view
        returns (StakedNFT[] memory)
    {
        StakedNFT[] memory results = new StakedNFT[](
            userStakedNFTCount[account]
        );
        uint256 count = 0;
        for (uint256 index = 0; index < userNFTIds[account].length; index++) {
            StakedNFT memory stakedNFT = stakedNFTs[userNFTIds[account][index]];
            if (stakedNFT.isStaked) {
                results[count] = stakedNFT;
                count++;
            }
        }

        return results;
    }

    function getTotalBattlePower(address account)
        public
        view
        returns (uint256)
    {
        uint256 battlePower = 0;
        for (uint256 index = 0; index < userNFTIds[account].length; index++) {
            StakedNFT memory stakedNFT = stakedNFTs[userNFTIds[account][index]];

            if (stakedNFT.isStaked) {
                //Calculate staked NFT.
                uint256 _battlePower;
                (_battlePower, , , , ,) = calculateBattlePower(
                    stakedNFT.contractAddress,
                    stakedNFT.tokenId
                );

                battlePower += _battlePower;
            }
        }

        return battlePower;
    }

    //Staking Functions
    function rewards(address account) public view returns (uint256) {
        if (_battlePowerBalances[account] == 0) {
            return tokenRewards[account];
        }

        return
            ((_battlePowerBalances[account] *
                (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) +
            tokenRewards[account];
    }

    function battlePowerBalances(address account)
        public
        view
        returns (uint256)
    {
        return _battlePowerBalances[account];
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = getTimestamp();
        tokenRewards[account] = rewards(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }
}
