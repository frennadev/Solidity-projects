Solidity Showcase
=================

Curated, production-leaning samples that highlight ERC20, ERC20Permit/Votes, ERC721 with royalties, ERC1155 with supply tracking, and an upgradeable proxy demo. Uses OpenZeppelin v5.x and Foundry.

How to use
----------
- Install Foundry: `curl -L https://foundry.paradigm.xyz | bash` then `foundryup`.
- Install deps: `cd showcase && forge install foundry-rs/forge-std openzeppelin/openzeppelin-contracts@v5.4.0 openzeppelin/openzeppelin-contracts-upgradeable@v5.2.0`.
- Build/tests: `forge build` and `forge test`.

Highlights
----------
- Tokens: basic ERC20 with constructor mint; ERC20 with Permit + Votes for gasless approvals and governance snapshots.
- NFTs: ERC721 with EIP-2981 royalties.
- Multi-token: ERC1155 with supply tracking.
- Upgradeability: ERC1967 proxy wiring for an upgradeable token implementation.

Structure
---------
- `src/tokens/BasicToken.sol` – minimal ERC20 with mint on deploy.
- `src/tokens/PermitVotesToken.sol` – ERC20 + Permit + Votes combo.
- `src/nfts/NftRoyalty.sol` – ERC721 + Royalty.
- `src/multitoken/MultiTokenSupply.sol` – ERC1155 with per-id totalSupply.
- `src/upgradeability/ProxyDemo.sol` – ERC1967 proxy plus upgradeable implementation.
- `test/` – small Foundry sanity tests.

Notes
-----
- All contracts target Solidity ^0.8.20 and OpenZeppelin v5.x.
- Keep constructor arguments simple for quick demos; extend as needed.

