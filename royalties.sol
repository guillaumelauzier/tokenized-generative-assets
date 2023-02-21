// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract Royalties is IERC2981 {

    struct Royalty {
        address recipient;
        uint256 value;
    }

    mapping (uint256 => Royalty[]) private _royalties;

    function royaltyInfo(uint256 tokenId, uint256 value) external view override returns (address[] memory recipients, uint256[] memory amounts) {
        uint256 length = _royalties[tokenId].length;
        recipients = new address[](length);
        amounts = new uint256[](length);

        for (uint256 i = 0; i < length; i++) {
            recipients[i] = _royalties[tokenId][i].recipient;
            amounts[i] = _royalties[tokenId][i].value * value / 10000;
        }
    }

    function addRoyalty(uint256 tokenId, address recipient, uint256 value) public {
        require(recipient != address(0), "Royalties: recipient cannot be zero address");
        require(value <= 10000, "Royalties: value should be between 0 and 10000");

        _royalties[tokenId].push(Royalty(recipient, value));
    }

    function removeRoyalty(uint256 tokenId, address recipient) public {
        uint256 length = _royalties[tokenId].length;

        for (uint256 i = 0; i < length; i++) {
            if (_royalties[tokenId][i].recipient == recipient) {
                _royalties[tokenId][i] = _royalties[tokenId][length - 1];
                _royalties[tokenId].pop();
                return;
            }
        }

        revert("Royalties: recipient not found");
    }
}
