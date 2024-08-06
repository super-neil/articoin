pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// For a more decentralized approach, consider using a multi-signature wallet or a governance mechanism in the future.
contract ArticoinToken is ERC20, Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    // Events to log important actions
    event ArtworkCreated(address indexed artist, uint256 tokenId);
    event TokensRewarded(address indexed artist, uint256 amount);

    // Mapping to store artwork and associated artist
    mapping(uint256 => address) public artworkToArtist;

    // Reward amount per artwork (you can adjust this)
    uint256 public rewardPerArtwork = 10 * 10 ** decimals(); // 10 tokens

    constructor() ERC20("ArtiCoin", "ART") {
        // Mint initial supply to the contract owner (adjust as needed)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Function to create new artwork and reward the artist
    function createArtwork(uint256 tokenId) public nonReentrant {
        artworkToArtist[tokenId] = msg.sender;
        _mint(msg.sender, rewardPerArtwork);  // Mint tokens and reward artist
        emit ArtworkCreated(msg.sender, tokenId);
        emit TokensRewarded(msg.sender, rewardPerArtwork);
    }

    // Transfer function
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    // Function to change the reward amount per artwork (onlyOwner)
    function changeRewardPerArtwork(uint256 newAmount) public onlyOwner {
        rewardPerArtwork = newAmount;
    }

    // Function to burn a specified amount of tokens (onlyOwner)
    function burnTokens(uint256 amount) public onlyOwner {
        _burn(msg.sender, amount);
    }
}
