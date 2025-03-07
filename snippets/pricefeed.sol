// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import Chainlink's AggregatorV3Interface
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// Import IERC20Metadata for decimals(), name(), and symbol()
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

interface IUniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function token0() external view returns (address);
    function token1() external view returns (address);
}

contract TokenPriceFeed {
    address public immutable tokenAddress;
    address public immutable uniswapPairAddress;
    address public immutable ethUsdFeedAddress;
    address public immutable wethAddress;

    constructor(
        address _tokenAddress,
        address _uniswapPairAddress,
        address _ethUsdFeedAddress,
        address _wethAddress
    ) {
        tokenAddress = _tokenAddress;
        uniswapPairAddress = _uniswapPairAddress;
        ethUsdFeedAddress = _ethUsdFeedAddress;
        wethAddress = _wethAddress;
    }

    function getTokenPriceInUSD() external view returns (uint256) {
        // Verify the pair includes WETH
        address token0 = IUniswapV2Pair(uniswapPairAddress).token0();
        address token1 = IUniswapV2Pair(uniswapPairAddress).token1();
        require(token0 == wethAddress || token1 == wethAddress, "Pair must include WETH");

        // Get reserves
        (uint112 reserve0, uint112 reserve1, ) = IUniswapV2Pair(uniswapPairAddress).getReserves();
        uint256 reserveToken;
        uint256 reserveETH;
        if (token0 == tokenAddress) {
            reserveToken = uint256(reserve0);
            reserveETH = uint256(reserve1); // WETH
        } else {
            reserveToken = uint256(reserve1);
            reserveETH = uint256(reserve0); // WETH
        }

        // Calculate price in ETH (18 decimals)
        require(reserveToken > 0, "No token liquidity");
        uint256 priceInETH = (reserveETH * 1e18) / reserveToken;

        // Get ETH/USD price from Chainlink (8 decimals)
        (, int256 ethUsdPrice, , , ) = AggregatorV3Interface(ethUsdFeedAddress).latestRoundData();
        require(ethUsdPrice > 0, "Invalid ETH/USD price");
        uint256 ethUsd = uint256(ethUsdPrice);

        // Get token decimals using IERC20Metadata
        uint8 tokenDecimals = IERC20Metadata(tokenAddress).decimals();

        // Calculate token price in USD per whole token with 18 decimals
        uint256 tokenPriceInUSD = (priceInETH * ethUsd * (10 ** tokenDecimals)) / 1e8;

        return tokenPriceInUSD;
    }
}