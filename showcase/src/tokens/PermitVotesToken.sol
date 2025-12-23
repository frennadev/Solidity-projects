// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "openzeppelin-contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Votes} from "openzeppelin-contracts/token/ERC20/extensions/ERC20Votes.sol";

/// @dev ERC20 with EIP-2612 permit and compound-style voting checkpoints.
contract PermitVotesToken is ERC20, ERC20Permit, ERC20Votes {
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 initialSupply
    ) ERC20(name_, symbol_) ERC20Permit(name_) {
        _mint(msg.sender, initialSupply);
    }

    // The functions below are overrides required by Solidity because of multiple inheritance.

    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Votes) {
        super._update(from, to, value);
    }

    function nonces(address owner) public view override(ERC20Permit, ERC20Votes) returns (uint256) {
        return super.nonces(owner);
    }

    function delegates(address account) public view override(ERC20Votes) returns (address) {
        return super.delegates(account);
    }
}

