//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

interface ECIONFT {
    function tokenInfo(uint256 _tokenId)
        external
        view
        returns (string memory, uint256);
}

contract Ecio2EpicWarriorsCollection {
  
    ECIONFT nftCoreV1Contract;
    ECIONFT nftCoreV2Contract;

    function setup(address nftCoreV1,address nftCoreV2) public {
        nftCoreV1Contract = ECIONFT(nftCoreV1);
        nftCoreV2Contract = ECIONFT(nftCoreV2);
    }
    
    function bonus(address account, address[] memory contracts, uint[] memory tokenIds) public view returns (uint256) {
        return 100;
    }
    
}