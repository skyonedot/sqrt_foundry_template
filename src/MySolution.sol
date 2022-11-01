// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ISqrt, INPUT_SIZE} from "src/SqrtChallenge.sol";
import {Fixed18} from "src/Fixed18.sol";

contract MySolution is ISqrt {
        function sqrt(Fixed18[INPUT_SIZE] calldata input) external pure returns (Fixed18[INPUT_SIZE] memory output) {
        for (uint256 i = 0; i < input.length; ++i) {
            unchecked{
                Fixed18 tmp_a = input[i];
                Fixed18 y = input[i];
                uint256 msb = 0;
                uint256 xc = Fixed18.unwrap(tmp_a);
                if (xc >= 0x10000000000000000) { xc >>= 64; msb += 64; }
                if (xc >= 0x100000000) { xc >>= 32; msb += 32; }
                if (xc >= 0x10000) { xc >>= 16; msb += 16; }
                if (xc >= 0x100) { xc >>= 8; msb += 8; }
                if (xc >= 0x10) { xc >>= 4; msb += 4; }
                if (xc >= 0x4) { xc >>= 2; msb += 2; }
                if (xc >= 0x2) msb += 1;
                Fixed18 val = Fixed18.wrap(uint256(1) << uint256(18 + msb/2));
                while(y.gt(val)){
                    y = val;
                    val = tmp_a.div(val.mul(Fixed18.wrap(10**36))).add(val).div(Fixed18.wrap(2 ether));
                }
                output[i] = val.mul(Fixed18.wrap(10**27));
            }
        }
    }
}