// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CovalNftFactory.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


contract CovalSocialMedia is AccessControl{

    CovalNftFactory public covalnftFactory;

    // Let create a state variable that keep tract of posts

    uint256 private postcounter = 0;


// struct representing the post
    struct post {
        uint8 nftid;
        string content;
        string author;
        uint256 timestamp;
    }

// mapping that tract the post Id

mapping(uint256 => post)private posts;


    
}