//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BattleBot {
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
        info["SB00"][HP] = 0;
        info["SB00"][ATK] = 0;
        info["SB00"][DEF] = 0;
        info["SB00"][ASPD] = 0;
        info["SB00"][RANGE] = 0;
        info["SB00"][BONUS_HP] = 10000;
        info["SB00"][BONUS_ATK] = 10000;
        info["SB00"][BONUS_DEF] = 10000;
        info["SB00"][BONUS_ASPD] = 10000;
        info["SB00"][CRIT] = 0;
        info["SB00"][DODGE] = 0;
        info["SB00"][LIFESTEAL] = 0;
        infoStr["SB00"][NAME] = "None";

        info["SB01"][HP] = 0;
        info["SB01"][ATK] = 0;
        info["SB01"][DEF] = 0;
        info["SB01"][ASPD] = 0;
        info["SB01"][RANGE] = 0;
        info["SB01"][BONUS_HP] = 10000;
        info["SB01"][BONUS_ATK] = 10000;
        info["SB01"][BONUS_DEF] = 10000;
        info["SB01"][BONUS_ASPD] = 10000;
        info["SB01"][CRIT] = 0;
        info["SB01"][DODGE] = 0;
        info["SB01"][LIFESTEAL] = 0;
        infoStr["SB01"][NAME] = "Achemist";

        info["SB02"][HP] = 0;
        info["SB02"][ATK] = 0;
        info["SB02"][DEF] = 0;
        info["SB02"][ASPD] = 0;
        info["SB02"][RANGE] = 0;
        info["SB02"][BONUS_HP] = 10000;
        info["SB02"][BONUS_ATK] = 10000;
        info["SB02"][BONUS_DEF] = 10000;
        info["SB02"][BONUS_ASPD] = 10000;
        info["SB02"][CRIT] = 0;
        info["SB02"][DODGE] = 0;
        info["SB02"][LIFESTEAL] = 0;
        infoStr["SB02"][NAME] = "Ammonitor";

        info["SB03"][HP] = 0;
        info["SB03"][ATK] = 0;
        info["SB03"][DEF] = 0;
        info["SB03"][ASPD] = 0;
        info["SB03"][RANGE] = 0;
        info["SB03"][BONUS_HP] = 10000;
        info["SB03"][BONUS_ATK] = 10000;
        info["SB03"][BONUS_DEF] = 10000;
        info["SB03"][BONUS_ASPD] = 10000;
        info["SB03"][CRIT] = 0;
        info["SB03"][DODGE] = 0;
        info["SB03"][LIFESTEAL] = 0;
        infoStr["SB03"][NAME] = "Cheetah";

        info["SB04"][HP] = 0;
        info["SB04"][ATK] = 0;
        info["SB04"][DEF] = 0;
        info["SB04"][ASPD] = 0;
        info["SB04"][RANGE] = 0;
        info["SB04"][BONUS_HP] = 10000;
        info["SB04"][BONUS_ATK] = 10000;
        info["SB04"][BONUS_DEF] = 10000;
        info["SB04"][BONUS_ASPD] = 10000;
        info["SB04"][CRIT] = 0;
        info["SB04"][DODGE] = 0;
        info["SB04"][LIFESTEAL] = 0;
        infoStr["SB04"][NAME] = "Mecha Turtle";

        info["SB05"][HP] = 0;
        info["SB05"][ATK] = 0;
        info["SB05"][DEF] = 0;
        info["SB05"][ASPD] = 0;
        info["SB05"][RANGE] = 0;
        info["SB05"][BONUS_HP] = 10000;
        info["SB05"][BONUS_ATK] = 10000;
        info["SB05"][BONUS_DEF] = 10000;
        info["SB05"][BONUS_ASPD] = 10000;
        info["SB05"][CRIT] = 0;
        info["SB05"][DODGE] = 0;
        info["SB05"][LIFESTEAL] = 0;
        infoStr["SB05"][NAME] = "Killer Shark";

        info["SB06"][HP] = 0;
        info["SB06"][ATK] = 0;
        info["SB06"][DEF] = 0;
        info["SB06"][ASPD] = 0;
        info["SB06"][RANGE] = 0;
        info["SB06"][BONUS_HP] = 10000;
        info["SB06"][BONUS_ATK] = 10000;
        info["SB06"][BONUS_DEF] = 10000;
        info["SB06"][BONUS_ASPD] = 10000;
        info["SB06"][CRIT] = 0;
        info["SB06"][DODGE] = 0;
        info["SB06"][LIFESTEAL] = 0;
        infoStr["SB06"][NAME] = "Magneto";

        info["SB07"][HP] = 0;
        info["SB07"][ATK] = 0;
        info["SB07"][DEF] = 0;
        info["SB07"][ASPD] = 0;
        info["SB07"][RANGE] = 0;
        info["SB07"][BONUS_HP] = 10000;
        info["SB07"][BONUS_ATK] = 10000;
        info["SB07"][BONUS_DEF] = 10000;
        info["SB07"][BONUS_ASPD] = 10000;
        info["SB07"][CRIT] = 0;
        info["SB07"][DODGE] = 0;
        info["SB07"][LIFESTEAL] = 0;
        infoStr["SB07"][NAME] = "Robomed";

        info["SB08"][HP] = 0;
        info["SB08"][ATK] = 0;
        info["SB08"][DEF] = 0;
        info["SB08"][ASPD] = 0;
        info["SB08"][RANGE] = 0;
        info["SB08"][BONUS_HP] = 10000;
        info["SB08"][BONUS_ATK] = 10000;
        info["SB08"][BONUS_DEF] = 10000;
        info["SB08"][BONUS_ASPD] = 10000;
        info["SB08"][CRIT] = 0;
        info["SB08"][DODGE] = 0;
        info["SB08"][LIFESTEAL] = 0;
        infoStr["SB08"][NAME] = "Gammanite";

        info["SB09"][HP] = 0;
        info["SB09"][ATK] = 0;
        info["SB09"][DEF] = 0;
        info["SB09"][ASPD] = 0;
        info["SB09"][RANGE] = 0;
        info["SB09"][BONUS_HP] = 10000;
        info["SB09"][BONUS_ATK] = 10000;
        info["SB09"][BONUS_DEF] = 10000;
        info["SB09"][BONUS_ASPD] = 10000;
        info["SB09"][CRIT] = 0;
        info["SB09"][DODGE] = 0;
        info["SB09"][LIFESTEAL] = 0;
        infoStr["SB09"][NAME] = "Scopinion";

        info["SB10"][HP] = 0;
        info["SB10"][ATK] = 0;
        info["SB10"][DEF] = 0;
        info["SB10"][ASPD] = 0;
        info["SB10"][RANGE] = 0;
        info["SB10"][BONUS_HP] = 10000;
        info["SB10"][BONUS_ATK] = 10000;
        info["SB10"][BONUS_DEF] = 10000;
        info["SB10"][BONUS_ASPD] = 10000;
        info["SB10"][CRIT] = 0;
        info["SB10"][DODGE] = 0;
        info["SB10"][LIFESTEAL] = 0;
        infoStr["SB10"][NAME] = "Tesla Core";

        info["SB11"][HP] = 0;
        info["SB11"][ATK] = 0;
        info["SB11"][DEF] = 0;
        info["SB11"][ASPD] = 0;
        info["SB11"][RANGE] = 0;
        info["SB11"][BONUS_HP] = 10000;
        info["SB11"][BONUS_ATK] = 10000;
        info["SB11"][BONUS_DEF] = 10000;
        info["SB11"][BONUS_ASPD] = 10000;
        info["SB11"][CRIT] = 0;
        info["SB11"][DODGE] = 0;
        info["SB11"][LIFESTEAL] = 0;
        infoStr["SB11"][NAME] = "Mysterious Mind";

        info["SB12"][HP] = 0;
        info["SB12"][ATK] = 0;
        info["SB12"][DEF] = 0;
        info["SB12"][ASPD] = 0;
        info["SB12"][RANGE] = 0;
        info["SB12"][BONUS_HP] = 10000;
        info["SB12"][BONUS_ATK] = 10000;
        info["SB12"][BONUS_DEF] = 10000;
        info["SB12"][BONUS_ASPD] = 10000;
        info["SB12"][CRIT] = 0;
        info["SB12"][DODGE] = 0;
        info["SB12"][LIFESTEAL] = 0;
        infoStr["SB12"][NAME] = "Shiba Bot";
    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SB", codeNumber))][attributeId];
    }

    function getStrValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (string memory)
    {
        return infoStr[string(abi.encodePacked("SB", codeNumber))][attributeId];
    }
}
