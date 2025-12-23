// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";
import {ERC721Royalty} from "openzeppelin-contracts/token/ERC721/extensions/ERC721Royalty.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

/// @dev ERC721 with EIP-2981 royalties; owner can update default royalty info.
contract NftRoyalty is ERC721, ERC721Royalty, Ownable {
    uint256 private _tokenIdTracker;

    constructor(string memory name_, string memory symbol_, address royaltyReceiver, uint96 royaltyFeeNumerator)
        ERC721(name_, symbol_)
        Ownable(msg.sender)
    {
        _setDefaultRoyalty(royaltyReceiver, royaltyFeeNumerator);
    }

    function mint(address to) external onlyOwner returns (uint256 tokenId) {
        tokenId = ++_tokenIdTracker;
        _safeMint(to, tokenId);
    }

    /// @notice Owner can update royalty receiver and fee (in basis points).
    function setRoyalty(address receiver, uint96 feeNumerator) external onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator);
    }

    // The functions below are overrides required by Solidity because of multiple inheritance.

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Royalty) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}

