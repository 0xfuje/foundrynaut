// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { GatekeeperTwo } from "./GatekeeperTwo.sol";

contract Hack {
    constructor(
        address _gatekeeperAddress,
        uint64 _gateKey
    ) {
        GatekeeperTwo(_gatekeeperAddress).enter(bytes8(_gateKey));
    }
}