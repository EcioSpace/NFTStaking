//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../helper/Helper.sol";
import "../helper/IECIONFT.sol";
import "../helper/EcioChallenge.sol";
import "hardhat/console.sol";

contract Ecio2EpicWarriorsCollection is EcioChallenge {

    IECIONFT nftCoreV1Contract;
    IECIONFT nftCoreV2Contract;

    function setup(address nftCoreV1, address nftCoreV2)
        public
        virtual
        override
    {
        nftCoreV1Contract = IECIONFT(nftCoreV1);
        nftCoreV2Contract = IECIONFT(nftCoreV2);
    }

    function bonus(
        address account,
        address[] memory contracts,
        uint256[] memory tokenIds
    ) public view virtual override returns (uint256) {
       return 200;
    }
}
