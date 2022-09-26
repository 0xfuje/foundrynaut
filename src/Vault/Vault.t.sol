// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Vault } from "../../src/Vault/Vault.sol";

contract VaultTest is Test {
    Vault vault;
    string password = vm.envString("VAULT_PASSWORD");

    string mainnetUrl = vm.envString("MAINNET_URL");
    uint256 mainnetFork = vm.createFork(mainnetUrl);

    address h3x0r = vm.addr(1337);

    /* function getPw() internal returns (bytes32 value) {
        assembly {
            value := sload(1)
        }
    }

    function setUp() public {
        vm.selectFork(mainnetFork);
        vault = new Vault(bytes32(bytes(password)));

    } */
}