//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HappyNFT} from "../src/HappyNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract HappyNFTDeploy is Script {
    function run() external returns (HappyNFT) {
        string memory happySvg = vm.readFile("img/happy.svg");
        string memory happierSvg = vm.readFile("img/happier.svg");
        vm.startBroadcast();

        HappyNFT happyNFT = new HappyNFT(
            svgToUri(happySvg),
            svgToUri(happierSvg)
        );
        vm.stopBroadcast();
        return happyNFT;
    }

    function svgToUri(string memory svg) public pure returns (string memory) {
        string memory base = "data:image/svg+xml;base64,";
        string memory encoding = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(base, encoding));
    }

    function getHappierSvgURI() public view returns (string memory) {
        return svgToUri(vm.readFile("img/happier.svg"));
    }
}
