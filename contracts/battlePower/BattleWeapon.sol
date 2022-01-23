//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract BattleWeapon {


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
        
            info["SW00"][HP] = 0;
            info["SW00"][ATK] = 470000;
            info["SW00"][DEF] = 0;
            info["SW00"][ASPD] = 10000;
            info["SW00"][RANGE] = 10000;
            info["SW00"][BONUS_HP] = 10000;
            info["SW00"][BONUS_ATK] = 10000;
            info["SW00"][BONUS_DEF] = 10000;
            info["SW00"][BONUS_ASPD] = 10000;
            info["SW00"][CRIT] = 1500;
            info["SW00"][DODGE] = 0;
            info["SW00"][LIFESTEAL] = 1500;
            infoStr["SW00"][NAME] = "Mustard Pipe";

            info["SW01"][HP] = 0;
            info["SW01"][ATK] = 420000;
            info["SW01"][DEF] = 0;
            info["SW01"][ASPD] = 9000;
            info["SW01"][RANGE] = 40000;
            info["SW01"][BONUS_HP] = 10000;
            info["SW01"][BONUS_ATK] = 10000;
            info["SW01"][BONUS_DEF] = 10000;
            info["SW01"][BONUS_ASPD] = 10000;
            info["SW01"][CRIT] = 0;
            info["SW01"][DODGE] = 0;
            info["SW01"][LIFESTEAL] = 1500;
            infoStr["SW01"][NAME] = "Mustard Gas Thrower";

            info["SW02"][HP] = 0;
            info["SW02"][ATK] = 690000;
            info["SW02"][DEF] = 0;
            info["SW02"][ASPD] = 15000;
            info["SW02"][RANGE] = 10000;
            info["SW02"][BONUS_HP] = 10000;
            info["SW02"][BONUS_ATK] = 10000;
            info["SW02"][BONUS_DEF] = 10000;
            info["SW02"][BONUS_ASPD] = 10000;
            info["SW02"][CRIT] = 3000;
            info["SW02"][DODGE] = 0;
            info["SW02"][LIFESTEAL] = 0;
            infoStr["SW02"][NAME] = "Club Swinger";

            info["SW03"][HP] = 0;
            info["SW03"][ATK] = 540000;
            info["SW03"][DEF] = 0;
            info["SW03"][ASPD] = 12000;
            info["SW03"][RANGE] = 10000;
            info["SW03"][BONUS_HP] = 10000;
            info["SW03"][BONUS_ATK] = 10000;
            info["SW03"][BONUS_DEF] = 10000;
            info["SW03"][BONUS_ASPD] = 10000;
            info["SW03"][CRIT] = 500;
            info["SW03"][DODGE] = 0;
            info["SW03"][LIFESTEAL] = 0;
            infoStr["SW03"][NAME] = "Jojo's Electro Wrench";

            info["SW04"][HP] = 0;
            info["SW04"][ATK] = 850000;
            info["SW04"][DEF] = 0;
            info["SW04"][ASPD] = 9000;
            info["SW04"][RANGE] = 40000;
            info["SW04"][BONUS_HP] = 10000;
            info["SW04"][BONUS_ATK] = 10000;
            info["SW04"][BONUS_DEF] = 10000;
            info["SW04"][BONUS_ASPD] = 10000;
            info["SW04"][CRIT] = 0;
            info["SW04"][DODGE] = 0;
            info["SW04"][LIFESTEAL] = 1500;
            infoStr["SW04"][NAME] = "Reptile Gun (King Cobra)";

            info["SW05"][HP] = 0;
            info["SW05"][ATK] = 1550000;
            info["SW05"][DEF] = 0;
            info["SW05"][ASPD] = 13000;
            info["SW05"][RANGE] = 100000;
            info["SW05"][BONUS_HP] = 10000;
            info["SW05"][BONUS_ATK] = 10000;
            info["SW05"][BONUS_DEF] = 10000;
            info["SW05"][BONUS_ASPD] = 10000;
            info["SW05"][CRIT] = 1000;
            info["SW05"][DODGE] = 0;
            info["SW05"][LIFESTEAL] = 0;
            infoStr["SW05"][NAME] = "Granade Launcher";

            info["SW06"][HP] = 0;
            info["SW06"][ATK] = 1620000;
            info["SW06"][DEF] = 0;
            info["SW06"][ASPD] = 16000;
            info["SW06"][RANGE] = 10000;
            info["SW06"][BONUS_HP] = 10000;
            info["SW06"][BONUS_ATK] = 10000;
            info["SW06"][BONUS_DEF] = 10000;
            info["SW06"][BONUS_ASPD] = 10000;
            info["SW06"][CRIT] = 2500;
            info["SW06"][DODGE] = 0;
            info["SW06"][LIFESTEAL] = 0;
            infoStr["SW06"][NAME] = "Jet Hammer";

            info["SW07"][HP] = 0;
            info["SW07"][ATK] = 1210000;
            info["SW07"][DEF] = 0;
            info["SW07"][ASPD] = 12000;
            info["SW07"][RANGE] = 70000;
            info["SW07"][BONUS_HP] = 10000;
            info["SW07"][BONUS_ATK] = 10000;
            info["SW07"][BONUS_DEF] = 10000;
            info["SW07"][BONUS_ASPD] = 10000;
            info["SW07"][CRIT] = 500;
            info["SW07"][DODGE] = 0;
            info["SW07"][LIFESTEAL] = 0;
            infoStr["SW07"][NAME] = "Lightning Gun";

            info["SW08"][HP] = 0;
            info["SW08"][ATK] = 1540000;
            info["SW08"][DEF] = 0;
            info["SW08"][ASPD] = 14000;
            info["SW08"][RANGE] = 90000;
            info["SW08"][BONUS_HP] = 10000;
            info["SW08"][BONUS_ATK] = 10000;
            info["SW08"][BONUS_DEF] = 10000;
            info["SW08"][BONUS_ASPD] = 10000;
            info["SW08"][CRIT] = 1000;
            info["SW08"][DODGE] = 0;
            info["SW08"][LIFESTEAL] = 0;
            infoStr["SW08"][NAME] = "Electric Beam Gun";

            info["SW09"][HP] = 0;
            info["SW09"][ATK] = 1260000;
            info["SW09"][DEF] = 0;
            info["SW09"][ASPD] = 8000;
            info["SW09"][RANGE] = 30000;
            info["SW09"][BONUS_HP] = 10000;
            info["SW09"][BONUS_ATK] = 10000;
            info["SW09"][BONUS_DEF] = 10000;
            info["SW09"][BONUS_ASPD] = 10000;
            info["SW09"][CRIT] = 0;
            info["SW09"][DODGE] = 0;
            info["SW09"][LIFESTEAL] = 1500;
            infoStr["SW09"][NAME] = "Reptile Shortgun (Salamander)";

            info["SW10"][HP] = 0;
            info["SW10"][ATK] = 1520000;
            info["SW10"][DEF] = 0;
            info["SW10"][ASPD] = 10000;
            info["SW10"][RANGE] = 60000;
            info["SW10"][BONUS_HP] = 10000;
            info["SW10"][BONUS_ATK] = 10000;
            info["SW10"][BONUS_DEF] = 10000;
            info["SW10"][BONUS_ASPD] = 10000;
            info["SW10"][CRIT] = 500;
            info["SW10"][DODGE] = 0;
            info["SW10"][LIFESTEAL] = 1500;
            infoStr["SW10"][NAME] = "Venomic Bullet Rifle (Blue Ringed)";

            info["SW11"][HP] = 0;
            info["SW11"][ATK] = 2940000;
            info["SW11"][DEF] = 0;
            info["SW11"][ASPD] = 15000;
            info["SW11"][RANGE] = 150000;
            info["SW11"][BONUS_HP] = 10000;
            info["SW11"][BONUS_ATK] = 10000;
            info["SW11"][BONUS_DEF] = 10000;
            info["SW11"][BONUS_ASPD] = 10000;
            info["SW11"][CRIT] = 1000;
            info["SW11"][DODGE] = 0;
            info["SW11"][LIFESTEAL] = 0;
            infoStr["SW11"][NAME] = "Rapid Rail Gun";

            info["SW12"][HP] = 0;
            info["SW12"][ATK] = 2620000;
            info["SW12"][DEF] = 0;
            info["SW12"][ASPD] = 13000;
            info["SW12"][RANGE] = 20000;
            info["SW12"][BONUS_HP] = 10000;
            info["SW12"][BONUS_ATK] = 10000;
            info["SW12"][BONUS_DEF] = 10000;
            info["SW12"][BONUS_ASPD] = 10000;
            info["SW12"][CRIT] = 2000;
            info["SW12"][DODGE] = 0;
            info["SW12"][LIFESTEAL] = 0;
            infoStr["SW12"][NAME] = "Tesla Spear";

            info["SW13"][HP] = 0;
            info["SW13"][ATK] = 1320000;
            info["SW13"][DEF] = 0;
            info["SW13"][ASPD] = 7000;
            info["SW13"][RANGE] = 140000;
            info["SW13"][BONUS_HP] = 10000;
            info["SW13"][BONUS_ATK] = 10000;
            info["SW13"][BONUS_DEF] = 10000;
            info["SW13"][BONUS_ASPD] = 10000;
            info["SW13"][CRIT] = 2000;
            info["SW13"][DODGE] = 0;
            info["SW13"][LIFESTEAL] = 0;
            infoStr["SW13"][NAME] = "Gamma Beam Gun";

            info["SW14"][HP] = 0;
            info["SW14"][ATK] = 4240000;
            info["SW14"][DEF] = 0;
            info["SW14"][ASPD] = 17000;
            info["SW14"][RANGE] = 40000;
            info["SW14"][BONUS_HP] = 10000;
            info["SW14"][BONUS_ATK] = 10000;
            info["SW14"][BONUS_DEF] = 10000;
            info["SW14"][BONUS_ASPD] = 10000;
            info["SW14"][CRIT] = 500;
            info["SW14"][DODGE] = 0;
            info["SW14"][LIFESTEAL] = 0;
            infoStr["SW14"][NAME] = "Kepler Gun";

            info["SW15"][HP] = 0;
            info["SW15"][ATK] = 2980000;
            info["SW15"][DEF] = 0;
            info["SW15"][ASPD] = 10000;
            info["SW15"][RANGE] = 60000;
            info["SW15"][BONUS_HP] = 10000;
            info["SW15"][BONUS_ATK] = 10000;
            info["SW15"][BONUS_DEF] = 10000;
            info["SW15"][BONUS_ASPD] = 10000;
            info["SW15"][CRIT] = 0;
            info["SW15"][DODGE] = 0;
            info["SW15"][LIFESTEAL] = 2000;
            infoStr["SW15"][NAME] = "Venomic Rocket Launcher (Box Jellyfish)";

            info["SW16"][HP] = 0;
            info["SW16"][ATK] = 3670000;
            info["SW16"][DEF] = 0;
            info["SW16"][ASPD] = 12000;
            info["SW16"][RANGE] = 140000;
            info["SW16"][BONUS_HP] = 10000;
            info["SW16"][BONUS_ATK] = 10000;
            info["SW16"][BONUS_DEF] = 10000;
            info["SW16"][BONUS_ASPD] = 10000;
            info["SW16"][CRIT] = 1000;
            info["SW16"][DODGE] = 0;
            info["SW16"][LIFESTEAL] = 0;
            infoStr["SW16"][NAME] = "HE Rocket Launcher";

            info["SW17"][HP] = 0;
            info["SW17"][ATK] = 3240000;
            info["SW17"][DEF] = 0;
            info["SW17"][ASPD] = 12000;
            info["SW17"][RANGE] = 70000;
            info["SW17"][BONUS_HP] = 10000;
            info["SW17"][BONUS_ATK] = 10000;
            info["SW17"][BONUS_DEF] = 10000;
            info["SW17"][BONUS_ASPD] = 10000;
            info["SW17"][CRIT] = 1000;
            info["SW17"][DODGE] = 0;
            info["SW17"][LIFESTEAL] = 0;
            infoStr["SW17"][NAME] = "Electron Pulse Rifle";

            info["SW18"][HP] = 0;
            info["SW18"][ATK] = 2220000;
            info["SW18"][DEF] = 0;
            info["SW18"][ASPD] = 8000;
            info["SW18"][RANGE] = 10000;
            info["SW18"][BONUS_HP] = 10000;
            info["SW18"][BONUS_ATK] = 10000;
            info["SW18"][BONUS_DEF] = 10000;
            info["SW18"][BONUS_ASPD] = 10000;
            info["SW18"][CRIT] = 4000;
            info["SW18"][DODGE] = 0;
            info["SW18"][LIFESTEAL] = 0;
            infoStr["SW18"][NAME] = "Plasma Injection Saber";

            info["SW19"][HP] = 0;
            info["SW19"][ATK] = 6250000;
            info["SW19"][DEF] = 0;
            info["SW19"][ASPD] = 18000;
            info["SW19"][RANGE] = 150000;
            info["SW19"][BONUS_HP] = 10000;
            info["SW19"][BONUS_ATK] = 10000;
            info["SW19"][BONUS_DEF] = 10000;
            info["SW19"][BONUS_ASPD] = 10000;
            info["SW19"][CRIT] = 0;
            info["SW19"][DODGE] = 0;
            info["SW19"][LIFESTEAL] = 0;
            infoStr["SW19"][NAME] = "Gravitational Distortion Rifle";

            info["SW20"][HP] = 0;
            info["SW20"][ATK] = 2560000;
            info["SW20"][DEF] = 0;
            info["SW20"][ASPD] = 15000;
            info["SW20"][RANGE] = 60000;
            info["SW20"][BONUS_HP] = 10000;
            info["SW20"][BONUS_ATK] = 10000;
            info["SW20"][BONUS_DEF] = 10000;
            info["SW20"][BONUS_ASPD] = 10000;
            info["SW20"][CRIT] = 0;
            info["SW20"][DODGE] = 0;
            info["SW20"][LIFESTEAL] = 0;
            infoStr["SW20"][NAME] = "Snow Blaster";

            info["SW21"][HP] = 0;
            info["SW21"][ATK] = 2350000;
            info["SW21"][DEF] = 0;
            info["SW21"][ASPD] = 14000;
            info["SW21"][RANGE] = 10000;
            info["SW21"][BONUS_HP] = 10000;
            info["SW21"][BONUS_ATK] = 10000;
            info["SW21"][BONUS_DEF] = 10000;
            info["SW21"][BONUS_ASPD] = 10000;
            info["SW21"][CRIT] = 1000;
            info["SW21"][DODGE] = 0;
            info["SW21"][LIFESTEAL] = 0;
            infoStr["SW21"][NAME] = "Valkyrie's Shield";


    }

    function getValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (uint256)
    {
        return info[string(abi.encodePacked("SW", codeNumber))][attributeId];
    }

        function getStrValue(string memory codeNumber, uint256 attributeId)
        public
        view
        returns (string memory)
    {
        return infoStr[string(abi.encodePacked("SW", codeNumber))][attributeId];
    }
}