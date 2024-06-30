// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Dex.sol";
import "./openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "./Setup.sol";
//The goal of this level is for you to hack the basic DEX contract below and steal the funds by price manipulation.
//You will start with 10 tokens of token1 and 10 of token2. The DEX contract starts with 100 of each token.
//You will be successful in this level if you manage to drain all of at least 1 of the 2 tokens from the contract, and allow the contract to report a "bad" price of the assets.
contract TestDex is Setup, Dex {
    //Hint: Echidna uses what addresses as msg.sender by default? How many are needed? Can we speed up the fuzzing by changing this number?
    address echidna = msg.sender;

    //requisites
    //hacker starts with 10 tokens of token1 and 10 of token2
    //DEX contract starts with 100 of each token

    //invariant contract balance of at least one of these tokens is 0
    constructor()
        Dex(echidna)
        Setup(address(token1), address(token2), echidna)
    {
        //Hint: The contract will need to renounce ownership of the dex it creates, otherwise it would be cheating to hack a contract you have ownership over
    }

    function echidna_test_balance() public returns (bool) {
        return
            IERC20(Dex(address(this)).token1()).balanceOf(address(this)) == 0 ||
            IERC20(Dex(address(this)).token2()).balanceOf(address(this)) == 0;
    }

    function echidna_test_provided_liquidity() public returns (bool) {
        if (!completed) {
            _mintTokens();
        }

        uint256 lpTokenBalanceBefore = pair.balanceOf(address(echidna));
        uint256 playerToken1BalanceBefore = token1.balanceOf(player);
        uint256 playerToken2BalanceBefore = token2.balanceOf(player);

        (
            uint256 token1BalanceBefore,
            uint256 token2BalanceBefore
        ) = getLiquidity();
        //(bool success, ) = user.proxy(address(testToken1)).abi.encodeWithSelector(testToken1, transfer.selector, address(pair));
        //(bool success2, ) = user.proxy(address(testToken2)).abi.encodeWithSelector(testToken2, transfer.selector, address(pair));
        require(success1 && success2, "Transfer failed");
    }

    //Hint: Rather than checking if you completely drained the contract, maybe check if the pool has a lot less liquidity than expected? This will make it easier to find the exploit
}
