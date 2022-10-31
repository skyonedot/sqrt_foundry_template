// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ISqrt, INPUT_SIZE} from "src/SqrtChallenge.sol";
import {Fixed18} from "src/Fixed18.sol";

contract MySolution is ISqrt {
        function sqrt(Fixed18[INPUT_SIZE] calldata input) external pure returns (Fixed18[INPUT_SIZE] memory output) {
        for (uint256 i = 0; i < input.length; ++i) {
            Fixed18 z = (input[i].div( Fixed18.wrap(2 * 10 ** 18)));
            Fixed18 y = input[i];
            while (y.gt(z)) {
                y = z;
                z = ((input[i].div(z.mul(Fixed18.wrap(10**36))).add(z))).div(Fixed18.wrap(2 * 10 ** 18));
            }
            output[i] = z.mul(Fixed18.wrap(10**27));
        }
    }
    // function sqrt(Fixed18[INPUT_SIZE] calldata input) external pure returns (Fixed18[INPUT_SIZE] memory output) {
    //     for (uint256 i = 0; i < input.length; ++i) {
    //         Fixed18 z = (input[i].add(Fixed18.wrap(1))).div(Fixed18.wrap(2 ether));
    //         Fixed18 y = input[i];
    //         Fixed18 tem_z;
    //         bool flag = false;
    //         Fixed18 x_again;
    //         Fixed18 y_again;
    //         while (y.gt(z)) {
    //             y = z;
    //             z = ((input[i].div(z.mul(Fixed18.wrap(10**36))).add(z))).div(Fixed18.wrap(2 ether));
    //             tem_z = ((input[i].div(z.mul(Fixed18.wrap(10**36))).add(z))).div(Fixed18.wrap(2 ether));
    //             if ( !z.gt(tem_z)&&  !flag ){
    //                 flag = true;
    //                 x_again = z;
    //                 y_again = y;
    //             }
    //         }
    //         Fixed18 min_distance = Fixed18.wrap(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
    //         Fixed18 min_z;
    //         while ( y_again.gt(x_again) ){
    //             Fixed18 mid = ((x_again.add(y_again)).div(Fixed18.wrap(2 ether)));
    //             if( y_again.mul(Fixed18.wrap(10**36)).mul(y_again).distance(input[i]).lt(x_again.mul(Fixed18.wrap(10**36)).mul(x_again).distance(input[i])) ){
    //                 x_again = mid;
    //                 if ( mid.mul(Fixed18.wrap(10**36)).mul(mid).distance(input[i]).lt( y_again.mul(Fixed18.wrap(10**36)).mul(y_again).distance(input[i]) ) ) {
    //                     if ( mid.mul(Fixed18.wrap(10**36)).mul(mid).distance(input[i]).lt(min_distance) ){
    //                         min_distance = mid.mul(Fixed18.wrap(10**36)).mul(mid).distance(input[i]);
    //                         min_z = mid;
    //                     } else{
    //                         break;
    //                     }
    //                 } else{
    //                     if ( y_again.mul(Fixed18.wrap(10**36)).mul(y_again).distance(input[i]).lt(min_distance) ){
    //                         min_distance = y_again.mul(Fixed18.wrap(10**36)).mul(y_again).distance(input[i]);
    //                         min_z = y_again;
    //                     }else{
    //                         break;
    //                     }
    //                 }
    //             }else{
    //                 y_again = mid;
    //                 if ( mid.mul(Fixed18.wrap(10**36)).mul(mid).distance(input[i]).lt( x_again.mul(Fixed18.wrap(10**36)).mul(x_again).distance(input[i]) ) ) {
    //                     if ( mid.mul(Fixed18.wrap(10**36)).mul(mid).distance(input[i]).lt(min_distance) ){
    //                         min_distance = mid.mul(Fixed18.wrap(10**36)).mul(mid).distance(input[i]);
    //                         min_z = mid;
    //                     }else{
    //                         break;
    //                     }
    //                 } else{
    //                     if ( x_again.mul(Fixed18.wrap(10**36)).mul(x_again).distance(input[i]).lt(min_distance) ){
    //                         min_distance = y_again.mul(Fixed18.wrap(10**36)).mul(x_again).distance(input[i]);
    //                         min_z = x_again;
    //                     }else{
    //                         break;
    //                     }
    //                 }
    //             }
    //             z = min_z;
    //         }
    //         output[i] = z.mul(Fixed18.wrap(10**27));
    //     }
    // }
}