// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Utilities} from "./utils/utitlites.sol";
import {Splits} from "../src/Splits.sol";

contract splits is Test {
    Utilities internal utils;
    Splits internal splitsContract;

    address payable user1;
    address payable user2;

    function setUp() public {
        utils = new Utilities();

        address payable[] memory users = utils.createUsers(2);

        user1 = users[0];
        user2 = users[1];

        splitsContract = new Splits();
    }

    function testSplit() public {
        uint256 user1HalfBalance = user1.balance / 2;

        vm.prank(user1);
        splitsContract.sendSplit{value: user1HalfBalance}(user2);

        uint256 user1NewBalance = user1.balance;

        assertEq(user1HalfBalance, user1NewBalance);
    }

    function testInvalidSplit() public {
        uint256 user1MoreThanHalf = (user1.balance / 2) + 1;

        vm.expectRevert();
        vm.prank(user1);
        splitsContract.sendSplit{value: user1MoreThanHalf}(user2);

        uint256 user1NewBalance = user1.balance;
    }
}
