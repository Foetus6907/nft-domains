// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;
// We  import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import { StringUtils } from "./libraries/StringUtils.sol";
// We import another help function
import {Base64} from "./libraries/Base64.sol";

import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract Domains is ERC721URIStorage {
   // extensions de domain .xxxx
    string public tld;

    using Counters for Counters.Counter;
    // We take track of tokenids
    Counters.Counter private _tokenIds;

    // We'll be storing our NFT images on chain as SVGs
    string svgPartOne = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="256px" height="256px" fill-rule="evenodd" clip-rule="evenodd"><path fill="url(#T)" d="M0 0h270v270H0z"/><defs><filter id="Z" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse" height="270" width="270"><feDropShadow dx="0" dy="1" stdDeviation="2" flood-opacity=".225" width="200%" height="200%"/></filter></defs><defs><linearGradient id="T" x1="0" y1="0" x2="270" y2="270" gradientUnits="userSpaceOnUse"><stop stop-color="#cb5eee"/><stop offset="1" stop-color="#0cd7e4" stop-opacity=".99"/></linearGradient></defs><linearGradient id="1sZKX~UB~d1plB4UUKzq0a" x1="32" x2="32" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><path fill="url(#1sZKX~UB~d1plB4UUKzq0a)" fill-rule="evenodd" d="M61.238,34.654l1.832-9.867l-4.614,1.164l-1.194,7.437 l-0.156,0.024l0.692-7.243l-4.221,0.817l-0.106,1.309l-0.228-1.178l-4.365,0.476l-0.177,0.985c-0.854-0.548-1.97-0.834-3.284-0.834 c-1.157,0-2.262,0.22-3.038,0.465l0.001-0.072l-3.951-0.148l-0.088,1.689l-0.837-1.69l-3.088-0.218l-0.256,2.282 c-0.763-0.417-1.637-0.655-2.567-0.655c-0.816,0-1.59,0.184-2.284,0.512c-0.962-1.163-2.407-2.225-4.48-2.225 c-2.107,0-3.545,1.091-4.458,2.551l-0.864-3.347l-4.556-0.862l-0.012,0.086c-1.445-1.425-3.381-2.194-5.614-2.194h-0.86 L8.41,25.177C6.107,22.97,3.069,22,1.455,22c-0.131,0-0.258,0.007-0.377,0.019l-0.943,0.096l1.398,9.01H2.41l1.749,10.543 l0.948-0.24c0.061-0.016,1.299-0.34,2.662-1.317L7.714,41.38l4.746,0.267l0.095-1.042L13.182,42l4.901-1.609l0.169,1.052 l4.174-0.685c0.712,0.378,1.515,0.6,2.387,0.6c1.443,0,2.853-0.63,3.973-1.773c0.052-0.053,0.101-0.11,0.153-0.166 c0.784,0.45,1.691,0.708,2.656,0.708c0.505,0,0.995-0.072,1.459-0.204l-0.148,1.314h5.093l0.096-0.856l0.425,0.856h3.766 l0.054-7.422l0.077,0.012l0.663,7.272h0.821c1.532,0,2.569-0.076,3.344-0.254l3.588,0.383l0.282-2.149L51.345,41l4.472-0.538 l-0.185-0.96l0.663-0.104l-0.242,1.499h6.467l1.344-6.682L61.238,34.654z M4.886,40.553l-1.714-10.33H2.304L1.17,22.912 c0.088-0.01,0.184-0.014,0.285-0.014c2.416,0.001,8.568,2.493,9.062,8.629C11.116,38.973,4.887,40.554,4.886,40.553z M13.67,40.893 l-1.701-3.785L11.643,40.7l-2.992-0.169l0.08-1.858c1.278-1.36,2.519-3.621,2.234-7.18c-0.151-1.879-0.812-3.422-1.724-4.678 l0.086-1.995c0.675,0,4.022,0,6.033,3.258c1.907,3.089-0.072,5.719-1.882,6.709l3.281,5.093L13.67,40.893z M18.997,40.41 l-0.654-4.054h-1.415l-0.2,2.099h-0.352l-1.822-2.827l0.159-1.171c0.737-0.646,1.423-1.553,1.72-2.673 c0.342-1.291,0.103-2.655-0.691-3.943c-0.033-0.055-0.074-0.102-0.109-0.155l0.081-0.599l3.066,0.58l3.16,12.26L18.997,40.41z M27.09,32.812c-1.843-1.843-4.333-0.316-4.471,1.611c-0.126,1.758,0.748,2.752,1.882,2.752c1.134,0,1.303-1.062,1.303-1.062h-1.69 v-2.215h2.654c-0.05,0.282-0.087,0.568-0.087,0.864c0,1.532,0.719,2.885,1.822,3.784c-0.951,1.162-2.252,1.91-3.688,1.91 c-0.928,0-1.767-0.306-2.479-0.805l-1.906-7.393c0.603-1.837,1.888-3.675,4.403-3.675c1.886,0,3.163,1.045,3.986,2.131 C28.063,31.235,27.46,31.961,27.09,32.812z M31.543,35.948l-1.888,1.405l0.838-2.115l-1.504-1.417h2.016l0.784-1.938l0.645,1.938 h1.894l-1.532,1.417l0.592,2.073L31.543,35.948z M41.392,40.339h-2.315l-1.536-3.093l-0.347,3.093h-3.282l0.152-1.351 c1.455-0.854,2.446-2.419,2.446-4.225c0-1.415-0.61-2.683-1.57-3.58l0.275-2.453l1.713,0.121l2.132,4.309l0.222-4.237l2.192,0.083 L41.392,40.339z M43.902,40.201L43.25,33.05l-0.606-0.097l-0.341-3.764c0.719-0.275,1.903-0.545,3.115-0.544 c1.238,0,2.505,0.28,3.334,1.123c1.642,1.665,0.845,5.067-1.519,5.478c1.93,0.387,2.326,2.953,1.447,3.813 C47.912,39.813,47.328,40.201,43.902,40.201z M52.131,40l-0.422-3.513l-1.154-0.043l-0.499,3.797l-1.902-0.203 c0.316-0.178,0.572-0.396,0.84-0.658c0.556-0.545,0.732-1.572,0.44-2.555c-0.189-0.636-0.55-1.162-1.025-1.524l0.008-0.045 c0.662-0.42,1.175-1.094,1.448-1.944c0.394-1.227,0.204-2.54-0.473-3.482l0.254-1.415l2.872-0.314l2.233,11.584L52.131,40z M55.018,38.688l-1.049-5.438l0.45-5.511l2.37-0.458l-0.688,7.197l2.821-0.439l-0.684,4.147L55.018,38.688z M61.785,40h-4.676 l0.195-1.214l1.326-0.207l0.836-5.08l-1.346,0.21l1.13-7.032l2.679-0.675l-1.81,9.75l2.607-0.434L61.785,40z" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0b" x1="17.547" x2="17.547" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><polygon fill="url(#1sZKX~UB~d1plB4UUKzq0b)" fill-rule="evenodd" points="17.195,33.579 17.898,33.579 17.457,30.844" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0c" x1="51.144" x2="51.144" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><polygon fill="url(#1sZKX~UB~d1plB4UUKzq0c)" fill-rule="evenodd" points="50.845,34.231 51.443,34.254 51.156,31.863" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0d" x1="46.063" x2="46.063" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><path fill="url(#1sZKX~UB~d1plB4UUKzq0d)" fill-rule="evenodd" d="M45.615,36.34l0.073,1.495 c0.349-0.039,0.858-0.264,0.82-0.755C46.469,36.574,46.006,36.356,45.615,36.34z" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0e" x1="6.671" x2="6.671" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><path fill="url(#1sZKX~UB~d1plB4UUKzq0e)" fill-rule="evenodd" d="M5.346,30.467l0.699,4.271 c0.458-0.049,2.189-0.451,1.924-2.293C7.68,30.443,5.346,30.467,5.346,30.467z" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0f" x1="45.979" x2="45.979" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><path fill="url(#1sZKX~UB~d1plB4UUKzq0f)" fill-rule="evenodd" d="M45.398,31.817l0.089,1.86 c0.475-0.01,1.124-0.221,1.069-0.965C46.502,31.958,45.771,31.831,45.398,31.817z" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0g" x1="12.985" x2="12.985" y1="24.808" y2="41.945" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#1a6dff"/><stop offset="1" stop-color="#c822ff"/></linearGradient><path fill="url(#1sZKX~UB~d1plB4UUKzq0g)" fill-rule="evenodd" d="M12.61,30.058l-0.237,2.613 c0.017,0,0.035,0.001,0.053,0.001c0.404,0,0.992-0.208,1.149-1.239S13.016,30.13,12.61,30.058z" clip-rule="evenodd"/><linearGradient id="1sZKX~UB~d1plB4UUKzq0h" x1="31.596" x2="31.596" y1="39.008" y2="31.333" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#6dc7ff"/><stop offset="1" stop-color="#e6abff"/></linearGradient><path fill="url(#1sZKX~UB~d1plB4UUKzq0h)" fill-rule="evenodd" d="M31.596,31c-2.079,0-3.762,1.685-3.762,3.762 c0,2.078,1.684,3.762,3.762,3.762s3.762-1.685,3.762-3.762C35.358,32.684,33.673,31,31.596,31z M33.388,37.311l-1.845-1.363 l-1.888,1.405l0.838-2.115l-1.504-1.417h2.016l0.784-1.938l0.645,1.938h1.894l-1.532,1.417L33.388,37.311z" clip-rule="evenodd"/><text x="32.5" y="59" font-size="5" fill="#fff" filter="url(#Z)" font-family="Plus Jakarta Sans,DejaVu Sans,Noto Color Emoji,Apple Color Emoji,sans-serif" font-weight="bold">';
    string svgPartTwo = '</text></svg>';

    // A "mapping" data type to store their names domain name and their owner
    mapping(string => address) public domains;
    // A mapping this will store domain linked data
    mapping(string => string) public domainRecords;

    // We make the contract "payable" by adding this to the constructor
    constructor(string memory _tld) payable ERC721("Kame Name Service", "KNS") {
        tld = _tld;
        console.log("%s name service deployed", _tld);
    }

    // This function will give us the price of a domain based on length
    function price(string calldata name) public pure returns(uint) {
        uint len = StringUtils.strlen(name);
        require(len > 0);
        if (len == 3) {
            return 5 * 10**17; // 5 MATIC = 5 000 000 000 000 000 000 (18 decimals). We're going with 0.5 Matic cause the faucets don't give a lot
        } else if (len == 4) {
            return 3 * 10**17; // To charge smaller amounts, reduce the decimals. This is 0.3
        } else {
            return 1 * 10**17;
        }
    }


    // A register function that adds their names to our mapping
    function register(string calldata name) public payable {
        // We check if the msg have enought found to paid the price
        uint _price = price(name);
        require(msg.value >= _price, "Not enough Matic to register domain");
        // Check that the name is unregistered
        require(domains[name] == address(0), "Domain already registered");

        // Combine the name passed into the fonctoin with tjhe TLD
        string memory _name = string(abi.encodePacked(name , "." , tld));
        // Create the SVG (image) for the NFT with the name
        string memory _svg = string(abi.encodePacked(svgPartOne, _name, svgPartTwo));
        uint256 newRecordId = _tokenIds.current();
        uint256 length = StringUtils.strlen(name);
        string memory strLength = Strings.toString(length);

        console.log("Registering %s.%s on the contract with tokenId %d", name, tld, newRecordId);

        // Create the JSON metadata of our NFT. We do this by combining strings and encoding as base64
        string memory jsonMetaData = Base64.encode(
            abi.encodePacked(
                '{"name": "',
                _name,
                '", "description": "A domain on the Kame name service", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(_svg)),
                '", "length":"',
                strLength,
                '"}'
            )
        );

        string memory finalTokenUri = string(abi.encodePacked("data:application/json;base64,", jsonMetaData));
        console.log("\n--------------------------------------------------------");
        console.log("Final tokenURI", finalTokenUri);
        console.log("--------------------------------------------------------\n");

        _safeMint(msg.sender, newRecordId);
        _setTokenURI(newRecordId, finalTokenUri);
        domains[name] = msg.sender;
        console.log("%s has registered a domain %s!", msg.sender, name);

        _tokenIds.increment();
    }

    // This will give us the domain owners' address
    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        // Check that the domain owner is the transaction sender
        require(domains[name] == msg.sender);
        // mapping records to the domain name
        domainRecords[name] = record;
        console.log("%s has set a record for %s data is %s", msg.sender, name, record);
    }

    function getRecord(string calldata name) public view returns (string memory) {
        return domainRecords[name];
    }
}