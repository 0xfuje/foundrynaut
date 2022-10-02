// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import { Recovery, SimpleToken } from "./Recovery.sol";

contract RecoveryTest is Test {
    Recovery recovery;

    mapping (address => address) lostAddress;

    address deployer = vm.addr(777);
    address h3x0r = vm.addr(1337);

    function setUp() public {
        deal(deployer, 0.001 ether);
        vm.startPrank(deployer);
        recovery = new Recovery();
        recovery.generateToken("InitialToken", 100000);
        lostAddress[address(recovery)] = address(uint160(uint256(keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), recovery, uint8(0x01))))));
        (bool result, ) = lostAddress[address(recovery)].call{value: 0.001 ether}("");
        assertEq(lostAddress[address(recovery)].balance, 0.001 ether);
        assertTrue(result);
        vm.stopPrank();
    }

    function testRecoveryHack() public {
        vm.startPrank(deployer);
        // used foundry test logs to find out simpletoken address
        // i could look up etherscan if i deploy on-chain
        // is this cheating?
        address payable simpleTokenAddress = payable(address(0x9Dfdc6254d34A6899a9057d11978D9C2d8081FCF));
        
        SimpleToken(simpleTokenAddress).destroy(payable(deployer));
        assertEq(deployer.balance, 0.001 ether);
    }
}