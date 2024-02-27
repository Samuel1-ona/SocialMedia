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

    uint256 private postidcounter = 0;

    // let create a state variable that keep track of comment

    uint256 private commentidcounter = 0;


// struct representing the post
    struct post {
        uint8 nftid;
        string content;
        string author;
        uint256 timestamp;
    }

    struct Comment {
        uint8 id;
        string content;
        address commenter;
        uint8 timestamp;
        uint8 postId;
    }

// mapping that tract the post Id

mapping(uint256 => post)private posts;

// mapping that tract the comment Id

mapping (uint256 => Comment[])private comments;


event postCreated(uint8 indexed nftid, uint8 indexed postid, address indexed author);


event commemtAdded(uint8 indexed CommentId ,  uint8 indexed postId , address indexed commenter , string content )

// setting the roles and calling the nft
constructor (address _covalNftaddress){
    covalnftFactory = CovalNftFactory(_covalNftaddress);

 // Assign the deployer the ADMIN_ROLE
    _setupRole(AMIN_ROLE,msg.sender);  

    // Set ADMIN_ROLE as the admin for USER_ROLE
    _setRoleAdmin(USER_ROLE, AMIN_ROLE);
}

// creating a function to create a post from the factory contract
// because every post is a nft
function createPost(string memory matadataURL ,  string memory content) external onlyRole(USER_ROLE) {

    uint8 nftid = covalnftFactory.mintNFTs(msg.sender, matadataURL);

    // incrementing the post when the post is created 
    postidcounter++;

    post[postidcounter] = post(nftid, content, msg.sender, block.timestamp);

    emit postCreated(nftid, postidcounter, msg.sender);
}

// function to create comment.

function createComment(string memory _content , uint256 _postId) external {

    comments[postId].push(Comment({
        id: commentidcounter,
        content: _content,
        commenter: msg.sender,
        timestamp: block.timestamp,
        postId: _postId

    }));

    commentidcounter++;

    emit commentAdded(commentidcounter, _postId, msg.sender, _content);

}



// function to assign user role to new users

function addNewuser(address _newUser) external onlyRole(AMIN_ROLE) {

    grantRole(USER_ROLE, _newUser);
}
s
function removeUser(address user ) external onlyRole(AMIN_ROLE) {

    revokeRole(USER_ROLE, user);
    
}


    
}