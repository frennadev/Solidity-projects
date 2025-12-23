// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20Upgradeable} from "openzeppelin-contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {OwnableUpgradeable} from "openzeppelin-contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "openzeppelin-contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "openzeppelin-contracts-upgradeable/proxy/utils/Initializable.sol";
import {ERC1967Proxy} from "openzeppelin-contracts/proxy/ERC1967/ERC1967Proxy.sol";

/// @dev Upgradeable ERC20 using UUPS pattern; owner-governed upgrades.
contract UpgradeableToken is Initializable, ERC20Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    function initialize(string memory name_, string memory symbol_, address owner_, uint256 initialSupply)
        public
        initializer
    {
        __ERC20_init(name_, symbol_);
        __Ownable_init(owner_);
        __UUPSUpgradeable_init();
        _mint(owner_, initialSupply);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}

/// @dev Thin ERC1967 proxy wiring to the upgradeable token implementation.
contract TokenProxy is ERC1967Proxy {
    constructor(address implementation, bytes memory initData) ERC1967Proxy(implementation, initData) {}
}

