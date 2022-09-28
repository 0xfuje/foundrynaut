// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { MagicNum } from "./MagicNum.sol";
import { Solver } from "./Solver.sol";

contract MagicNumTest is Test {
    MagicNum magicNum;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        magicNum = new MagicNum();
    }

    function testMagicNumHack() public {
        vm.startPrank(h3x0r);
        Solver solver = new Solver();
        magicNum.setSolver(address(solver));

        uint256 size;
        assertEq(
            solver.whatIsTheMeaningOfLife(),
            0x000000000000000000000000000000000000000000000000000000000000002a,
            "solver has to return 42 converted to bytes32"
        );
        assembly {
            size := extcodesize(solver)
        }
        assertLt(size, 11, "solver has to be max 10 opcodes");
    }
}