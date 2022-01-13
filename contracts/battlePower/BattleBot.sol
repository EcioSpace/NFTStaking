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

    mapping(string => mapping(uint256 => uint256)) info;
 
    function initil() public {
        info["00"][HP] = 0;
        info["00"][ATK] = 0;
        info["00"][DEF] = 0;
        info["00"][ASPD] = 0;
        info["00"][RANGE] = 0;
        info["00"][BONUS_HP] = 0;
        info["00"][BONUS_ATK] = 0;
        info["00"][BONUS_DEF] = 0;
        info["00"][BONUS_ASPD] = 0;
        info["00"][CRIT] = 0;
        info["00"][DODGE] = 0;
        info["00"][LIFESTEAL] = 0;
        // //--
        // info[1][HP] = 702;
        // info["01"][ATK] = 0;
        // info["01"][DEF] = 0;
        // info["01"][ASPD] = 0;
        // info["01"][RANGE] = 0;
        // info["01"][BONUS_HP] = 1;
        // info["01"][BONUS_ATK] = 1;
        // info["01"][BONUS_DEF] = 1;
        // info["01"][BONUS_ASPD] = 1;
        // info[1][CRIT] = 0;
        // info[1][DODGE] = 0;
        // info[1][LIFESTEAL] = 0;
        // //--
        // info[2][HP] = 702;
        // info[2][ATK] = 0;
        // info[2][DEF] = 0;
        // info[2][ASPD] = 0;
        // info[2][RANGE] = 0;
        // info[2][BONUS_HP] = 1;
        // info[2][BONUS_ATK] = 1;
        // info[2][BONUS_DEF] = 1;
        // info[2][BONUS_ASPD] = 1;
        // info[2][CRIT] = 0;
        // info[2][DODGE] = 0;
        // info[2][LIFESTEAL] = 0;
        // //--
        // info[3][HP] = 702;
        // info[3][ATK] = 0;
        // info[3][DEF] = 0;
        // info[3][ASPD] = 0;
        // info[3][RANGE] = 0;
        // info[3][BONUS_HP] = 1;
        // info[3][BONUS_ATK] = 1;
        // info[3][BONUS_DEF] = 1;
        // info[3][BONUS_ASPD] = 1;
        // info[3][CRIT] = 0;
        // info[3][DODGE] = 0;
        // info[3][LIFESTEAL] = 0;
        // //--
        // info[4][HP] = 702;
        // info[4][ATK] = 0;
        // info[4][DEF] = 0;
        // info[4][ASPD] = 0;
        // info[4][RANGE] = 0;
        // info[4][BONUS_HP] = 1;
        // info[4][BONUS_ATK] = 1;
        // info[4][BONUS_DEF] = 1;
        // info[4][BONUS_ASPD] = 1;
        // info[4][CRIT] = 0;
        // info[4][DODGE] = 0;
        // info[4][LIFESTEAL] = 0;
        // //--
        // info[5][HP] = 702;
        // info[5][ATK] = 0;
        // info[5][DEF] = 0;
        // info[5][ASPD] = 0;
        // info[5][RANGE] = 0;
        // info[5][BONUS_HP] = 1;
        // info[5][BONUS_ATK] = 1;
        // info[5][BONUS_DEF] = 1;
        // info[5][BONUS_ASPD] = 1;
        // info[5][CRIT] = 0;
        // info[5][DODGE] = 0;
        // info[5][LIFESTEAL] = 0;
        // //--
        // info[6][HP] = 702;
        // info[6][ATK] = 0;
        // info[6][DEF] = 0;
        // info[6][ASPD] = 0;
        // info[6][RANGE] = 0;
        // info[6][BONUS_HP] = 1;
        // info[6][BONUS_ATK] = 1;
        // info[6][BONUS_DEF] = 1;
        // info[6][BONUS_ASPD] = 1;
        // info[6][CRIT] = 0;
        // info[6][DODGE] = 0;
        // info[6][LIFESTEAL] = 0;
        // //--
        // info[7][HP] = 702;
        // info[7][ATK] = 0;
        // info[7][DEF] = 0;
        // info[7][ASPD] = 0;
        // info[7][RANGE] = 0;
        // info[7][BONUS_HP] = 1;
        // info[7][BONUS_ATK] = 1;
        // info[7][BONUS_DEF] = 1;
        // info[7][BONUS_ASPD] = 1;
        // info[7][CRIT] = 0;
        // info[7][DODGE] = 0;
        // info[7][LIFESTEAL] = 0;
        // //--
        // info[8][HP] = 702;
        // info[8][ATK] = 0;
        // info[8][DEF] = 0;
        // info[8][ASPD] = 0;
        // info[8][RANGE] = 0;
        // info[8][BONUS_HP] = 1;
        // info[8][BONUS_ATK] = 1;
        // info[8][BONUS_DEF] = 1;
        // info[8][BONUS_ASPD] = 1;
        // info[8][CRIT] = 0;
        // info[8][DODGE] = 0;
        // info[8][LIFESTEAL] = 0;
        // //--
        // info[9][HP] = 702;
        // info[9][ATK] = 0;
        // info[9][DEF] = 0;
        // info[9][ASPD] = 0;
        // info[9][RANGE] = 0;
        // info[9][BONUS_HP] = 1;
        // info[9][BONUS_ATK] = 1;
        // info[9][BONUS_DEF] = 1;
        // info[9][BONUS_ASPD] = 1;
        // info[9][CRIT] = 0;
        // info[9][DODGE] = 0;
        // info[9][LIFESTEAL] = 0;
        // //--
        // info[10][HP] = 702;
        // info[10][ATK] = 0;
        // info[10][DEF] = 0;
        // info[10][ASPD] = 0;
        // info[10][RANGE] = 0;
        // info[10][BONUS_HP] = 1;
        // info[10][BONUS_ATK] = 1;
        // info[10][BONUS_DEF] = 1;
        // info[10][BONUS_ASPD] = 1;
        // info[10][CRIT] = 0;
        // info[10][DODGE] = 0;
        // info[10][LIFESTEAL] = 0;
    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[codeNumber][attributeId];
    }
}
