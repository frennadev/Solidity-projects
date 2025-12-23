// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;


interface IUniswap {
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
}


interface IERC20 { 
    function transferFrom(address from, address to, uint value) external returns (bool);
    function approve(address spender, uint value) external returns (bool);

}

contract Bundler {

    mapping(address => bool) whitelisted;
    address _weth;

    modifier onlyWhitelisted() {
        require(whitelisted[msg.sender], "Only whitelisted");
        _;
    }


    constructor (address weth) {
        whitelisted[msg.sender] = true;
        _weth = weth;
    }


    function bundleTrx(
        address router, 
        address token,
        address _liquidityTo,  
        uint _liquidtyAmount,
        uint _tokenAmount,
        address[] calldata buyers, 
        uint[] calldata amounts
        ) external payable onlyWhitelisted {
            address[] memory path;
            path = new address[](2);
            path[0] = _weth;
            path[1] = token;
            
            IERC20(token).transferFrom(_liquidityTo,address(this), _tokenAmount);
            IERC20(token).approve(router, _tokenAmount);
            IUniswap(router).addLiquidityETH{value : _liquidtyAmount}(token, _tokenAmount, 0, 0, _liquidityTo, block.timestamp);
            uint totalBuyers  = buyers.length;
            
            for(uint i = 0; i < totalBuyers; i++) {
                uint amount = amounts[i];
                
                IUniswap(router).swapExactETHForTokensSupportingFeeOnTransferTokens{value : amount}(0, path, buyers[i], block.timestamp);
            } 
    
        payable(msg.sender).transfer(address(this).balance);
    }



}