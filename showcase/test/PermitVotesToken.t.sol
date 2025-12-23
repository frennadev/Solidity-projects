// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {PermitVotesToken} from "../src/tokens/PermitVotesToken.sol";

contract PermitVotesTokenTest is Test {
    PermitVotesToken private token;

    function setUp() public {
        token = new PermitVotesToken("GovToken", "GOV", 1_000 ether);
    }

    function testDelegateAndVotes() public {
        address alice = address(0xA11CE);
        token.transfer(alice, 100 ether);

        vm.prank(alice);
        token.delegate(alice);

        (uint256 posVotes,) = token.getVotesWithParams(alice);
        assertEq(posVotes, 100 ether);
    }
}

