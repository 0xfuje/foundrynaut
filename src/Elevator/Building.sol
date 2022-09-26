// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import { Elevator } from "../../src/Elevator/Elevator.sol";

contract Building {
    Elevator elevator;
    bool public toggle = true;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function isLastFloor(uint) external returns (bool) {
        toggle = !toggle;
        return toggle;
    }

    function setFloor(uint _floor) public {
        elevator.goTo(_floor);
    }
}