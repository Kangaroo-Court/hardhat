// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface Router {
    function getDisputeParams(uint256 id)
        external
        view
        returns (address m, uint32 _id);
}

/**
 * @title ERC721Mock
 * This mock just provides a public safeMint, mint, and burn functions for testing purposes
 */
contract ERC721K is ERC721 {
    using Strings for uint256;
    address router;
    enum CourtMember {
        Judge,
        JurorA,
        JurorB,
        JurorC,
        Prosecution,
        Defense,
        Bailiff,
        Defendent
    }

    constructor(address r) ERC721("KangarooCourt", "KC") {
        router = r;
    }

    function baseURI() public view   returns (string memory) {
        _baseURI();
    }

    function _baseURI() internal view override returns (string memory) {
        return
            "https://bafybeifg46mjekp35aq7sasfj2dfwiruu6byttudctqlure7i5bvznegde.ipfs.nftstorage.link/";
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function safeMint(
        address to,
        CourtMember member,
        uint256 bet
    ) public {
        (address token, uint64 id) = Router(router).getDisputeParams(bet);

        _safeMint(
            to,
            encodeTokenID(token, uint256(id), uint256(uint8(member) + 1))
        );
    }

    function encodeTokenID(
        address m,
        uint256 b,
        uint256 k
    ) public view returns (uint256) {
        uint256 out = k;

        out |= (b << 32);

        out |= (uint256(uint160(m)) << 96);

        return out;
    }

    function decodeTokenID(uint256 id)
        public
        view
        returns (
            uint32,
            uint64,
            address
        )
    {
        return (
            uint32(id),
            uint64(uint256(id >> 32)),
            address(uint160(id >> 96))
        );
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        _requireMinted(tokenId);

        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(
                    abi.encodePacked(
                        baseURI,
                        uint256(uint32(tokenId)).toString(),
                        ".json"
                    )
                )
                : "";
    }

    function burn(uint256 tokenId) public {
        _burn(tokenId);
    }
}
