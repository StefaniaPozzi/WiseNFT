//SPDX License-Idendifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {WiseNFT} from "../src/WiseNFT.sol";

contract WiseNFTDeploy is Script {
    function run() external returns (WiseNFT) {
        vm.startBroadcast();
        WiseNFT wiseNFT = new WiseNFT();
        vm.stopBroadcast();
        return wiseNFT;
    }
}
