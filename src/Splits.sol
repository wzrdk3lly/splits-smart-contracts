// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// contract deployed at 0x1dfB5B91bbbF0F78eF7e8c9A18E69F88Db47E05B
contract Splits {
    // collect the history of an address that performs a split
    mapping(address => uint256) splitsHistory;

    // emit an event that a split was indeed performed
    event splitSuccess(
        address fromAddress,
        address toAddess,
        uint256 etherAmount
    );

    error FailedToSend();
    error InvalidSplit(uint256 valueSent, uint256 halfValue);

    //constructor omited. No variable needed for initialization + no ownership/ fee structure required in its current state
    /**
     * @dev half the balance of the sender will be sent to the toAddress.
     * @param toAddress addrss that the split value will be sent to
     */
    function sendSplit(address payable toAddress) public payable {
        // uint256 halfBalance = (msg.sender.balance); // After the transaction is sent, the balance of the user should have been divided by two.

        // if (msg.value > halfBalance)
        //     // if the value sent exceeds the current balance, we know that more than half was sent.
        //     revert InvalidSplit(msg.value, halfBalance);

        (bool sent, bytes memory data) = toAddress.call{value: msg.value}("");
        if (!sent) revert FailedToSend();

        splitsHistory[msg.sender] += msg.value;

        emit splitSuccess(msg.sender, toAddress, msg.value);
    }

    function getSplitHistory(
        address searchAddress
    ) public view returns (uint256) {
        return splitsHistory[searchAddress];
    }
}
