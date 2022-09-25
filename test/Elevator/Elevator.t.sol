// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Elevator } from "../../src/Elevator/Elevator.sol";
import { Building } from "./Building.sol";

contract ElevatorTest is Test {
    Elevator elevator;
    Building building;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        elevator = new Elevator();
    }

    function testElevatorHack() public {
        vm.startPrank(h3x0r);
        building = new Building(address(elevator));
        building.setFloor(100);
        assertTrue(elevator.top());
    }
}