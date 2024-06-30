// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./openzeppelin-contracts/contracts/mocks/token/ERC20Mock.sol";
contract Setup {
    ERC20Mock public token1;
    ERC20Mock public token2;
    address public player;
    bool completed;

    constructor(address _token1, address _token2, address _player) public {
        token1 = new ERC20Mock();
        token2 = new ERC20Mock();
        player = _player;
        token1.mint(msg.sender, 100);
        token2.mint(msg.sender, 100);
        token1.mint(_player, 10);
        token2.mint(_player, 10);
    }
    //only if constructor doesn t do this
    function _mintTokens() internal {
        token1.mint(player, 10);
        token2.mint(player, 10);
        completed = true;
    }

    function _between(
        uint256 value,
        uint256 low,
        uint256 high
    ) internal pure returns (uint256) {
        return low + (value % (high - low + 1));
    }
}
