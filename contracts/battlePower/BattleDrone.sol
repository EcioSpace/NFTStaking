//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BattleDrone {


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

    mapping(string => mapping(uint256 => uint256)) info;
    mapping(string => mapping(uint256 => string)) infoStr;

 function initialize() public {
       
            info["SD00"][HP] = 0;
            info["SD00"][ATK] = 0;
            info["SD00"][DEF] = 0;
            info["SD00"][ASPD] = 0;
            info["SD00"][RANGE] = 0;
            info["SD00"][BONUS_HP] = 10000;
            info["SD00"][BONUS_ATK] = 10000;
            info["SD00"][BONUS_DEF] = 10000;
            info["SD00"][BONUS_ASPD] = 10000;
            info["SD00"][CRIT] = 0;
            info["SD00"][DODGE] = 0;
            info["SD00"][LIFESTEAL] = 0;
            infoStr["SD00"][NAME] = "None";

            info["SD01"][HP] = 0;
            info["SD01"][ATK] = 0;
            info["SD01"][DEF] = 0;
            info["SD01"][ASPD] = 0;
            info["SD01"][RANGE] = 0;
            info["SD01"][BONUS_HP] = 10000;
            info["SD01"][BONUS_ATK] = 10000;
            info["SD01"][BONUS_DEF] = 10000;
            info["SD01"][BONUS_ASPD] = 10000;
            info["SD01"][CRIT] = 0;
            info["SD01"][DODGE] = 0;
            info["SD01"][LIFESTEAL] = 0;
            infoStr["SD01"][NAME] = "Paradin";

            info["SD02"][HP] = 0;
            info["SD02"][ATK] = 0;
            info["SD02"][DEF] = 0;
            info["SD02"][ASPD] = 0;
            info["SD02"][RANGE] = 0;
            info["SD02"][BONUS_HP] = 10000;
            info["SD02"][BONUS_ATK] = 10000;
            info["SD02"][BONUS_DEF] = 10000;
            info["SD02"][BONUS_ASPD] = 10000;
            info["SD02"][CRIT] = 0;
            info["SD02"][DODGE] = 0;
            info["SD02"][LIFESTEAL] = 0;
            infoStr["SD02"][NAME] = "Guardian";

            info["SD03"][HP] = 0;
            info["SD03"][ATK] = 0;
            info["SD03"][DEF] = 0;
            info["SD03"][ASPD] = 0;
            info["SD03"][RANGE] = 0;
            info["SD03"][BONUS_HP] = 10000;
            info["SD03"][BONUS_ATK] = 10000;
            info["SD03"][BONUS_DEF] = 10000;
            info["SD03"][BONUS_ASPD] = 10000;
            info["SD03"][CRIT] = 0;
            info["SD03"][DODGE] = 0;
            info["SD03"][LIFESTEAL] = 0;
            infoStr["SD03"][NAME] = "Laser Eye";

            info["SD04"][HP] = 0;
            info["SD04"][ATK] = 0;
            info["SD04"][DEF] = 0;
            info["SD04"][ASPD] = 0;
            info["SD04"][RANGE] = 0;
            info["SD04"][BONUS_HP] = 10000;
            info["SD04"][BONUS_ATK] = 10000;
            info["SD04"][BONUS_DEF] = 10000;
            info["SD04"][BONUS_ASPD] = 10000;
            info["SD04"][CRIT] = 0;
            info["SD04"][DODGE] = 0;
            info["SD04"][LIFESTEAL] = 0;
            infoStr["SD04"][NAME] = "Firefly";

            info["SD05"][HP] = 0;
            info["SD05"][ATK] = 0;
            info["SD05"][DEF] = 0;
            info["SD05"][ASPD] = 0;
            info["SD05"][RANGE] = 0;
            info["SD05"][BONUS_HP] = 10000;
            info["SD05"][BONUS_ATK] = 10000;
            info["SD05"][BONUS_DEF] = 10000;
            info["SD05"][BONUS_ASPD] = 10000;
            info["SD05"][CRIT] = 0;
            info["SD05"][DODGE] = 0;
            info["SD05"][LIFESTEAL] = 0;
            infoStr["SD05"][NAME] = "Blazer";

            info["SD06"][HP] = 0;
            info["SD06"][ATK] = 0;
            info["SD06"][DEF] = 0;
            info["SD06"][ASPD] = 0;
            info["SD06"][RANGE] = 0;
            info["SD06"][BONUS_HP] = 10000;
            info["SD06"][BONUS_ATK] = 10000;
            info["SD06"][BONUS_DEF] = 10000;
            info["SD06"][BONUS_ASPD] = 10000;
            info["SD06"][CRIT] = 0;
            info["SD06"][DODGE] = 0;
            info["SD06"][LIFESTEAL] = 0;
            infoStr["SD06"][NAME] = "Speeder";

            info["SD07"][HP] = 0;
            info["SD07"][ATK] = 0;
            info["SD07"][DEF] = 0;
            info["SD07"][ASPD] = 0;
            info["SD07"][RANGE] = 0;
            info["SD07"][BONUS_HP] = 10000;
            info["SD07"][BONUS_ATK] = 10000;
            info["SD07"][BONUS_DEF] = 10000;
            info["SD07"][BONUS_ASPD] = 10000;
            info["SD07"][CRIT] = 0;
            info["SD07"][DODGE] = 0;
            info["SD07"][LIFESTEAL] = 0;
            infoStr["SD07"][NAME] = "Medicon";

            info["SD08"][HP] = 0;
            info["SD08"][ATK] = 0;
            info["SD08"][DEF] = 0;
            info["SD08"][ASPD] = 0;
            info["SD08"][RANGE] = 0;
            info["SD08"][BONUS_HP] = 10000;
            info["SD08"][BONUS_ATK] = 10000;
            info["SD08"][BONUS_DEF] = 10000;
            info["SD08"][BONUS_ASPD] = 10000;
            info["SD08"][CRIT] = 0;
            info["SD08"][DODGE] = 0;
            info["SD08"][LIFESTEAL] = 0;
            infoStr["SD08"][NAME] = "Stinger";

            info["SD09"][HP] = 0;
            info["SD09"][ATK] = 0;
            info["SD09"][DEF] = 0;
            info["SD09"][ASPD] = 0;
            info["SD09"][RANGE] = 0;
            info["SD09"][BONUS_HP] = 10000;
            info["SD09"][BONUS_ATK] = 10000;
            info["SD09"][BONUS_DEF] = 10000;
            info["SD09"][BONUS_ASPD] = 10000;
            info["SD09"][CRIT] = 0;
            info["SD09"][DODGE] = 0;
            info["SD09"][LIFESTEAL] = 0;
            infoStr["SD09"][NAME] = "Electro Striker";

            info["SD10"][HP] = 0;
            info["SD10"][ATK] = 0;
            info["SD10"][DEF] = 0;
            info["SD10"][ASPD] = 0;
            info["SD10"][RANGE] = 0;
            info["SD10"][BONUS_HP] = 10000;
            info["SD10"][BONUS_ATK] = 10000;
            info["SD10"][BONUS_DEF] = 10000;
            info["SD10"][BONUS_ASPD] = 10000;
            info["SD10"][CRIT] = 0;
            info["SD10"][DODGE] = 0;
            info["SD10"][LIFESTEAL] = 0;
            infoStr["SD10"][NAME] = "Bomber";

            info["SD11"][HP] = 0;
            info["SD11"][ATK] = 0;
            info["SD11"][DEF] = 0;
            info["SD11"][ASPD] = 0;
            info["SD11"][RANGE] = 0;
            info["SD11"][BONUS_HP] = 10000;
            info["SD11"][BONUS_ATK] = 10000;
            info["SD11"][BONUS_DEF] = 10000;
            info["SD11"][BONUS_ASPD] = 10000;
            info["SD11"][CRIT] = 0;
            info["SD11"][DODGE] = 0;
            info["SD11"][LIFESTEAL] = 0;
            infoStr["SD11"][NAME] = "Almighty Guard";

            info["SD12"][HP] = 0;
            info["SD12"][ATK] = 0;
            info["SD12"][DEF] = 0;
            info["SD12"][ASPD] = 0;
            info["SD12"][RANGE] = 0;
            info["SD12"][BONUS_HP] = 10000;
            info["SD12"][BONUS_ATK] = 10000;
            info["SD12"][BONUS_DEF] = 10000;
            info["SD12"][BONUS_ASPD] = 10000;
            info["SD12"][CRIT] = 0;
            info["SD12"][DODGE] = 0;
            info["SD12"][LIFESTEAL] = 0;
            infoStr["SD12"][NAME] = "Mysterious Mind B";


    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SD", codeNumber))][attributeId];
    }
    function getStrValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (string memory)
    {
        return infoStr[string(abi.encodePacked("SD", codeNumber))][attributeId];
    }
}