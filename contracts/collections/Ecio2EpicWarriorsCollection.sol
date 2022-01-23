//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../helper/Helper.sol";
import "../helper/IECIONFT.sol";
import "../helper/EcioChallenge.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Ecio2EpicWarriorsCollection is EcioChallenge, ECIOHelper, Ownable {
    
    IECIONFT nftCoreV1Contract;
    IECIONFT nftCoreV2Contract;

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

    function setup(address nftCoreV1, address nftCoreV2)
        public
        virtual
        override
        onlyOwner
    {
        nftCoreV1Contract = IECIONFT(nftCoreV1);
        nftCoreV2Contract = IECIONFT(nftCoreV2);
    }

    function bonus(
        address account,
        address[] memory contracts,
        uint256[] memory tokenIds
    ) public view virtual override returns (uint256) {
        uint256 count;
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            address contractAdress = contracts[index];

            string memory partCode;
            (partCode, ) = IECIONFT(contractAdress).tokenInfo(tokenId);

            string[] memory splittedPartCodes = splitPartCode(partCode);
            string memory headCode = splittedPartCodes[PC_GENOME];

            if (matchCondition(headCode)) {
                count++;

                if (count >= 2) {
                    return 20000 * 1e18;
                }
            }
        }

        return 0;
    }

    function matchCondition(string memory headCode)
        private
        pure
        returns (bool)
    {
        return
            compareStrings(headCode, "13") ||
            compareStrings(headCode, "14") ||
            compareStrings(headCode, "15") ||
            compareStrings(headCode, "16");
    }

    function compareStrings(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }

    function staked(address[] memory contracts, uint256[] memory tokenIds)
        public
        view
        returns (uint256, uint256)
    {
        uint256 count;
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            address contractAdress = contracts[index];

            string memory partCode;
            (partCode, ) = IECIONFT(contractAdress).tokenInfo(tokenId);

            string[] memory splittedPartCodes = splitPartCode(partCode);
            string memory headCode = splittedPartCodes[PC_GENOME];

            if (matchCondition(headCode)) {
                count++;
            }
        }

        return (count, 2);
    }
}
