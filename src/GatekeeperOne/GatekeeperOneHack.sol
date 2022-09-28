// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { GatekeeperOne } from "./GatekeeperOne.sol";

contract Hack {
    GatekeeperOne gatekeeper;

    event LogGas(string description, uint gasLeft);

    constructor(address _gatekeeperAddress) {
        gatekeeper = GatekeeperOne(_gatekeeperAddress);
    }

    function enterGate(bytes8 _gateKey) public {
        emit LogGas("gas before", gasleft());
        gatekeeper.enter(_gateKey);
        emit LogGas("gas after", gasleft());
    }
} 