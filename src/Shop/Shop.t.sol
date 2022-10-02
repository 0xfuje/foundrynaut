// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import { Buyer } from "./Buyer.sol";
import { Shop } from "./Shop.sol";

contract ShopTest is Test {
    Shop shop;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        shop = new Shop();
    }

    function testShopHack() public {
        Buyer buyer = new Buyer(address(shop));
        buyer.buy();

        assertEq(shop.price(), 1);
    }
}