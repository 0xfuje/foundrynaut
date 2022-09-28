// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Solver {
    function whatIsTheMeaningOfLife() external view returns (bytes32) {
        assembly {
            let res := 0x000000000000000000000000000000000000000000000000000000000000002a
        }
    }
}