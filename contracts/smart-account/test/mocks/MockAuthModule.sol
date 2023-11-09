// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import {BaseAuthorizationModule} from "../../modules/BaseAuthorizationModule.sol";
import {UserOperation} from "@account-abstraction/contracts/interfaces/UserOperation.sol";
import {EIP1271_MAGIC_VALUE} from "contracts/smart-account/interfaces/ISignatureValidator.sol";

contract MockAuthModule is BaseAuthorizationModule {
    mapping(address => bytes) internal setupData;

    function init(bytes calldata setupData_) external returns (address) {
        setupData[msg.sender] = setupData_;
        return address(this);
    }

    function validateUserOp(
        UserOperation calldata userOp,
        bytes32 userOpHash
    ) external returns (uint256 validationData) {
        (userOp, userOpHash);
        validationData = 0; //means validation success
    }

    function isValidSignature(
        bytes32 _dataHash,
        bytes memory _signature
    ) public view virtual override returns (bytes4) {
        (_dataHash, _signature);
        return EIP1271_MAGIC_VALUE; //always valid signature
    }

    function isValidSignatureUnsafe(
        bytes32 _dataHash,
        bytes memory _signature
    ) public view virtual override returns (bytes4) {
        (_dataHash, _signature);
        return EIP1271_MAGIC_VALUE; //always valid signature
    }
}
