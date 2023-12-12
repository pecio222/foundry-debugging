/// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract AnyTx is Script {
    address target_address;
    address user;
    bytes data;
    string rpcAlias;

    function run() external {
        user = 0x024167ea2E03A89daD390fEE8b729A891bf2A712;
        // target_address = 0x60aE616a2155Ee3d9A68541Ba4544862310933d4; //joe router v1
        target_address = 0x46bA84780f9a7b34C8B0E24Df07a260Fa952195D; //joe-limit-manager
        rpcAlias = "avalanche";

        // example 1 - removeLiquidityAVAX, for Joe Router V1
        // data = abi.encodeWithSignature(
        //     "removeLiquidityAVAX(address,uint256,uint256,uint256,address,uint256)",
        //     0xEE07f26fAa4AaE833F9002Df9036C439302c0946,
        //     53772255749516,
        //     0,
        //     0,
        //     user,
        //     block.timestamp + 100000
        // );

        // example 2 - cancelOrder for joe-limit-order contract
        data = abi.encodeWithSignature(
            "cancelOrder(address,address,uint16,uint8,uint24,uint256,uint256)",
            0xa77e70d0Af1Ac7fF86726740dB1Bd065c3566937, //tokenX
            0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E, //tokenY
            100, //binStep
            1, //order type
            8385354, //bin id
            0,
            0
        );
        vm.startPrank(user, user);
        vm.createSelectFork(getChain(rpcAlias).rpcUrl);
        (bool result, ) = target_address.call(data);
        require(result, "call failed");
    }
}
