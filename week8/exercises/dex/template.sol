// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "dex.sol";

contract Deployer {
    function deployAll()
        public
        returns (address dex, address token1, address token2)
    {
        dex = address(new Dex());
        token1 = address(new SwappableToken(dex, "Token1", "TKN1", 110));
        token2 = address(new SwappableToken(dex, "Token2", "TKN2", 110));

        ERC20(token1).approve(dex, 100);
        ERC20(token2).approve(dex, 100);
        Dex(dex).addLiquidity(token1, 100);
        Dex(dex).addLiquidity(token2, 100);

        ERC20(token1).transfer(address(0x30000), 10);
        ERC20(token2).transfer(address(0x30000), 10);
    }
}
contract EchidnaHandler {
    address dex;
    address token1;
    address token2;

    constructor() public {
        (dex, token1, token2) = (new Deployer()).deployAll();
    }
    //write wrapper functions here
    function swap(address _token1, address _token2, uint256 _amount) public {
        //bound variables here
        //token must be token1 or token2
        //amount must be less than balance of token
        //from to must be allocated according to balance size
        Dex(dex).swap(_token1, _token2, _amount);
    }
    function approve(address _token, address _spender, uint256 _amount) public {
        //bound variables here
        //token must be token1 or token2
        SwappableToken(_token).approve(_spender, _amount);
    }
    function test_dex_is_empty() public {
        //         address token1 = address(ethernautDex.token1());
        //   address token2 = address(ethernautDex.token2());
        //    SwappableToken(token1).approve(hacker, address(ethernautDex), 1 ether);
        //     SwappableToken(token2).approve(hacker, address(ethernautDex), 1 ether);

        //      ethernautDex.swap(token1, token2, 10);
        //      ethernautDex.swap(token2, token1, 20);
        //       ethernautDex.swap(token1, token2, 24);
        //      ethernautDex.swap(token2, token1, 30);
        //       ethernautDex.swap(token1, token2, 40);
        //       ethernautDex.swap(token2, token1, 47);
        assert(
            IERC20(token1).balanceOf(dex) != 0 &&
                ERC20(token2).balanceOf(dex) != 0
        );
    }
}
contract EchidnaTestDex {
    address dex;
    address token1;
    address token2;

    constructor() public {
        (dex, token1, token2) = (new Deployer()).deployAll();
    }

    function test_dex_is_empty() public {
        //         address token1 = address(ethernautDex.token1());
        //   address token2 = address(ethernautDex.token2());
        //    SwappableToken(token1).approve(hacker, address(ethernautDex), 1 ether);
        //     SwappableToken(token2).approve(hacker, address(ethernautDex), 1 ether);

        //      ethernautDex.swap(token1, token2, 10);
        //      ethernautDex.swap(token2, token1, 20);
        //       ethernautDex.swap(token1, token2, 24);
        //      ethernautDex.swap(token2, token1, 30);
        //       ethernautDex.swap(token1, token2, 40);
        //       ethernautDex.swap(token2, token1, 47);
        assert(
            IERC20(token1).balanceOf(dex) != 0 &&
                ERC20(token2).balanceOf(dex) != 0
        );
    }
}
