//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {WiseNFT} from "../src/WiseNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintProgrammatically is Script {
    string public constant GUINEA_PIG_1_JSON_URI =
        "ipfs://bafybeifaw42cxz324ixzcwm7v6nhpyvb373e6cgs4nlhea6jisbi6cn6qy/?filename=guineaPig1.json";

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "WiseNFT",
            block.chainid
        );
        vm.startBroadcast();
        WiseNFT(mostRecentDeployment).mintToken(GUINEA_PIG_1_JSON_URI);
        vm.stopBroadcast();
    }
}
