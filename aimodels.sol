pragma solidity ^0.8.0;

import "./Royalties.sol";

contract GenerativeArt is Royalties {
    
    // Define data provider and generative artist addresses
    address public dataProvider;
    address public generativeArtist;
    
    // Define NFT token ID and URI
    uint256 private _tokenId;
    string private _tokenURI;
    
    // Define an AI model contract address
    address public aiModel;
    
    // Define a constructor to initialize the data provider, generative artist, token ID, token URI, and AI model contract address
    constructor(address provider, address artist, uint256 tokenId, string memory tokenURI, address model) {
        dataProvider = provider;
        generativeArtist = artist;
        _tokenId = tokenId;
        _tokenURI = tokenURI;
        aiModel = model;
    }
    
    // Override the _transfer function to distribute royalties to data provider, generative artist, and AI model contract
    function _transfer(address from, address to, uint256 tokenId) internal override {
        super._transfer(from, to, tokenId);
        
        // Calculate the amount of royalties to distribute to each party
        uint256 royalties = super._calculateRoyalties();
        uint256 dataProviderShare = royalties / 3;
        uint256 generativeArtistShare = royalties / 3;
        uint256 aiModelShare = royalties - dataProviderShare - generativeArtistShare;
        
        // Transfer the royalties to data provider, generative artist, and AI model contract
        (bool successDataProvider,) = dataProvider.call{value: dataProviderShare}("");
        require(successDataProvider, "Transfer to data provider failed");
        (bool successArtist,) = generativeArtist.call{value: generativeArtistShare}("");
        require(successArtist, "Transfer to generative artist failed");
        (bool successAiModel,) = aiModel.call{value: aiModelShare}("");
        require(successAiModel, "Transfer to AI model contract failed");
    }
    
    // Override the tokenURI function to return the custom token URI
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(tokenId == _tokenId, "Invalid token ID");
        return _tokenURI;
    }
}
