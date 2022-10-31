// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ISqrt, INPUT_SIZE} from "src/SqrtChallenge.sol";
import {Fixed18} from "src/Fixed18.sol";

contract MySolution is ISqrt {
        function sqrt(Fixed18[INPUT_SIZE] calldata input) external pure returns (Fixed18[INPUT_SIZE] memory output) {
        for (uint256 i = 0; i < input.length; ++i) {
            Fixed18 z = input[i].div(Fixed18.wrap(2 * 10 ** 18));
            Fixed18 y = input[i];
            while (y.gt(z)) {
                y = z;
                z = input[i].div( z.mul(Fixed18.wrap(10**36))).add(z).div(Fixed18.wrap(2 * 10 ** 18));
            }
            output[i] = z.mul(Fixed18.wrap(10**27));
        }
    }
}