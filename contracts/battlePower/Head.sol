//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract Head {

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
         
            info["SH00"][HP] = 7150000;
            info["SH00"][ATK] = 0;
            info["SH00"][DEF] = 0;
            info["SH00"][ASPD] = 0;
            info["SH00"][RANGE] = 0;
            info["SH00"][BONUS_HP] = 11000;
            info["SH00"][BONUS_ATK] = 11000;
            info["SH00"][BONUS_DEF] = 11000;
            info["SH00"][BONUS_ASPD] = 11000;
            info["SH00"][CRIT] = 0;
            info["SH00"][DODGE] = 0;
            info["SH00"][LIFESTEAL] = 0;
            infoStr["SH00"][NAME] = "Imperial Guards";

            info["SH01"][HP] = 5220000;
            info["SH01"][ATK] = 0;
            info["SH01"][DEF] = 0;
            info["SH01"][ASPD] = 0;
            info["SH01"][RANGE] = 0;
            info["SH01"][BONUS_HP] = 10000;
            info["SH01"][BONUS_ATK] = 12000;
            info["SH01"][BONUS_DEF] = 10000;
            info["SH01"][BONUS_ASPD] = 10000;
            info["SH01"][CRIT] = 1500;
            info["SH01"][DODGE] = 0;
            info["SH01"][LIFESTEAL] = 0;
            infoStr["SH01"][NAME] = "Death Squads";

            info["SH02"][HP] = 6300000;
            info["SH02"][ATK] = 0;
            info["SH02"][DEF] = 0;
            info["SH02"][ASPD] = 0;
            info["SH02"][RANGE] = 0;
            info["SH02"][BONUS_HP] = 11000;
            info["SH02"][BONUS_ATK] = 11000;
            info["SH02"][BONUS_DEF] = 11000;
            info["SH02"][BONUS_ASPD] = 11000;
            info["SH02"][CRIT] = 500;
            info["SH02"][DODGE] = 500;
            info["SH02"][LIFESTEAL] = 0;
            infoStr["SH02"][NAME] = "Imperial Rangers";

            info["SH03"][HP] = 7020000;
            info["SH03"][ATK] = 0;
            info["SH03"][DEF] = 0;
            info["SH03"][ASPD] = 0;
            info["SH03"][RANGE] = 0;
            info["SH03"][BONUS_HP] = 10000;
            info["SH03"][BONUS_ATK] = 10000;
            info["SH03"][BONUS_DEF] = 10000;
            info["SH03"][BONUS_ASPD] = 10000;
            info["SH03"][CRIT] = 0;
            info["SH03"][DODGE] = 0;
            info["SH03"][LIFESTEAL] = 0;
            infoStr["SH03"][NAME] = "Venom Trooper";

            info["SH04"][HP] = 5610000;
            info["SH04"][ATK] = 0;
            info["SH04"][DEF] = 0;
            info["SH04"][ASPD] = 0;
            info["SH04"][RANGE] = 0;
            info["SH04"][BONUS_HP] = 10000;
            info["SH04"][BONUS_ATK] = 10000;
            info["SH04"][BONUS_DEF] = 10000;
            info["SH04"][BONUS_ASPD] = 10000;
            info["SH04"][CRIT] = 0;
            info["SH04"][DODGE] = 500;
            info["SH04"][LIFESTEAL] = 0;
            infoStr["SH04"][NAME] = "Scorpion Ranger";

            info["SH05"][HP] = 6720000;
            info["SH05"][ATK] = 0;
            info["SH05"][DEF] = 0;
            info["SH05"][ASPD] = 0;
            info["SH05"][RANGE] = 0;
            info["SH05"][BONUS_HP] = 10000;
            info["SH05"][BONUS_ATK] = 10000;
            info["SH05"][BONUS_DEF] = 12000;
            info["SH05"][BONUS_ASPD] = 10000;
            info["SH05"][CRIT] = 500;
            info["SH05"][DODGE] = 500;
            info["SH05"][LIFESTEAL] = 0;
            infoStr["SH05"][NAME] = "Red Guard";

            info["SH06"][HP] = 5470000;
            info["SH06"][ATK] = 0;
            info["SH06"][DEF] = 0;
            info["SH06"][ASPD] = 0;
            info["SH06"][RANGE] = 0;
            info["SH06"][BONUS_HP] = 10000;
            info["SH06"][BONUS_ATK] = 10000;
            info["SH06"][BONUS_DEF] = 10000;
            info["SH06"][BONUS_ASPD] = 10000;
            info["SH06"][CRIT] = 0;
            info["SH06"][DODGE] = 500;
            info["SH06"][LIFESTEAL] = 0;
            infoStr["SH06"][NAME] = "Nikolai";

            info["SH07"][HP] = 6790000;
            info["SH07"][ATK] = 0;
            info["SH07"][DEF] = 0;
            info["SH07"][ASPD] = 0;
            info["SH07"][RANGE] = 0;
            info["SH07"][BONUS_HP] = 8000;
            info["SH07"][BONUS_ATK] = 14000;
            info["SH07"][BONUS_DEF] = 11000;
            info["SH07"][BONUS_ASPD] = 11000;
            info["SH07"][CRIT] = 1000;
            info["SH07"][DODGE] = 0;
            info["SH07"][LIFESTEAL] = 0;
            infoStr["SH07"][NAME] = "Kamish";

            info["SH08"][HP] = 7100000;
            info["SH08"][ATK] = 0;
            info["SH08"][DEF] = 0;
            info["SH08"][ASPD] = 0;
            info["SH08"][RANGE] = 0;
            info["SH08"][BONUS_HP] = 11000;
            info["SH08"][BONUS_ATK] = 11000;
            info["SH08"][BONUS_DEF] = 11000;
            info["SH08"][BONUS_ASPD] = 11000;
            info["SH08"][CRIT] = 0;
            info["SH08"][DODGE] = 500;
            info["SH08"][LIFESTEAL] = 0;
            infoStr["SH08"][NAME] = "Platoo";

            info["SH09"][HP] = 8240000;
            info["SH09"][ATK] = 0;
            info["SH09"][DEF] = 0;
            info["SH09"][ASPD] = 0;
            info["SH09"][RANGE] = 0;
            info["SH09"][BONUS_HP] = 13000;
            info["SH09"][BONUS_ATK] = 13000;
            info["SH09"][BONUS_DEF] = 13000;
            info["SH09"][BONUS_ASPD] = 13000;
            info["SH09"][CRIT] = 500;
            info["SH09"][DODGE] = 500;
            info["SH09"][LIFESTEAL] = 0;
            infoStr["SH09"][NAME] = "Renji";

            info["SH10"][HP] = 8900000;
            info["SH10"][ATK] = 0;
            info["SH10"][DEF] = 0;
            info["SH10"][ASPD] = 0;
            info["SH10"][RANGE] = 0;
            info["SH10"][BONUS_HP] = 11000;
            info["SH10"][BONUS_ATK] = 11000;
            info["SH10"][BONUS_DEF] = 11000;
            info["SH10"][BONUS_ASPD] = 11000;
            info["SH10"][CRIT] = 500;
            info["SH10"][DODGE] = 500;
            info["SH10"][LIFESTEAL] = 0;
            infoStr["SH10"][NAME] = "Rodrigo";

            info["SH11"][HP] = 7450000;
            info["SH11"][ATK] = 0;
            info["SH11"][DEF] = 0;
            info["SH11"][ASPD] = 0;
            info["SH11"][RANGE] = 0;
            info["SH11"][BONUS_HP] = 11000;
            info["SH11"][BONUS_ATK] = 11000;
            info["SH11"][BONUS_DEF] = 11000;
            info["SH11"][BONUS_ASPD] = 11000;
            info["SH11"][CRIT] = 0;
            info["SH11"][DODGE] = 0;
            info["SH11"][LIFESTEAL] = 0;
            infoStr["SH11"][NAME] = "Trang";

            info["SH12"][HP] = 9600000;
            info["SH12"][ATK] = 0;
            info["SH12"][DEF] = 0;
            info["SH12"][ASPD] = 0;
            info["SH12"][RANGE] = 0;
            info["SH12"][BONUS_HP] = 13000;
            info["SH12"][BONUS_ATK] = 11000;
            info["SH12"][BONUS_DEF] = 14000;
            info["SH12"][BONUS_ASPD] = 11000;
            info["SH12"][CRIT] = 0;
            info["SH12"][DODGE] = 0;
            info["SH12"][LIFESTEAL] = 0;
            infoStr["SH12"][NAME] = "Boris";

            info["SH13"][HP] = 10970000;
            info["SH13"][ATK] = 0;
            info["SH13"][DEF] = 0;
            info["SH13"][ASPD] = 0;
            info["SH13"][RANGE] = 0;
            info["SH13"][BONUS_HP] = 12000;
            info["SH13"][BONUS_ATK] = 17000;
            info["SH13"][BONUS_DEF] = 12000;
            info["SH13"][BONUS_ASPD] = 15000;
            info["SH13"][CRIT] = 500;
            info["SH13"][DODGE] = 500;
            info["SH13"][LIFESTEAL] = 0;
            infoStr["SH13"][NAME] = "Nerea";

            info["SH14"][HP] = 8760000;
            info["SH14"][ATK] = 0;
            info["SH14"][DEF] = 0;
            info["SH14"][ASPD] = 0;
            info["SH14"][RANGE] = 0;
            info["SH14"][BONUS_HP] = 12000;
            info["SH14"][BONUS_ATK] = 12000;
            info["SH14"][BONUS_DEF] = 12000;
            info["SH14"][BONUS_ASPD] = 12000;
            info["SH14"][CRIT] = 5000;
            info["SH14"][DODGE] = 0;
            info["SH14"][LIFESTEAL] = 0;
            infoStr["SH14"][NAME] = "Star Lord";

            info["SH15"][HP] = 9800000;
            info["SH15"][ATK] = 0;
            info["SH15"][DEF] = 0;
            info["SH15"][ASPD] = 0;
            info["SH15"][RANGE] = 0;
            info["SH15"][BONUS_HP] = 12000;
            info["SH15"][BONUS_ATK] = 12000;
            info["SH15"][BONUS_DEF] = 12000;
            info["SH15"][BONUS_ASPD] = 12000;
            info["SH15"][CRIT] = 1500;
            info["SH15"][DODGE] = 1500;
            info["SH15"][LIFESTEAL] = 1500;
            infoStr["SH15"][NAME] = "Ray";

            info["SH16"][HP] = 7900000;
            info["SH16"][ATK] = 0;
            info["SH16"][DEF] = 0;
            info["SH16"][ASPD] = 0;
            info["SH16"][RANGE] = 0;
            info["SH16"][BONUS_HP] = 12000;
            info["SH16"][BONUS_ATK] = 12000;
            info["SH16"][BONUS_DEF] = 12000;
            info["SH16"][BONUS_ASPD] = 12000;
            info["SH16"][CRIT] = 1000;
            info["SH16"][DODGE] = 0;
            info["SH16"][LIFESTEAL] = 0;
            infoStr["SH16"][NAME] = "Jin-Woo";

            info["SH17"][HP] = 13600000;
            info["SH17"][ATK] = 0;
            info["SH17"][DEF] = 0;
            info["SH17"][ASPD] = 0;
            info["SH17"][RANGE] = 0;
            info["SH17"][BONUS_HP] = 15000;
            info["SH17"][BONUS_ATK] = 15000;
            info["SH17"][BONUS_DEF] = 15000;
            info["SH17"][BONUS_ASPD] = 15000;
            info["SH17"][CRIT] = 0;
            info["SH17"][DODGE] = 0;
            info["SH17"][LIFESTEAL] = 0;
            infoStr["SH17"][NAME] = "Markus";

            info["SH18"][HP] = 11420000;
            info["SH18"][ATK] = 0;
            info["SH18"][DEF] = 0;
            info["SH18"][ASPD] = 0;
            info["SH18"][RANGE] = 0;
            info["SH18"][BONUS_HP] = 15000;
            info["SH18"][BONUS_ATK] = 15000;
            info["SH18"][BONUS_DEF] = 15000;
            info["SH18"][BONUS_ASPD] = 15000;
            info["SH18"][CRIT] = 0;
            info["SH18"][DODGE] = 500;
            info["SH18"][LIFESTEAL] = 0;
            infoStr["SH18"][NAME] = "Leonard";

            info["SH19"][HP] = 11370000;
            info["SH19"][ATK] = 0;
            info["SH19"][DEF] = 0;
            info["SH19"][ASPD] = 0;
            info["SH19"][RANGE] = 0;
            info["SH19"][BONUS_HP] = 15000;
            info["SH19"][BONUS_ATK] = 15000;
            info["SH19"][BONUS_DEF] = 15000;
            info["SH19"][BONUS_ASPD] = 15000;
            info["SH19"][CRIT] = 1000;
            info["SH19"][DODGE] = 0;
            info["SH19"][LIFESTEAL] = 0;
            infoStr["SH19"][NAME] = "Xenos";

            info["SH20"][HP] = 9000000;
            info["SH20"][ATK] = 0;
            info["SH20"][DEF] = 0;
            info["SH20"][ASPD] = 0;
            info["SH20"][RANGE] = 0;
            info["SH20"][BONUS_HP] = 11500;
            info["SH20"][BONUS_ATK] = 11500;
            info["SH20"][BONUS_DEF] = 11500;
            info["SH20"][BONUS_ASPD] = 11500;
            info["SH20"][CRIT] = 0;
            info["SH20"][DODGE] = 500;
            info["SH20"][LIFESTEAL] = 0;
            infoStr["SH20"][NAME] = "Santa Claus";

            info["SH21"][HP] = 10250000;
            info["SH21"][ATK] = 0;
            info["SH21"][DEF] = 0;
            info["SH21"][ASPD] = 0;
            info["SH21"][RANGE] = 0;
            info["SH21"][BONUS_HP] = 11500;
            info["SH21"][BONUS_ATK] = 11500;
            info["SH21"][BONUS_DEF] = 11500;
            info["SH21"][BONUS_ASPD] = 11500;
            info["SH21"][CRIT] = 0;
            info["SH21"][DODGE] = 1000;
            info["SH21"][LIFESTEAL] = 0;
            infoStr["SH21"][NAME] = "Natalie";


            info["SH20"][HP] = 9000000;
            info["SH20"][ATK] = 0;
            info["SH20"][DEF] = 0;
            info["SH20"][ASPD] = 0;
            info["SH20"][RANGE] = 0;
            info["SH20"][BONUS_HP] = 11500;
            info["SH20"][BONUS_ATK] = 11500;
            info["SH20"][BONUS_DEF] = 11500;
            info["SH20"][BONUS_ASPD] = 11500;
            info["SH20"][CRIT] = 0;
            info["SH20"][DODGE] = 500;
            info["SH20"][LIFESTEAL] = 0;

            info["SH21"][HP] = 10250000;
            info["SH21"][ATK] = 0;
            info["SH21"][DEF] = 0;
            info["SH21"][ASPD] = 0;
            info["SH21"][RANGE] = 0;
            info["SH21"][BONUS_HP] = 11500;
            info["SH21"][BONUS_ATK] = 11500;
            info["SH21"][BONUS_DEF] = 11500;
            info["SH21"][BONUS_ASPD] = 11500;
            info["SH21"][CRIT] = 0;
            info["SH21"][DODGE] = 1000;
            info["SH21"][LIFESTEAL] = 0;


    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SH", codeNumber))][attributeId];
    }
        function getStrValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (string memory)
    {
        return infoStr[string(abi.encodePacked("SH", codeNumber))][attributeId];
    }

}