// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Dex.sol";
import "./openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
//The goal of this level is for you to hack the basic DEX contract below and steal the funds by price manipulation.
//You will start with 10 tokens of token1 and 10 of token2. The DEX contract starts with 100 of each token.
//You will be successful in this level if you manage to drain all of at least 1 of the 2 tokens from the contract, and allow the contract to report a "bad" price of the assets.
contract TestDex is Dex {
    address echidna = msg.sender;
    //requisites
    //hacker starts with 10 tokens of token1 and 10 of token2
    //DEX contract starts with 100 of each token

    //invariant contract balance of at least one of these tokens is 0
    constructor() Dex(echidna) {}

    function echidna_test_balance() public returns (bool) {
        return
            IERC20(Dex(address(this)).token1()).balanceOf(address(this)) == 0 ||
            IERC20(Dex(address(this)).token2()).balanceOf(address(this)) == 0;
    }
}
