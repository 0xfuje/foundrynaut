// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { NaughtCoin } from "./NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin coin;

    address deployer = vm.addr(123);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        vm.prank(deployer);
        coin = new NaughtCoin(deployer);
        deal(h3x0r, 1 ether);
    }
}