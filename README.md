Solidity Contracts Collection
=============================

This repo collects Solidity reference implementations and experiments. It includes:
- A large set of OpenZeppelin-style ERC20 / ERC721 / ERC1155 variants (multiple revisions kept for comparison).
- A BEP20 reflection token example in `NewBep20.sol`.
- A curated Foundry mini-project in `showcase/` with modern, production-leaning samples and tests.

Repo layout
-----------
- `showcase/` – Foundry project with highlighted samples and tests. See its `README.md` for details and commands.
- `NewBep20.sol` – BEP20 reflection token with fee mechanics and owner-controlled parameters.
- Root `.sol` files – One-file copies/variants of common OpenZeppelin contracts for reference and remixing.

Quick start (Showcase with Foundry)
-----------------------------------
1) Install Foundry: `curl -L https://foundry.paradigm.xyz | bash` then `foundryup`.
2) Install deps: `cd showcase && forge install foundry-rs/forge-std openzeppelin/openzeppelin-contracts@v5.4.0 openzeppelin/openzeppelin-contracts-upgradeable@v5.2.0`.
3) Build & test: `forge build && forge test`.

Using the single-file contracts
-------------------------------
- Open the desired `.sol` file in Remix or drop it into your Hardhat/Foundry project.
- Adjust Solidity pragma/import paths to match your toolchain version (most files target ^0.8.x and assume OpenZeppelin v5 style APIs).
- Review owner controls, fees, and mint logic before deploying.

Notes
-----
- No automatic formatting or linting is enforced; run your preferred formatter before committing changes.
- The repository retains multiple historical variants for side-by-side comparison—names include numeric suffixes to show revisions.

