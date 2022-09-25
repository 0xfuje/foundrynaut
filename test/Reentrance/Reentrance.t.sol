// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Reentrance } from "../../src/Reentrance/Reentrance.sol";
import { ReentrancyAttack } from "./ReentrancyAttack.sol";

contract ReentranceTest is Test {
    Reentrance reentrance;
    ReentrancyAttack hack;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        reentrance = new Reentrance();
        deal(h3x0r, 2 ether);
        deal(address(reentrance), 10 ether);
    }

    function testReentrancyHack() public {
        vm.startPrank(h3x0r);
        hack = new ReentrancyAttack(address(reentrance));
        address(hack).call{value: 1 ether}("");
        hack.startAttack();

        assertEq(address(hack).balance, 11 ether);
    }
}