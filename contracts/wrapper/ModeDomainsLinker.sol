//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {NameRegistry} from "../mode/NameRegistry.sol";
import "../utils/BytesLib.sol";

contract ModeDomainsLinker is Ownable {
    NameRegistry public modeRegistry;

    function setModeRegistry(NameRegistry _modeRegistry) public onlyOwner {
        modeRegistry = _modeRegistry;
    }

    /**
     * @dev Returns the Name's owner address and fuses
     */
    function getData(
        bytes memory encodedName
    ) public view virtual returns (address owner, uint64 expiry) {
        (string memory decodedName, bool isTLD) = decodeModeTLD(encodedName);

        if (isTLD) {
            uint256 _expiry;
            (owner, , , _expiry, ) = modeRegistry.getNameDetails(decodedName);
            expiry = uint64(_expiry);
        }
    }

    function decodeModeTLD(
        bytes memory encodedName
    ) internal pure returns (string memory, bool) {
        uint256 len = uint256(uint8(encodedName[0]));
        if (len > 0) {
            return (
                string(BytesLib.slice(encodedName, 1, len)),
                uint8(encodedName[len + 1]) == 0
            );
        } else {
            return ("", false);
        }
    }
}
