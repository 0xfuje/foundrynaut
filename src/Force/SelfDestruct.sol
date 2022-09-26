// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract SelfDestruct {
    function suicideSend(address _address) public {
        selfdestruct(payable(_address));
    }

    receive() external payable {}
}