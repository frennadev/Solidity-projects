//SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Ballistic {
    address public owner;
    IUniswapV2Router02 public uniswapRouter;

    constructor(address _uniswapRouter) {
        owner = msg.sender;
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function sendTip() external payable {
        block.coinbase.transfer(msg.value);
    }

    function sendEther(address[] memory recipients, uint256[] memory amounts) public payable {
        require(recipients.length == amounts.length, "Recipients and amounts length mismatch");
        for (uint256 i = 0; i < recipients.length; i++) {
            require(address(this).balance >= amounts[i], "Insufficient contract balance");
            payable(recipients[i]).transfer(amounts[i]);
        }
    }

    function sendTokens(address tokenAddress, address[] memory recipients, uint256[] memory amounts) public {
        require(recipients.length == amounts.length, "Recipients and amounts length mismatch");
        IERC20 token = IERC20(tokenAddress);
        for (uint256 i = 0; i < recipients.length; i++) {
            require(token.balanceOf(msg.sender) >= amounts[i], "Insufficient tokens");
            require(token.allowance(msg.sender, address(this)) >= amounts[i], "Insufficient allowance");
            token.transferFrom(msg.sender, recipients[i], amounts[i]);
        }
    }

    function sellTokensAndWithdrawETH(
        address tokenAddress,
        uint256 sellPercentage,
        address feeAddress,
        uint256 feePercentage,
        address referralAddress,
        uint256 referralFeePercentage
    ) public {
        IERC20 token = IERC20(tokenAddress);

        uint256 balance = token.balanceOf(msg.sender);
        uint256 amountToSell = (balance * sellPercentage) / 100;

        require(amountToSell > 0, "Sell amount is zero");

        token.transferFrom(msg.sender, address(this), amountToSell);

        // Approve Uniswap to spend the tokens
        token.approve(address(uniswapRouter), amountToSell);

        // Create the Uniswap path for the swap (Token -> WETH)
        address[] memory path = new address[](2);
        path[0] = tokenAddress;
        path[1] = uniswapRouter.WETH();

        // Perform the swap
        uniswapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amountToSell,
            0,
            path,
            address(this),
            block.timestamp
        );

        uint256 ethBalance = address(this).balance;
        uint256 fee = (ethBalance * feePercentage) / 100;

        // Transfer referral fee
        if (referralAddress != address(0)) {
            uint256 referralFee = (fee * referralFeePercentage) / 100;
            fee = fee - referralFee;

            payable(referralAddress).transfer(referralFee);
        }

        // Transfer remaining fee
        payable(feeAddress).transfer(fee);

        // Transfer remaining ETH to the sender
        payable(msg.sender).transfer(ethBalance - fee);
    }

    function withdrawETH() public onlyOwner {
        require(address(this).balance > 0, "No balance to withdraw");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}