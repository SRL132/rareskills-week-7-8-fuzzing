Mutation testing report:
Number of mutations:    52
Killed:                 41 / 52
Lived: 8

Mutations:
#### 1-Helped me detect issues in the math logic
Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/StakingHandler.sol
    Line nr: 150
    Result: Lived
    Original line:
                 s_userToAccumulatedRewardDebt[msg.sender] += amountRewardForOneToken;

    Mutated line:
                 s_userToAccumulatedRewardDebt[msg.sender] -= amountRewardForOneToken;

Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/StakingHandler.sol
    Line nr: 147
    Result: Lived
    Original line:
                 uint256 amountRewardForOneToken = s_accRewardPerToken -

    Mutated line:
                 uint256 amountRewardForOneToken = s_accRewardPerToken + (s_userToAccumulatedRewardDebt[msg.sender] / amountStaked);


Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/StakingHandler.sol
    Line nr: 148
    Result: Lived
    Original line:
                     (s_userToAccumulatedRewardDebt[msg.sender] / amountStaked);

    Mutated line:
                     (s_userToAccumulatedRewardDebt[msg.sender] * amountStaked);

#################################################

#### 2-Helped me detect issues in the discount limitations, and helped me to make it more restrictive
Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/NFT.sol
    Line nr: 69
    Result: Lived
    Original line:
                 if (_index > PROMISED_AMOUNT) {

    Mutated line:
                 if (_index >= PROMISED_AMOUNT) {

#################################################

#### 3-Helped me detect missing testing in terms of access control

Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/NFT.sol
    Line nr: 103
    Result: Lived
    Original line:
             function setStakingHandler(address _stakingHandler) external onlyOwner {

    Mutated line:
             function setStakingHandler(address _stakingHandler) external  {
#################################################

#### 4-Helped me find what was missing in the test line coverage, accelerating the process considerably 

Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/NFT.sol
    Line nr: 150
    Result: Lived
    Original line:
             ) external payable applyBuyChecks(_tokenId, REGULAR_PRICE) {

    Mutated line:
             ) external payable  {


Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/NFT.sol
    Line nr: 169
    Result: Lived
    Original line:
                 applyBuyChecks(_tokenId, REDUCED_PRICE)

    Mutated line: 
                 

Mutation:
    File: /Users/sergirocalaguna/Desktop/dev/rareskills-week-2/contracts/contract-1-smart-contract-ecosystem/src/NFT.sol
    Line nr: 170
    Result: Lived
    Original line:
                 applyDiscountChecks(_index, _proof)

    Mutated line:

#################################################