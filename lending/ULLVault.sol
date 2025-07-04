contract ULLVault is IULL, Ownable {
    address public lendingPool;

    modifier onlyLendingPool() {
        require(msg.sender == lendingPool, "Not authorized");
        _;
    }

    function setLendingPool(address _pool) external onlyOwner {
        require(_pool != address(0), "Zero address");
        lendingPool = _pool;
    }

    /// 用户资产转入（用户先 approve 给本合约）
    function deposit(address asset, uint256 amount, address from) external override onlyLendingPool {
        require(IERC20(asset).transferFrom(from, address(this), amount), "TransferFrom failed");
    }
}
