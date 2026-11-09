// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TruthOracle {

    enum Verdict {
        TRUE,
        FALSE,
        UNCERTAIN
    }

    struct ClaimResult {
        string claim;
        Verdict verdict;
        uint256 timestamp;
        uint256 validatorCount;
    }

    mapping(bytes32 => ClaimResult) public results;

    event ClaimVerified(
        bytes32 indexed claimId,
        Verdict verdict
    );

    function storeResult(
        string memory claim,
        Verdict verdict,
        uint256 validatorCount
    ) public {

        bytes32 claimId =
            keccak256(bytes(claim));

        results[claimId] = ClaimResult({
            claim: claim,
            verdict: verdict,
            timestamp: block.timestamp,
            validatorCount: validatorCount
        });

        emit ClaimVerified(
            claimId,
            verdict
        );
    }
}
