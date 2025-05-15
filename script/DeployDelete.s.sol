// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "@forge-std/Script.sol";

import {Delete} from "src/Delete.sol";

contract DeployDelete is Script {
    function run() external returns (Delete) {
        vm.startBroadcast();
        Delete deleteContract = new Delete();
        vm.stopBroadcast();
        return deleteContract;
    }
}
