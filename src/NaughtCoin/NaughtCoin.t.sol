// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { NaughtCoin } from "./NaughtCoin.sol";
import { NaughtCoinHack } from "./NaughtCoinHack.sol";

contract NaughtCoinTest is Test {
    NaughtCoin coin;
    NaughtCoinHack hack;

    address deployer = vm.addr(123);
    address fren = vm.addr(420);

    function setUp() public {
        vm.prank(deployer);
        coin = new NaughtCoin(deployer);
    }

    function testNaughtCoinHack() public {
        vm.startPrank(deployer);
        hack = new NaughtCoinHack(address(coin));
        coin.approve(address(hack), coin.balanceOf(deployer));
        hack.transfer(deployer, fren);

        assertEq(coin.balanceOf(fren), 1000000 * 1e18);
    }
}