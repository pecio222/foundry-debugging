// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import "forge-std/Script.sol";

import {ILBRouter} from "joe-v2/src/interfaces/ILBRouter.sol";
import {IERC20} from "joe-v2/src/LBPair.sol";

// import {StdCheats} from "forge-std/StdCheats.sol";

contract TestSwap is Script {
    ILBRouter router =
        ILBRouter(payable(0xb4315e873dBcf96Ffd0acd8EA43f689D8c20fB30));

    string chain;
    ILBRouter.Path path;

    function setUp() public {}

    function run() public {
        chain = "avalanche"; // arbitrum_one
        address user = 0x4168F81F7720A78415f6e5E8370B5Efd7E6c500f;
        address tokenIn = 0x3c6290a21344596589F883969e80A5c51DEF88e2;
        address tokenOut = 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7; //WAVAX
        // 0 for v1 pairs
        uint16 pairBinStep = 0;
        console.log("user", user);

        vm.createSelectFork(getChain(chain).rpcUrl);
        uint256 balanceIn = IERC20(tokenIn).balanceOf(user);
        console.log("balanceIn", balanceIn);

        vm.startPrank(user);

        // below line can be commented out to check, if approval isn't a problem
        IERC20(tokenIn).approve(address(router), type(uint256).max);

        path = _buildPath(tokenIn, tokenOut, pairBinStep);
        uint256 balanceBefore = IERC20(tokenOut).balanceOf(user);
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            balanceIn,
            0,
            path,
            user,
            block.timestamp + 10000
        );
        uint256 balanceOut = IERC20(tokenOut).balanceOf(user);
        console.log(
            "balanceOut",
            balanceOut - balanceBefore,
            (balanceOut - balanceBefore) / 1e18
        );
    }

    function _buildPath(
        address tokenIn,
        address tokenOut,
        uint16 binStep
    ) private pure returns (ILBRouter.Path memory path) {
        path.pairBinSteps = new uint256[](1);
        path.pairBinSteps[0] = binStep;

        path.versions = new ILBRouter.Version[](1);
        //assumes that we use either v1 or v2.1, ignores v2 pairs
        if (binStep == 0) {
            path.versions[0] = ILBRouter.Version.V1;
        } else {
            path.versions[0] = ILBRouter.Version.V2_1;
        }
        path.tokenPath = new IERC20[](2);
        path.tokenPath[0] = IERC20(tokenIn);
        path.tokenPath[1] = IERC20(tokenOut);
    }
}
