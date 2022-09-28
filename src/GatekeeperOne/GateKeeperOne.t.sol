// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { GatekeeperOne } from "./GatekeeperOne.sol";
import { Hack } from "./GatekeeperOneHack.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne gateKeeper;

    address h3x0r = 0x1e0733e312D04a199268E1Aead9Fc3bA91B97cFc;

    function setUp() public {
        gateKeeper = new GatekeeperOne();
        deal(h3x0r, 1 ether);
    }

    function testGatekeeperOneHack() public {
        vm.startPrank(h3x0r);
        Hack hack = new Hack(address(gateKeeper));
        hack.enterGate();
        
        emit log_named_address("entrant", gateKeeper.entrant());
    }
}