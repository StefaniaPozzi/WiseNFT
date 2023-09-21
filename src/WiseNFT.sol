//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract WiseNFT is ERC721 {
    uint256 private s_counter;
    mapping(uint256 => string) private s_uris;

    constructor() ERC721("Wisy", "WI") {
        s_counter = 0;
    }

    function mintToken(string memory _uri) public {
        s_uris[s_counter] = _uri;
        _safeMint(msg.sender, s_counter);
        s_counter++;
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        return s_uris[id];
    }
}
