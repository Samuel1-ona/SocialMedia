// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./CovalNft.sol"; // Import the path to your Coval contract

contract CovalFactory {
    // Event to emit when a new Coval contract is created
    event CovalCreated(address indexed newCovalAddress, address indexed owner);

    // Array to keep track of all created Coval contracts
    Coval[] public covalContracts;

    // Function to create a new Coval contract
    function createCoval(address initialOwner) public {
        Coval newCoval = new Coval(initialOwner);
        covalContracts.push(newCoval);
        emit CovalCreated(address(newCoval), initialOwner);
    }

    // Function to get the total number of created Coval contracts
    function getCovalContractsCount() public view returns (uint) {
        return covalContracts.length;
    }
}
