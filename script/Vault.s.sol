// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/Vault/Vault.sol";

contract DeployVault is Script, Test {
    function run() external {
        string memory password = "extremely_secret_password_123";

        vm.startBroadcast();

        Vault vault = new Vault(bytes32(bytes(password)));
        emit log_address(address(vault));
        
        vm.stopBroadcast();
    }
}