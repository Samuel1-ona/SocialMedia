// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "./CovalNft.sol";

contract NFTFactory {
    // Keep track of all created NFT collections
    CovalNft[] public nftCollections;

    // Event to be emitted when a new NFT collection is created
    event CovalNftCreated(address collectionAddress);

    function createNFTCollection(string memory name, string memory symbol) public {
        CovalNft newCollection = new CovalNft(name, symbol);
        nftCollections.push(newCollection);
        emit CovalNftCreated(address(newCollection));
    }

    // Function to get the total number of created NFT collections
    function getNFTCollectionsCount() public view returns (uint256) {
        return nftCollections.length;
    }
}