// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Hack } from "./GoodSamaritanHack.sol";
import { GoodSamaritan, Coin, Wallet, INotifyable } from "./GoodSamaritan.sol";

contract GoodSamaritanTest is Test {
    GoodSamaritan gs;
    Coin coin;
    Wallet wallet;
    Hack hack;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        gs = new GoodSamaritan();
        coin = gs.coin();
        wallet = gs.wallet();
        assertEq(coin.balances(address(wallet)), 10 ** 6);
    }

    function testGoodSamaritanHack() public {
        vm.startPrank(h3x0r);
        hack = new Hack(address(gs), address(coin), h3x0r);
        hack.pwn();
        assertEq(coin.balances(h3x0r), 10 ** 6);
    }
}