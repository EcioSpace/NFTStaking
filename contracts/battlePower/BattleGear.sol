//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BattleGear {


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

    mapping(string => mapping(uint256 => uint256)) info;
 
 function initialize() public {
        
                 
            info["SG00"][HP] = 0;
            info["SG00"][ATK] = 0;
            info["SG00"][DEF] = 0;
            info["SG00"][ASPD] = 0;
            info["SG00"][RANGE] = 0;
            info["SG00"][BONUS_HP] = 10000;
            info["SG00"][BONUS_ATK] = 10000;
            info["SG00"][BONUS_DEF] = 10000;
            info["SG00"][BONUS_ASPD] = 10000;
            info["SG00"][CRIT] = 0;
            info["SG00"][DODGE] = 0;
            info["SG00"][LIFESTEAL] = 0;
         
            info["SG01"][HP] = 0;
            info["SG01"][ATK] = 0;
            info["SG01"][DEF] = 0;
            info["SG01"][ASPD] = 0;
            info["SG01"][RANGE] = 0;
            info["SG01"][BONUS_HP] = 10000;
            info["SG01"][BONUS_ATK] = 10000;
            info["SG01"][BONUS_DEF] = 10000;
            info["SG01"][BONUS_ASPD] = 10000;
            info["SG01"][CRIT] = 0;
            info["SG01"][DODGE] = 0;
            info["SG01"][LIFESTEAL] = 0;

            info["SG02"][HP] = 0;
            info["SG02"][ATK] = 0;
            info["SG02"][DEF] = 0;
            info["SG02"][ASPD] = 0;
            info["SG02"][RANGE] = 0;
            info["SG02"][BONUS_HP] = 10000;
            info["SG02"][BONUS_ATK] = 10000;
            info["SG02"][BONUS_DEF] = 10000;
            info["SG02"][BONUS_ASPD] = 10000;
            info["SG02"][CRIT] = 0;
            info["SG02"][DODGE] = 0;
            info["SG02"][LIFESTEAL] = 0;

            info["SG03"][HP] = 0;
            info["SG03"][ATK] = 0;
            info["SG03"][DEF] = 0;
            info["SG03"][ASPD] = 0;
            info["SG03"][RANGE] = 0;
            info["SG03"][BONUS_HP] = 10000;
            info["SG03"][BONUS_ATK] = 10000;
            info["SG03"][BONUS_DEF] = 10000;
            info["SG03"][BONUS_ASPD] = 10000;
            info["SG03"][CRIT] = 0;
            info["SG03"][DODGE] = 0;
            info["SG03"][LIFESTEAL] = 0;

            info["SG04"][HP] = 0;
            info["SG04"][ATK] = 0;
            info["SG04"][DEF] = 0;
            info["SG04"][ASPD] = 0;
            info["SG04"][RANGE] = 0;
            info["SG04"][BONUS_HP] = 10000;
            info["SG04"][BONUS_ATK] = 10000;
            info["SG04"][BONUS_DEF] = 10000;
            info["SG04"][BONUS_ASPD] = 10000;
            info["SG04"][CRIT] = 0;
            info["SG04"][DODGE] = 0;
            info["SG04"][LIFESTEAL] = 0;

            info["SG05"][HP] = 0;
            info["SG05"][ATK] = 0;
            info["SG05"][DEF] = 0;
            info["SG05"][ASPD] = 0;
            info["SG05"][RANGE] = 0;
            info["SG05"][BONUS_HP] = 10000;
            info["SG05"][BONUS_ATK] = 10000;
            info["SG05"][BONUS_DEF] = 10000;
            info["SG05"][BONUS_ASPD] = 10000;
            info["SG05"][CRIT] = 0;
            info["SG05"][DODGE] = 0;
            info["SG05"][LIFESTEAL] = 0;

            info["SG06"][HP] = 0;
            info["SG06"][ATK] = 0;
            info["SG06"][DEF] = 0;
            info["SG06"][ASPD] = 0;
            info["SG06"][RANGE] = 0;
            info["SG06"][BONUS_HP] = 10000;
            info["SG06"][BONUS_ATK] = 10000;
            info["SG06"][BONUS_DEF] = 10000;
            info["SG06"][BONUS_ASPD] = 10000;
            info["SG06"][CRIT] = 0;
            info["SG06"][DODGE] = 0;
            info["SG06"][LIFESTEAL] = 0;

            info["SG07"][HP] = 0;
            info["SG07"][ATK] = 0;
            info["SG07"][DEF] = 0;
            info["SG07"][ASPD] = 0;
            info["SG07"][RANGE] = 0;
            info["SG07"][BONUS_HP] = 10000;
            info["SG07"][BONUS_ATK] = 10000;
            info["SG07"][BONUS_DEF] = 10000;
            info["SG07"][BONUS_ASPD] = 10000;
            info["SG07"][CRIT] = 0;
            info["SG07"][DODGE] = 0;
            info["SG07"][LIFESTEAL] = 0;

            info["SG08"][HP] = 0;
            info["SG08"][ATK] = 0;
            info["SG08"][DEF] = 0;
            info["SG08"][ASPD] = 0;
            info["SG08"][RANGE] = 0;
            info["SG08"][BONUS_HP] = 10000;
            info["SG08"][BONUS_ATK] = 10000;
            info["SG08"][BONUS_DEF] = 10000;
            info["SG08"][BONUS_ASPD] = 10000;
            info["SG08"][CRIT] = 0;
            info["SG08"][DODGE] = 0;
            info["SG08"][LIFESTEAL] = 0;

            info["SG09"][HP] = 0;
            info["SG09"][ATK] = 0;
            info["SG09"][DEF] = 0;
            info["SG09"][ASPD] = 0;
            info["SG09"][RANGE] = 0;
            info["SG09"][BONUS_HP] = 10000;
            info["SG09"][BONUS_ATK] = 10000;
            info["SG09"][BONUS_DEF] = 10000;
            info["SG09"][BONUS_ASPD] = 10000;
            info["SG09"][CRIT] = 0;
            info["SG09"][DODGE] = 0;
            info["SG09"][LIFESTEAL] = 0;

            info["SG10"][HP] = 0;
            info["SG10"][ATK] = 0;
            info["SG10"][DEF] = 0;
            info["SG10"][ASPD] = 0;
            info["SG10"][RANGE] = 0;
            info["SG10"][BONUS_HP] = 10000;
            info["SG10"][BONUS_ATK] = 10000;
            info["SG10"][BONUS_DEF] = 10000;
            info["SG10"][BONUS_ASPD] = 10000;
            info["SG10"][CRIT] = 0;
            info["SG10"][DODGE] = 0;
            info["SG10"][LIFESTEAL] = 0;

            info["SG11"][HP] = 0;
            info["SG11"][ATK] = 0;
            info["SG11"][DEF] = 0;
            info["SG11"][ASPD] = 0;
            info["SG11"][RANGE] = 0;
            info["SG11"][BONUS_HP] = 10000;
            info["SG11"][BONUS_ATK] = 10000;
            info["SG11"][BONUS_DEF] = 10000;
            info["SG11"][BONUS_ASPD] = 10000;
            info["SG11"][CRIT] = 0;
            info["SG11"][DODGE] = 0;
            info["SG11"][LIFESTEAL] = 0;

            info["SG12"][HP] = 0;
            info["SG12"][ATK] = 0;
            info["SG12"][DEF] = 0;
            info["SG12"][ASPD] = 0;
            info["SG12"][RANGE] = 0;
            info["SG12"][BONUS_HP] = 10000;
            info["SG12"][BONUS_ATK] = 10000;
            info["SG12"][BONUS_DEF] = 10000;
            info["SG12"][BONUS_ASPD] = 10000;
            info["SG12"][CRIT] = 0;
            info["SG12"][DODGE] = 0;
            info["SG12"][LIFESTEAL] = 0;


    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SG", codeNumber))][attributeId];
    }
}