// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./CovalNft.sol";

contract CovalSocialMedia {
    uint256 private postCounter = 0;
    uint256 private commentCounter = 0;
    uint256 private groupCounter = 0;

    address public owner;

    struct Post {
        uint256 postId;
        string content;
        address author;
        uint256 nftId;
    }

    struct Comment {
        uint256 commentId;
        uint256 postId;
        address commenter;
        string comment;
        uint256 nftId;
    }

    struct Group {
        string groupName;
        uint256 groupId;
        address groupOwner;
        address[] groupMembers; // Changed to an array to support multiple members
    }

    
     constructor() {
        owner = msg.sender;
    }

    function createNFT() external onlyOwner returns (address) {

        Coval newNFT = new Coval(msg.sender );
        newNFT.transferOwnership(msg.sender); // Transfer ownership of the NFT contract
        nfts[address(newNFT)] = newNFT;
        return address(newNFT);
    }
     

    mapping(uint256 => Post) private  posts;
    mapping(uint256 => Comment) private comments;
    mapping(uint256 => Group) private groups;
      mapping(address => Coval) nfts;


    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can perform this action");
        _;
    }

    

    function createPost(string memory content, uint256 _postId, uint256 _nftId) external onlyOwner {
        require(msg.sender != address(0), "Zero address is not allowed");
        require(posts[_postId].postId == 0, "PostId already exists");

        Post storage newPost = posts[_postId];
        newPost.postId = _postId;
        newPost.content = content;
        newPost.author = msg.sender;
        newPost.nftId = _nftId;

        postCounter++;
    }
function createComment(string memory _comment, uint256 _nftId, uint256 _commentId, uint256 _postId) external {
        require(msg.sender != address(0), "Zero address is not allowed");

        require(comments[_commentId].commentId == 0, "Comment already exists");

        require(posts[_postId].postId != 0, "Post does not exist");

        Comment storage newComment = comments[_commentId];
        newComment.commentId = _commentId;
        newComment.postId = _postId;
        newComment.commenter = msg.sender;
        newComment.comment = _comment;
        newComment.nftId = _nftId;

        commentCounter++;
    }


   function createGroup(uint256 _groupId, string memory _groupName) external {
        require(msg.sender != address(0), "Zero address is not allowed");
        require(groups[_groupId].groupId == 0, "Group already exists");

        Group storage newGroup = groups[_groupId];
        newGroup.groupId = _groupId;
        newGroup.groupOwner = msg.sender;
        newGroup.groupName = _groupName;
        // Initialize the groupMembers array as empty.
        newGroup.groupMembers = new address[](0);

        groupCounter++;
    }


   
}
