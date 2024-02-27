// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CovalNftFactory.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


contract CovalSocialMedia is AccessControl{

    // let define the role of the RBAC

    bytes32 public constant AMIN_ROLE = keccak256("AMIN_ROLE");
    bytes32 PUBLIC constant USER_ROLE = keccak256("USER_ROLE");

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

event postCreated(uint8 nftid, string postid, string author);

// setting the roles and calling the nft
constructor (address _covalNftaddress){
    covalnftFactory = CovalNftFactory(_covalNftaddress);
    _setupRole(AMIN_ROLE,msg.sender);
    _setAdminRole(USER_ROLE, AMIN_ROLE);
}



    
}