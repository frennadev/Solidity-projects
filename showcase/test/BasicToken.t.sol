// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicToken} from "../src/tokens/BasicToken.sol";

contract BasicTokenTest is Test {
    BasicToken private token;

    function setUp() public {
        token = new BasicToken("Basic", "BSC", 1_000 ether);
    }

    function testInitialMint() public {
        assertEq(token.totalSupply(), 1_000 ether);
        assertEq(token.balanceOf(address(this)), 1_000 ether);
    }

    function testTransfer() public {
        token.transfer(address(1), 10 ether);
        assertEq(token.balanceOf(address(1)), 10 ether);
    }
}

