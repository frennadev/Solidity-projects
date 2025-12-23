// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "openzeppelin-contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Supply} from "openzeppelin-contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

/// @dev ERC1155 with per-id supply tracking and owner-controlled mint/burn.
contract MultiTokenSupply is ERC1155, ERC1155Supply, Ownable {
    constructor(string memory baseUri) ERC1155(baseUri) Ownable(msg.sender) {}

    function mint(address to, uint256 id, uint256 amount, bytes memory data) external onlyOwner {
        _mint(to, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        external
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function burn(address from, uint256 id, uint256 amount) external onlyOwner {
        _burn(from, id, amount);
    }

    function burnBatch(address from, uint256[] memory ids, uint256[] memory amounts) external onlyOwner {
        _burnBatch(from, ids, amounts);
    }

    // Overrides to resolve inheritance.
    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}

