// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";



//checked through the ERC2771Context.sol to get ideas on how the function works 

contract GaslessTransaction is ERC2771Context {

    constructor(address trustedForwarder) ERC2771Context(trustedForwarder) {}

    // Override _msgSender() and _msgData() to use ERC2771Context versions
    function _msgSender() internal view override(Context, ERC2771Context) returns (address sender) {
        return ERC2771Context._msgSender();
    }

    function _msgData() internal view override(Context, ERC2771Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }
}