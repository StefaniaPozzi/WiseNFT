//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract HappyNFT is ERC721 {
    uint256 private s_counter;
    string private s_happySvgUri;
    string private s_happierSvgUri;

    error HappyNFT__CantFlip_OwnerDoNotMatchId();

    enum Happiness {
        HAPPY,
        HAPPIER
    }

    mapping(uint256 => Happiness) private s_tokenIdToMood;

    constructor(string memory _happySvgUri, string memory _happierSvgUri) ERC721("Happy", "HP") {
        s_counter = 0;
        s_happySvgUri = _happySvgUri;
        s_happierSvgUri = _happierSvgUri;
    }

    function mintToken() public {
        _safeMint(msg.sender, s_counter);
        s_tokenIdToMood[s_counter] = Happiness.HAPPY;
        s_counter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        string memory imageURI;
        s_tokenIdToMood[_tokenId] == Happiness.HAPPY ? imageURI = s_happySvgUri : imageURI = s_happierSvgUri;

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '", "description":"If the owner is happy, he will be happy too. Or happier if the owner is very happy!", "attributes":[{"trait_type": "happiness", "value": 50}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function imageURI(uint256 _tokenId) public returns (string memory) {
        string memory imageBase64;
        s_tokenIdToMood[_tokenId] == Happiness.HAPPY ? imageBase64 = s_happySvgUri : imageBase64 = s_happierSvgUri;
        return imageBase64;
    }

    function flipMood(uint256 tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert HappyNFT__CantFlip_OwnerDoNotMatchId();
        }
        s_tokenIdToMood[tokenId] == Happiness.HAPPY
            ? s_tokenIdToMood[tokenId] = Happiness.HAPPIER
            : s_tokenIdToMood[tokenId] = Happiness.HAPPY;
    }
}
