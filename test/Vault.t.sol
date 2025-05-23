// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    address user = makeAddr("user");

    function setUp() public {
        // TODO: instantiate new instance of the Vault contract
        vault = new Vault();

        // TODO: Fund the user with some ether using vm.deal
        vm.deal(user, 16 ether);
    }

    function testDeposit() public {
        // TODO: prank user and call deposit with 1 ether
        vm.startPrank(user);
        vault.deposit{value: 1 ether}();
        vm.stopPrank();

        assertEq(vault.balances(user), 1 ether);
    }

    function testWithdraw() public {
        // TODO: prank user, deposit 2 ether, withdraw 1 ether
        vm.startPrank(user);
        vault.deposit{value: 2 ether}();
        vault.withdraw(1 ether);
        vm.stopPrank();

        assertEq(vault.balances(user), 1 ether);
    }

    function test_RevertWithdrawMoreThanBalance() public {
        // TODO: prank user, deposit 1 ether
        vm.startPrank(user);
        vault.deposit{value: 1 ether}();
        vm.expectRevert();
        vault.withdraw(2 ether);
        vm.stopPrank();

        // TODO: try to withdraw 2 ether
    }

    function testGetBalance() public {
        // TODO: prank user, deposit 0.5 ether, check getBalance
        // TODO: assert returned balance is 0.5 ether
        vm.startPrank(user);
        vault.deposit{value: 0.5 ether}();
        uint256 b = vault.getBalance();
        vm.stopPrank();
        assertEq(b, 0.5 ether);
    }

    // Added test functions
    function test_RevertDepositforZeroDeposited() public {
        vm.startPrank(user);
        vm.expectRevert();
        vault.deposit{value: 0 ether}();
        vm.stopPrank();
    }
}
