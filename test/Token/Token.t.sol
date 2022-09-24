// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Token } from "../../src/Token/Token.sol";

contract TokenTest is Test {
    Token token;

    address h3x0r = vm.addr(1337);
    address h3x0rAccount = vm.addr(420);
    address deployer = vm.addr(1);

    function setUp() public {
        vm.prank(deployer);
        token = new Token(21_000_000);
        deal(address(token), h3x0r, 20);
    }

    function testTokenHack() public {
        vm.startPrank(h3x0r);
        assertEq(token.balanceOf(h3x0r), 20);

        token.transfer(
            h3x0rAccount,
            20
        );
        
        emit log_named_uint(
            "h3x0rAccount balance",
            token.balanceOf(h3x0rAccount)
        );
    }
}