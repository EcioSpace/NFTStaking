//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BattleSuite {

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
         
      
            info["SS00"][HP] = 0;
            info["SS00"][ATK] = 0;
            info["SS00"][DEF] = 600000;
            info["SS00"][ASPD] = 0;
            info["SS00"][RANGE] = 0;
            info["SS00"][BONUS_HP] = 12000;
            info["SS00"][BONUS_ATK] = 10000;
            info["SS00"][BONUS_DEF] = 10000;
            info["SS00"][BONUS_ASPD] = 10000;
            info["SS00"][CRIT] = 0;
            info["SS00"][DODGE] = 0;
            info["SS00"][LIFESTEAL] = 500;

            info["SS01"][HP] = 0;
            info["SS01"][ATK] = 0;
            info["SS01"][DEF] = 300000;
            info["SS01"][ASPD] = 0;
            info["SS01"][RANGE] = 0;
            info["SS01"][BONUS_HP] = 10000;
            info["SS01"][BONUS_ATK] = 12000;
            info["SS01"][BONUS_DEF] = 10000;
            info["SS01"][BONUS_ASPD] = 10000;
            info["SS01"][CRIT] = 500;
            info["SS01"][DODGE] = 0;
            info["SS01"][LIFESTEAL] = 0;

            info["SS02"][HP] = 0;
            info["SS02"][ATK] = 0;
            info["SS02"][DEF] = 400000;
            info["SS02"][ASPD] = 0;
            info["SS02"][RANGE] = 0;
            info["SS02"][BONUS_HP] = 11000;
            info["SS02"][BONUS_ATK] = 10500;
            info["SS02"][BONUS_DEF] = 10000;
            info["SS02"][BONUS_ASPD] = 12000;
            info["SS02"][CRIT] = 0;
            info["SS02"][DODGE] = 0;
            info["SS02"][LIFESTEAL] = 0;

            info["SS03"][HP] = 0;
            info["SS03"][ATK] = 0;
            info["SS03"][DEF] = 1400000;
            info["SS03"][ASPD] = 0;
            info["SS03"][RANGE] = 0;
            info["SS03"][BONUS_HP] = 14000;
            info["SS03"][BONUS_ATK] = 10000;
            info["SS03"][BONUS_DEF] = 12000;
            info["SS03"][BONUS_ASPD] = 10000;
            info["SS03"][CRIT] = 0;
            info["SS03"][DODGE] = 500;
            info["SS03"][LIFESTEAL] = 1000;

            info["SS04"][HP] = 0;
            info["SS04"][ATK] = 0;
            info["SS04"][DEF] = 800000;
            info["SS04"][ASPD] = 0;
            info["SS04"][RANGE] = 0;
            info["SS04"][BONUS_HP] = 10000;
            info["SS04"][BONUS_ATK] = 14000;
            info["SS04"][BONUS_DEF] = 10000;
            info["SS04"][BONUS_ASPD] = 12000;
            info["SS04"][CRIT] = 1000;
            info["SS04"][DODGE] = 0;
            info["SS04"][LIFESTEAL] = 300;

            info["SS05"][HP] = 0;
            info["SS05"][ATK] = 0;
            info["SS05"][DEF] = 800000;
            info["SS05"][ASPD] = 0;
            info["SS05"][RANGE] = 0;
            info["SS05"][BONUS_HP] = 12000;
            info["SS05"][BONUS_ATK] = 11000;
            info["SS05"][BONUS_DEF] = 10000;
            info["SS05"][BONUS_ASPD] = 14000;
            info["SS05"][CRIT] = 1500;
            info["SS05"][DODGE] = 700;
            info["SS05"][LIFESTEAL] = 0;

            info["SS06"][HP] = 0;
            info["SS06"][ATK] = 0;
            info["SS06"][DEF] = 1200000;
            info["SS06"][ASPD] = 0;
            info["SS06"][RANGE] = 0;
            info["SS06"][BONUS_HP] = 13000;
            info["SS06"][BONUS_ATK] = 10000;
            info["SS06"][BONUS_DEF] = 10000;
            info["SS06"][BONUS_ASPD] = 10000;
            info["SS06"][CRIT] = 1000;
            info["SS06"][DODGE] = 3000;
            info["SS06"][LIFESTEAL] = 1000;

            info["SS07"][HP] = 0;
            info["SS07"][ATK] = 0;
            info["SS07"][DEF] = 1100000;
            info["SS07"][ASPD] = 0;
            info["SS07"][RANGE] = 0;
            info["SS07"][BONUS_HP] = 10000;
            info["SS07"][BONUS_ATK] = 18000;
            info["SS07"][BONUS_DEF] = 10000;
            info["SS07"][BONUS_ASPD] = 13000;
            info["SS07"][CRIT] = 2000;
            info["SS07"][DODGE] = 0;
            info["SS07"][LIFESTEAL] = 0;

            info["SS08"][HP] = 0;
            info["SS08"][ATK] = 0;
            info["SS08"][DEF] = 1600000;
            info["SS08"][ASPD] = 0;
            info["SS08"][RANGE] = 0;
            info["SS08"][BONUS_HP] = 15000;
            info["SS08"][BONUS_ATK] = 13000;
            info["SS08"][BONUS_DEF] = 12000;
            info["SS08"][BONUS_ASPD] = 13000;
            info["SS08"][CRIT] = 1000;
            info["SS08"][DODGE] = 500;
            info["SS08"][LIFESTEAL] = 1500;

            info["SS09"][HP] = 0;
            info["SS09"][ATK] = 0;
            info["SS09"][DEF] = 1050000;
            info["SS09"][ASPD] = 0;
            info["SS09"][RANGE] = 0;
            info["SS09"][BONUS_HP] = 10000;
            info["SS09"][BONUS_ATK] = 25000;
            info["SS09"][BONUS_DEF] = 10000;
            info["SS09"][BONUS_ASPD] = 10000;
            info["SS09"][CRIT] = 1000;
            info["SS09"][DODGE] = 0;
            info["SS09"][LIFESTEAL] = 0;

            info["SS10"][HP] = 0;
            info["SS10"][ATK] = 0;
            info["SS10"][DEF] = 1250000;
            info["SS10"][ASPD] = 0;
            info["SS10"][RANGE] = 0;
            info["SS10"][BONUS_HP] = 10000;
            info["SS10"][BONUS_ATK] = 40000;
            info["SS10"][BONUS_DEF] = 10000;
            info["SS10"][BONUS_ASPD] = 10000;
            info["SS10"][CRIT] = 1000;
            info["SS10"][DODGE] = 0;
            info["SS10"][LIFESTEAL] = 0;

            info["SS11"][HP] = 0;
            info["SS11"][ATK] = 0;
            info["SS11"][DEF] = 2000000;
            info["SS11"][ASPD] = 0;
            info["SS11"][RANGE] = 0;
            info["SS11"][BONUS_HP] = 20000;
            info["SS11"][BONUS_ATK] = 20000;
            info["SS11"][BONUS_DEF] = 15000;
            info["SS11"][BONUS_ASPD] = 20000;
            info["SS11"][CRIT] = 0;
            info["SS11"][DODGE] = 2000;
            info["SS11"][LIFESTEAL] = 2000;

    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SS", codeNumber))][attributeId];
    }

}