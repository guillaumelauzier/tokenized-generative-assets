pragma solidity ^0.8.0;

contract GenerativeArtNFT {
    address public dataProvider;
    address public artist;
    mapping(uint256 => uint256) public royalties; // Mapping to keep track of royalties for each NFT token ID

    constructor(address _dataProvider, address _artist) {
        dataProvider = _dataProvider;
        artist = _artist;
    }

    function distributeRoyalties(uint256 tokenId, uint256 salePrice) public {
        uint256 dataProviderShare = (salePrice * 30) / 100; // 30% share for data provider
        uint256 artistShare = (salePrice * 70) / 100; // 70% share for artist

        require(payable(dataProvider).send(dataProviderShare), "Failed to send data provider share");
        require(payable(artist).send(artistShare), "Failed to send artist share");

        royalties[tokenId] += artistShare; // Add the artist's share to the royalty mapping
    }

    function getRoyalties(uint256 tokenId) public view returns (uint256) {
        return royalties[tokenId];
    }
}
