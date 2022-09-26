// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Telephone } from "../../src/Telephone/Telephone.sol";
import { TelephoneHack } from "./TelephoneHack.sol";

contract TelephoneTest is Test {
    Telephone telephone;
    TelephoneHack hack;

    address h3x0r = vm.addr(1337);
    address deployer = vm.addr(1);

    function setUp() public {
        vm.prank(deployer);
        telephone = new Telephone();
        deal(h3x0r, 1 ether);
    }

    function testTelephoneHack() public {
        emit log_named_address("owner of telephone before hack", telephone.owner());

        vm.startPrank(h3x0r);
        hack = new TelephoneHack(address(telephone));

        hack.pwn(h3x0r);

        assertEq(telephone.owner(), h3x0r);
        emit log_named_address("owner of telephone after hack", telephone.owner());
    }
}