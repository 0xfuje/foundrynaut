// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { MagicNum } from "./MagicNum.sol";

interface Solver {
    function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumTest is Test {
    MagicNum magicNum;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        magicNum = new MagicNum();
    }

    function testMagicNumHack() public {
        vm.startPrank(h3x0r);

         // INIT CODE
        // 600a -- push 10 (runtime code size)
        // 600c -- push 12 (runtime code start byte)
        // 6000 -- push 0 (memory address to copy to)
        // 39   -- codecopy
        // 600a -- push amount of bytes to return
        // 6000 -- memory address to start returning from
        // f3   -- return 
        // RUNTIME CODE
        // 602a -- push value to return (42 in decimal)
        // 6080 -- push mem address to store
        // 52   -- mstore
        // 6020 -- push number of bytes to return
        // 6080 -- push mem address to return
        // f3   -- return

        uint size;
        bytes memory solverCode = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solverAddress;
        assembly {
          solverAddress := create(0, add(solverCode, 0x20), mload(solverCode))
          if iszero(extcodesize(solverAddress)) {
            revert(0, 0)
          }
        }

        assembly {
            size := extcodesize(solverCode)
        }
        assertLt(size, 11, "solver has to be max 10 bytes");

        magicNum.setSolver(solverAddress);
        bytes32 meaning = Solver(solverAddress).whatIsTheMeaningOfLife();
        emit log_bytes32(meaning);
        assertEq(meaning, 0x000000000000000000000000000000000000000000000000000000000000002a);
    }
}