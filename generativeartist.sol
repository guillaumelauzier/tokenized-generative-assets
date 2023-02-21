// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GenerativeArt is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    struct Artwork {
        string data;
        string author;
    }

    mapping (uint256 => Artwork) private _artwork;

    constructor() ERC721("GenerativeArt", "GA") {}

    function mint(address to, string memory data, string memory author) public returns (uint256) {
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();
        _mint(to, newTokenId);
        _setArtworkData(newTokenId, data, author);

        return newTokenId;
    }

    function getArtworkData(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "GenerativeArt: invalid token");
        return _artwork[tokenId].data;
    }

    function getArtworkAuthor(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "GenerativeArt: invalid token");
        return _artwork[tokenId].author;
    }

    function _setArtworkData(uint256 tokenId, string memory data, string memory author) private {
        _artwork[tokenId] = Artwork(data, author);
    }
}
