//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./NameWrapper.sol";
import { ModeDomainsLinker } from "./ModeDomainsLinker.sol";

contract ModeDomains is NameWrapper {
    string public constant name = "Mode Domains";
    string public constant symbol = ".mode";
    string public constant contractURI =
        "https://metadata.opti.domains/collection/domains/mode";

    ModeDomainsLinker public immutable linker;

    constructor(
        ENS _ens,
        IBaseRegistrar _registrar,
        IMetadataService _metadataService,
        ModeDomainsLinker _linker,
        string memory _ethNode
    ) NameWrapper(_ens, _registrar, _metadataService, _ethNode) {
        linker = _linker;
    }

    /**
     * @dev Returns the Name's owner address and fuses
     */
    function getData(
        uint256 tokenId
    ) public view virtual override returns (address owner, uint32 fuses, uint64 expiry) {
        uint256 t = _tokens[tokenId];

        (owner, expiry) = linker.getData(names[bytes32(tokenId)]);

        if (owner == address(0)) {
            owner = address(uint160(t));
            expiry = uint64(t >> 192);
        }

        fuses = uint32(t >> 160);

        (owner, fuses) = _clearOwnerAndFuses(owner, fuses, expiry);
    }
}
