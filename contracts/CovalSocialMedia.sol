// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./CovalNftFactory.sol"; 

contract CovalSocialMedia is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    CovalFactory public covalNftFactory;

    uint256 private postIdCounter = 0;
    uint256 private commentIdCounter = 0;

    struct Post {
        uint256 nftId;
        string content;
        address author;
        uint256 timestamp;
    }

    struct Comment {
        uint256 id;
        string content;
        address commenter;
        uint256 timestamp;
        uint256 postId;
    }

    mapping(uint256 => Post) private posts;
    mapping(uint256 => Comment[]) private comments;

    event PostCreated(uint256 indexed nftId, uint256 indexed postId, address indexed author);
    event CommentAdded(uint256 indexed commentId, uint256 indexed postId, address indexed commenter, string content);

    constructor(address _covalNftAddress) {
        covalNftFactory = CovalFactory(_covalNftAddress);
        _setupRole(ADMIN_ROLE, msg.sender);
        
        _setRoleAdmin(USER_ROLE, ADMIN_ROLE);
    }

    // Updated function to create a post
    function createPost(string memory metadataURL, string memory content) external onlyRole(USER_ROLE) {
        // Assuming the factory has a method to directly mint an NFT and return its ID
        uint256 nftId = covalNftFactory.mintNFT(msg.sender, metadataURL); // This needs to match actual implementation

        postIdCounter++;
        posts[postIdCounter] = Post(nftId, content, msg.sender, block.timestamp);
        emit PostCreated(nftId, postIdCounter, msg.sender);
    }

    function createComment(string memory content, uint256 postId) external {
        commentIdCounter++;
        comments[postId].push(Comment(commentIdCounter, content, msg.sender, block.timestamp, postId));
        emit CommentAdded(commentIdCounter, postId, msg.sender, content);
    }

    function addNewUser(address newUser) external onlyRole(ADMIN_ROLE) {
        grantRole(USER_ROLE, newUser);
    }

    function removeUser(address user) external onlyRole(ADMIN_ROLE) {
        revokeRole(USER_ROLE, user);
    }
}
