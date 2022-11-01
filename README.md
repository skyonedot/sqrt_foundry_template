
两个方法, 核心都是牛顿法迭代公式, 初值选取的不一样

- 第一个方法就是 main branch里面的 src/MySolution.sol

    > 初值的选取是看位数, 取位数/2的一个值

    > 单纯求平方根的Gas的Cost在10w左右

    > 这个初值的选取是参考别人的, 比我想出来的简单/2取得的效果更好

- 第二个方法是 feature/original branch 里面的 src/MySolution.sol

    > 初值的选取是 原始值/2
    
    > 单纯求平方根的Gas的Cost在16w左右

```bash
forge test --use ./bin/solc
forge test --use ./bin/solc --rpc-url $RPC -vvvv
```

---

<img align="right" width="150" height="150" top="100" src="./assets/sqrt.svg">

# Optimizor Club SQRT challenge

This repo provides a Foundry template to write solutions for the Optimizor Club
SQRT challenge.

In the SQRT problem your contract is given an array of Fixed18 numbers, and it
must return the square root of each number with an error margin of 10^-5.
The challenge contract can be found at
[0x2747096ff9e0fce877cd168dcd5de16040a4ab85](https://etherscan.io/address/0x2747096ff9e0fce877cd168dcd5de16040a4ab85#code#F3#L1).

The interface that your solution contract must have can be represented by the
Solidity interface below. Function `sqrt` will be called by the challenge
contract when you make a challenge.

```solidity
interface ISqrt {
    function sqrt(Fixed18[INPUT_SIZE] calldata) external view returns (Fixed18[INPUT_SIZE] memory);
}
```

You only need to modify contract `MySolution` in `MySolution.sol` with your
code, or of write write one from scratch in your preferred language.  The tests
will run the challenge against your contract on multiple random seeds.

## Test

Since your solution must not have the metadata hash that `solc` adds to the
bytecode, we need to use a pre-release of `solc` 0.8.18 and use the option
`cbor_metadata = false` which you can see in `foundry.toml`.

To test only your solution:

```bash
$ forge test --use ./bin/solc
```

To test the full workflow including commit and challenge against the mainnet
contracts:

```bash
$ forge test --use ./bin/solc --rpc-url $RPC_URL
```
