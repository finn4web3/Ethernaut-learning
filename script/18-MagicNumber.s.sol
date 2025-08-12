// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IMagicNum {
    function setSolver(address _solver) external;
}

contract MagicNumSolution is Script {
    function run() external {
        // 从环境变量读取私钥
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // 关卡合约地址（替换成你的实例地址）
        address magicNumAddress = 0xC8657bb29b9DED1780867e750CF2a9e95A5f9CFf;

        vm.startBroadcast(deployerPrivateKey);

        // 10 字节 runtime bytecode: 返回 42
        // 602a60005260206000f3
        bytes memory runtimeCode = hex"69602a60005260206000f3600052600a6016f3";

        address solver;
        assembly {
            // create(value, offset, size)
            // offset 要跳过 bytes 数组的长度字段（前 0x20 字节）
            solver := create(0, add(runtimeCode, 0x20), mload(runtimeCode))
        }

        require(solver != address(0), "Create failed");

        console.log("Solver deployed at:", solver);

        // 调用 setSolver
        IMagicNum(magicNumAddress).setSolver(solver);

        vm.stopBroadcast();
    }
}

// https://www.evm.codes/playground
// https://stermi.xyz/blog/ethernaut-challenge-18-solution-magic-number
// https://solidity-by-example.org/app/simple-bytecode-contract/

/*
Run time code - return 42
602a60005260206000f3

// Store 42 to memory
PUSH1 0x2a
PUSH1 0
MSTORE

// Return 32 bytes from memory
PUSH1 0x20
PUSH1 0
RETURN

Creation code - return runtime code
69602a60005260206000f3600052600a6016f3

// Store run time code
PUSH10 0X602a60005260206000f3
PUSH1 0
MSTORE

// Return 10 bytes from memory starting at offset 22
PUSH1 0x0a
PUSH1 0x16
RETURN*/