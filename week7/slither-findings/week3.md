## True positives
- The "from" is an external address and the "to" is the contract, there is also a success check. This pattern is also applied for flashLoan functions at times https://www.rareskills.io/post/erc-3156 , but it can certainly open possibilities for strange behaviours (initiating a loan and letting another account that you know has allowance to pay back for it)

INFO:Detectors:
Pair.flashLoan(IERC3156FlashBorrower,address,uint256,bytes) (src/Pair.sol#158-212) uses arbitrary from in transferFrom: success = IERC20(_token).transferFrom(address(_receiver),address(this),_amount + fee) (src/Pair.sol#196-200)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#arbitrary-from-in-transferfrom

- Same Interface exists twice
INFO:Detectors:
IERC20 is re-used:
        - IERC20 (lib/forge-std/src/interfaces/IERC20.sol#6-43)
        - IERC20 (src/interfaces/IERC20.sol#4-25)
IERC721TokenReceiver is re-used:
        - IERC721TokenReceiver (lib/forge-std/src/interfaces/IERC721.sol#105-121)
        - IERC721TokenReceiver (lib/forge-std/src/mocks/MockERC721.sol#233-235)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#name-reused

- This is true but has limited impact, since it doesn t impact randomness and would only affect in a small percentage at most
INFO:Detectors:
Pair._update(uint256,uint256,uint112,uint112) (src/Pair.sol#397-425) uses a weak PRNG: "blockTimestamp = uint32(((block.timestamp % (type()(uint32).max)) + 1)) (src/Pair.sol#404-406)" 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#weak-PRNG

## False positives

- NonReentrant is being applied, and at the end of the state-changing functions there is an _update function that not only updates the balances but also implements a very powerful check to make sure the invariant x * y >= k always holds true

INFO:Detectors:
Reentrancy in Pair.flashLoan(IERC3156FlashBorrower,address,uint256,bytes) (src/Pair.sol#158-212):
        External calls:
        - data = _receiver.onFlashLoan(msg.sender,_token,_amount,fee,_data) (src/Pair.sol#184-190)
        - success = IERC20(_token).transferFrom(address(_receiver),address(this),_amount + fee) (src/Pair.sol#196-200)
        State variables written after the call(s):
        - _update(balance0,balance1,reserve0,reserve1) (src/Pair.sol#209)
                - s_reserve0 = uint112(_balance0) (src/Pair.sol#419)
        Pair.s_reserve0 (src/Pair.sol#42) can be used in cross function reentrancies:
        - Pair.getReserves() (src/Pair.sol#361-368)
        - _update(balance0,balance1,reserve0,reserve1) (src/Pair.sol#209)
                - s_reserve1 = uint112(_balance1) (src/Pair.sol#420)
        Pair.s_reserve1 (src/Pair.sol#43) can be used in cross function reentrancies:
        - Pair.getReserves() (src/Pair.sol#361-368)
Reentrancy in Pair.swap(uint256,address,uint256,Pair.ReceiverAndDeadline) (src/Pair.sol#259-313):
        External calls:
        - amountIn = _swapTokens(_tokenOut,swapCache.tokenIn,_receiverAndDeadline.receiver,_amountOut,_maximumAmountIn,swapCache.referenceReserveIn,swapCache.referenceReserveOut) (src/Pair.sol#288-296)
                - success = IERC20(_tokenIn).transferFrom(msg.sender,address(this),amountIn) (src/Pair.sol#645-649)
        State variables written after the call(s):
        - _calculateAndValidateBalances(swapCache.amount0Out,swapCache.amount1Out,reserve0,reserve1) (src/Pair.sol#298-303)
                - s_reserve0 = uint112(_balance0) (src/Pair.sol#419)
        Pair.s_reserve0 (src/Pair.sol#42) can be used in cross function reentrancies:
        - Pair.getReserves() (src/Pair.sol#361-368)
        - _calculateAndValidateBalances(swapCache.amount0Out,swapCache.amount1Out,reserve0,reserve1) (src/Pair.sol#298-303)
                - s_reserve1 = uint112(_balance1) (src/Pair.sol#420)
        Pair.s_reserve1 (src/Pair.sol#43) can be used in cross function reentrancies:
        - Pair.getReserves() (src/Pair.sol#361-368)

- It is strict equality to 0 and there are no negative and straight decimal numbers in solidity

INFO:Detectors:
Pair._burnAndUpdate(uint256,address,Pair.MinAmounts) (src/Pair.sol#709-756) uses a dangerous strict equality:
        - amount0 == 0 && amount1 == 0 (src/Pair.sol#731)
Pair._calculateAndValidateBalances(uint256,uint256,uint112,uint112) (src/Pair.sol#581-618) uses a dangerous strict equality:
        - amount0In == 0 && amount1In == 0 (src/Pair.sol#602)
Pair._mintAndUpdate(address,uint256) (src/Pair.sol#660-703) uses a dangerous strict equality:
        - liquidity == 0 (src/Pair.sol#687)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dangerous-strict-equalities