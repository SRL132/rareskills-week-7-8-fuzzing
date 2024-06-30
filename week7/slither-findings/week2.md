## True positives
NFT.withdrawFunds() (src/NFT.sol#189-191) ignores return value by address(msg.sender).call{value: address(this).balance}() (src/NFT.sol#190)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unchecked-low-level-calls

- Should add a check on call success

## False positives
Parameter NFT.setStakingHandler(address)._stakingHandler (src/NFT.sol#104) is not in mixedCase

- This is fine, since using Chainlink pattern

INFO:Detectors:

- This is fine, since using Ownable2Step

NFT.setStakingHandler(address)._stakingHandler (src/NFT.sol#104) lacks a zero-check on :
                - s_stakingHandler = _stakingHandler (src/NFT.sol#105)
RewardToken.setStakingHandler(address)._stakingHandler (src/RewardToken.sol#37) lacks a zero-check on :
                - s_stakingHandler = _stakingHandler (src/RewardToken.sol#41)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation

- This is fine, since there is a check on msg.sender that makes sure the call is done only from a trusted NFT. No complex logic in theevents emitted after the calls

INFO:Detectors:
Reentrancy in StakingHandler.onERC721Received(address,address,uint256,bytes) (src/StakingHandler.sol#85-111):
        External calls:
        - _updateRewards(true) (src/StakingHandler.sol#95)
                - IRewardToken(i_rewardToken).mint(address(this),rewardToMint) (src/StakingHandler.sol#230)
        State variables written after the call(s):
        - s_allStakedTokens.push(_tokenId) (src/StakingHandler.sol#102)
        - s_allStakedTokensIndex[_tokenId] = s_allStakedTokens.length (src/StakingHandler.sol#101)
        - s_ownedStakedTokensIndex[_tokenId] = s_userToStakedTokens[_operator].length - 1 (src/StakingHandler.sol#103-105)
        - s_tokenToStaker[_tokenId] = _operator (src/StakingHandler.sol#97)
        - s_userToAccumulatedRewardDebt[_operator] += s_accRewardPerToken (src/StakingHandler.sol#107)
        - s_userToStakedTokens[_operator].push(_tokenId) (src/StakingHandler.sol#99)

- This is fine because buying is for a given ID and there is a maximum check
INFO:Detectors:
Reentrancy in NFT.buy(uint256) (src/NFT.sol#111-117):
        External calls:
        - _safeMint(msg.sender,_tokenId) (src/NFT.sol#114)
                - IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data) (lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#467-480)
        Event emitted after the call(s):
        - Bought(msg.sender,_tokenId,msg.value) (src/NFT.sol#116)
Reentrancy in NFT.buyAndStake(uint256) (src/NFT.sol#149-156):
        External calls:
        - _safeTransfer(address(this),address(s_stakingHandler),_tokenId) (src/NFT.sol#153)
                - IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data) (lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#467-480)
        Event emitted after the call(s):
        - BoughtAndStaked(msg.sender,_tokenId,msg.value) (src/NFT.sol#155)
Reentrancy in NFT.buyWithDiscount(uint256,uint256,bytes32[]) (src/NFT.sol#124-144):
        External calls:
        - _safeMint(msg.sender,_tokenId) (src/NFT.sol#142)
                - IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data) (lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#467-480)
        Event emitted after the call(s):
        - BoughtWithDiscount(msg.sender,_tokenId,msg.value) (src/NFT.sol#143)
Reentrancy in NFT.buyWithDiscountAndStake(uint256,uint256,bytes32[]) (src/NFT.sol#163-185):
        External calls:
        - _safeTransfer(address(this),address(s_stakingHandler),_tokenId) (src/NFT.sol#182)
                - IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data) (lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#467-480)
        Event emitted after the call(s):
        - BoughtAndStaked(msg.sender,_tokenId,msg.value) (src/NFT.sol#184)

- This is fine because the events have no complex logic and checks-effects-interactions is mostly applied.

Reentrancy in StakingHandler.onERC721Received(address,address,uint256,bytes) (src/StakingHandler.sol#85-111):
        External calls:
        - _updateRewards(true) (src/StakingHandler.sol#95)
                - IRewardToken(i_rewardToken).mint(address(this),rewardToMint) (src/StakingHandler.sol#230)
        Event emitted after the call(s):
        - NFTStaked(_operator,_tokenId,block.number) (src/StakingHandler.sol#109)
Reentrancy in StakingHandler.withdrawNFT(uint256) (src/StakingHandler.sol#135-188):
        External calls:
        - IERC20(i_rewardToken).safeTransfer(msg.sender,amountRewardForOneToken) (src/StakingHandler.sol#183)
        - IERC721(i_nft).safeTransferFrom(address(this),msg.sender,_tokenId) (src/StakingHandler.sol#185)
        Event emitted after the call(s):
        - NFTWithdrawn(msg.sender,_tokenId,block.number) (src/StakingHandler.sol#187)
Reentrancy in StakingHandler.withdrawStakingRewards() (src/StakingHandler.sol#115-131):
        External calls:
        - _updateRewards(false) (src/StakingHandler.sol#116)
                - IRewardToken(i_rewardToken).mint(address(this),rewardToMint) (src/StakingHandler.sol#230)
        - IERC20(i_rewardToken).safeTransfer(msg.sender,withdrawableAmount) (src/StakingHandler.sol#128)
        Event emitted after the call(s):
        - StakingWithdrawn(msg.sender,withdrawableAmount,block.number) (src/StakingHandler.sol#130)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-3