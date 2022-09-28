// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { GatekeeperOne } from "./GatekeeperOne.sol";
import { Hack } from "./GatekeeperOneHack.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne gateKeeper;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        gateKeeper = new GatekeeperOne();
        deal(h3x0r, 1 ether);
    }

    function testGatekeeperOneHack() public {
        vm.startPrank(h3x0r);
        Hack hack = new Hack(address(gateKeeper));
        
    }

    function testUintConversions() public {
        
    }
}