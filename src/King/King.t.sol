// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { King } from "../../src/King/King.sol";
import { HackKing } from "./HackKing.sol";

contract KingTest is Test {
    King king;

    address h3x0r = vm.addr(1337);
    address deployer = vm.addr(1);

    function setUp() public {
        deal(deployer, 20 ether);
        deal(h3x0r, 9 ether);
        vm.prank(deployer);
        king = new King{value: 3 ether}();
    }

    function testKingHack() public {
        vm.startPrank(h3x0r);
        HackKing hack = new HackKing(address(king));

        emit log_named_address("h3x0r", h3x0r);
        emit log_named_address("deployer", deployer);
        emit log_named_address("hack contract", address(hack));

        payable(address(king)).call{value: 4 ether}("");
        assertEq(king._king(), h3x0r);
        
        payable(address(hack)).call{value: 5 ether}("");
        vm.stopPrank();

        emit log_named_address("new king is", king._king());
        assertEq(king._king(), address(hack));
        
        vm.prank(deployer);
        payable(address(king)).call{value: 6 ether}("");
        assertEq(king._king(), address(hack));
    }
}