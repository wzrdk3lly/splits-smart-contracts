// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Splits {
    // collect the history of an address that performs a split
    mapping(address => uint256[]) splitsHistory;

    // emit an event that a split was indeed performed

    event splitSuccess(
        address fromAddress,
        address toAddess,
        uint256 etherAmount
    );

    //constructor omited. No variable needed for initialization + no ownership/ fee structure required it its current state
}
