pragma solidity ^0.8.0;

import "./Royalties.sol";

contract GenerativeArt is Royalties {
    
    // Define data provider and generative artist addresses
    address public dataProvider;
    address public generativeArtist;
    
    // Define NFT token ID and URI
    uint256 private _tokenId;
    string private _tokenURI;
    
    // Define a struct to represent a spending proposal
    struct SpendingProposal {
        address recipient;
        uint256 amount;
        bool approved;
    }
    
    // Define an array of spending proposals
    SpendingProposal[] public spendingProposals;
    
    // Define a mapping to keep track of which addresses have already voted on a proposal
    mapping (address => bool) public hasVoted;
    
    // Define a constructor to initialize the data provider, generative artist, token ID, and token URI
    constructor(address provider, address artist, uint256 tokenId, string memory tokenURI) {
        dataProvider = provider;
        generativeArtist = artist;
        _tokenId = tokenId;
        _tokenURI = tokenURI;
    }
    
    // Override the _transfer function to distribute royalties to data provider and generative artist
    function _transfer(address from, address to, uint256 tokenId) internal override {
        super._transfer(from, to, tokenId);
        
        // Calculate the amount of royalties to distribute to each party
        uint256 royalties = super._calculateRoyalties();
        uint256 dataProviderShare = royalties / 2;
        uint256 generativeArtistShare = royalties - dataProviderShare;
        
        // Transfer the royalties to data provider and generative artist
        (bool successDataProvider,) = dataProvider.call{value: dataProviderShare}("");
        require(successDataProvider, "Transfer to data provider failed");
        (bool successArtist,) = generativeArtist.call{value: generativeArtistShare}("");
        require(successArtist, "Transfer to generative artist failed");
    }
    
    // Define a function to add a spending proposal to the array
    function addSpendingProposal(address recipient, uint256 amount) public {
        require(msg.sender == dataProvider || msg.sender == generativeArtist, "Only data provider or generative artist can add a spending proposal");
        spendingProposals.push(SpendingProposal(recipient, amount, false));
    }
    
    // Define a function for recipients to approve a spending proposal
    function approveSpendingProposal(uint256 index) public {
        require(spendingProposals[index].recipient == msg.sender, "Only the recipient of the proposal can approve it");
        require(!hasVoted[msg.sender], "Cannot vote more than once on a proposal");
        spendingProposals[index].approved = true;
        hasVoted[msg.sender] = true;
    }
    
    // Define a function to execute an approved spending proposal
    function executeSpendingProposal(uint256 index) public {
        require(spendingProposals[index].approved, "Proposal must be approved before it can be executed");
        (bool success,) = spendingProposals[index].recipient.call{value: spendingProposals[index].amount}("");
        require(success, "Transfer to recipient failed");
        delete spendingProposals[index];
    }
    
    // Override the tokenURI function to return the custom token URI
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(tokenId == _tokenId, "Invalid token ID");
        return _tokenURI;
    }
}
