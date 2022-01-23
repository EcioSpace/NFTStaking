//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract SpaceCamp {

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
         
            
            info["SC00"][HP] = 0;
            info["SC00"][ATK] = 0;
            info["SC00"][DEF] = 0;
            info["SC00"][ASPD] = 0;
            info["SC00"][RANGE] = 0;
            info["SC00"][BONUS_HP] = 11000;
            info["SC00"][BONUS_ATK] = 10000;
            info["SC00"][BONUS_DEF] = 11000;
            info["SC00"][BONUS_ASPD] = 10000;
            info["SC00"][CRIT] = 0;
            info["SC00"][DODGE] = 0;
            info["SC00"][LIFESTEAL] = 0;
            infoStr["SC00"][NAME] = "Red Desert";

            info["SC01"][HP] = 0;
            info["SC01"][ATK] = 0;
            info["SC01"][DEF] = 0;
            info["SC01"][ASPD] = 0;
            info["SC01"][RANGE] = 0;
            info["SC01"][BONUS_HP] = 10000;
            info["SC01"][BONUS_ATK] = 10000;
            info["SC01"][BONUS_DEF] = 10000;
            info["SC01"][BONUS_ASPD] = 11000;
            info["SC01"][CRIT] = 0;
            info["SC01"][DODGE] = 500;
            info["SC01"][LIFESTEAL] = 0;
            infoStr["SC01"][NAME] = "Grand Valley";

            info["SC02"][HP] = 0;
            info["SC02"][ATK] = 0;
            info["SC02"][DEF] = 0;
            info["SC02"][ASPD] = 0;
            info["SC02"][RANGE] = 0;
            info["SC02"][BONUS_HP] = 10000;
            info["SC02"][BONUS_ATK] = 11000;
            info["SC02"][BONUS_DEF] = 10000;
            info["SC02"][BONUS_ASPD] = 11000;
            info["SC02"][CRIT] = 0;
            info["SC02"][DODGE] = 0;
            info["SC02"][LIFESTEAL] = 0;
            infoStr["SC02"][NAME] = "Death City";

            info["SC03"][HP] = 0;
            info["SC03"][ATK] = 0;
            info["SC03"][DEF] = 0;
            info["SC03"][ASPD] = 0;
            info["SC03"][RANGE] = 0;
            info["SC03"][BONUS_HP] = 10000;
            info["SC03"][BONUS_ATK] = 10000;
            info["SC03"][BONUS_DEF] = 10000;
            info["SC03"][BONUS_ASPD] = 10000;
            info["SC03"][CRIT] = 0;
            info["SC03"][DODGE] = 0;
            info["SC03"][LIFESTEAL] = 1000;
            infoStr["SC03"][NAME] = "Dark Europa";

            info["SC04"][HP] = 0;
            info["SC04"][ATK] = 0;
            info["SC04"][DEF] = 0;
            info["SC04"][ASPD] = 0;
            info["SC04"][RANGE] = 0;
            info["SC04"][BONUS_HP] = 10000;
            info["SC04"][BONUS_ATK] = 10000;
            info["SC04"][BONUS_DEF] = 10000;
            info["SC04"][BONUS_ASPD] = 10000;
            info["SC04"][CRIT] = 1000;
            info["SC04"][DODGE] = 0;
            info["SC04"][LIFESTEAL] = 0;
            infoStr["SC04"][NAME] = "Doom Mountain";

            info["SC05"][HP] = 0;
            info["SC05"][ATK] = 0;
            info["SC05"][DEF] = 0;
            info["SC05"][ASPD] = 0;
            info["SC05"][RANGE] = 0;
            info["SC05"][BONUS_HP] = 10000;
            info["SC05"][BONUS_ATK] = 10000;
            info["SC05"][BONUS_DEF] = 10000;
            info["SC05"][BONUS_ASPD] = 10000;
            info["SC05"][CRIT] = 0;
            info["SC05"][DODGE] = 0;
            info["SC05"][LIFESTEAL] = 0;
            infoStr["SC05"][NAME] = "North pole";


    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SC", codeNumber))][attributeId];
    }
        function getStrValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (string memory)
    {
        return infoStr[string(abi.encodePacked("SC", codeNumber))][attributeId];
    }

}