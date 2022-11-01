// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";

import {ISqrt, SqrtChallenge, INPUT_SIZE} from "src/SqrtChallenge.sol";
import {Fixed18} from "src/Fixed18.sol";
import {MySolution} from "src/MySolution.sol";
import {IOptimizor, OPTIMIZOR_MAINNET} from "src/IOptimizor.sol";
import {computeKey} from "src/CommitHash.sol";

interface IPurityChecker {
    /// @return True if the code of the given account satisfies the code purity requirements.
    function check(address account) external view returns (bool);
}

contract MySolutionTest is Test {
    SqrtChallenge challenge;
    uint constant SQRT_ID = 1;
    MySolution sqrt;
    // Change accordingly.
    uint constant currentLeaderGas = 1000000;

    // Change accordingly.
    uint constant SEED = 14231;
    // Change accordingly.
    uint constant SALT = 0;
    // Change accordingly.
    address constant MY_ADDRESS = address(0xcafe);

    function setUp() public {
        sqrt = new MySolution();
        challenge = new SqrtChallenge();
    }

    function testSpecificSeed() public {
        testWithSeed(SEED);
    }

    function testFuzzSeed(uint seed) public {
        testWithSeed(seed);
    }

    function testEndToEnd() public {
        OPTIMIZOR_MAINNET.commit(computeKey(MY_ADDRESS, address(sqrt).codehash, SALT));
        vm.roll(block.number + 100);
        OPTIMIZOR_MAINNET.challenge(SQRT_ID, address(sqrt), MY_ADDRESS, SALT);
    }

    event LogInfo(string info, bytes32 data);
    function testWithSeed(uint seed) internal {
        emit LogInfo("Here1", computeKey(address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8), address(0xa85b028984bC54A2a3D844B070544F59dDDf89DE).codehash, SALT));
        emit LogInfo("CodeHash", address(0xa85b028984bC54A2a3D844B070544F59dDDf89DE).codehash);

        Fixed18[INPUT_SIZE] memory input;
        for (uint i = 0; i < INPUT_SIZE; ++i) {
            input[i] = Fixed18.wrap(i);
        }

        uint gasSpent = challenge.run(address(sqrt), seed);
        assertTrue(gasSpent < currentLeaderGas);
    }

    function testPurity() public {
        IPurityChecker checker = IPurityChecker(0x5C71fcd090948dCC5E8A1a01ad8Fa26313422022);
        assertTrue(checker.check(address(sqrt)));
    }
}
