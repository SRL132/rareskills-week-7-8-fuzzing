// SPDX-License-Identifier: MIT
pragma solidity ^0.4.25;
import "./TokenWhaleChallenge.sol";

contract TestTokenWhaleChallenge is TokenWhaleChallenge {
    address echidna = msg.sender;

    constructor() TokenWhaleChallenge(echidna) {}

    function echidna_test_balance() public view returns (bool) {
        return !TokenWhaleChallenge(address(this)).isComplete();
    }
}
