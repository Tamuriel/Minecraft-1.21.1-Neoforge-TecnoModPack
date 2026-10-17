---
name: dynamicfood-spec-navigation
description: Navigate DynamicFood's governing specifications and resolve semantic authority. Use this when interpreting project requirements, deciding which document or section owns a rule, reconciling specification and implementation, planning semantic changes, or when historical and current contracts may be mixed.
---

# DynamicFood Specification Navigation

Use this skill whenever a task depends on DynamicFood semantics, requirements, phase boundaries, acceptance criteria, or conflicts between the written specification and the repository.

## 1. Mandatory authority boundary

The repository contains a set of governing Markdown documents. They are authoritative over:

- previous prompts;
- chat instructions from earlier sessions;
- generated handoff text;
- assumptions reconstructed from code alone.

For a broad semantic task, first read:

1. `01_Master_Spec.md`
2. `02_Baseline.md`
3. `03_Requirements_Matrix.md`
4. `04_Audit.md`
5. `05_State.md`
6. the applicable phase document;
7. `12_AI_WORK_PROTOCOL.md`;
8. `13_FINAL_ACCEPTANCE.md`.

When the task spans multiple phases, read all applicable phase documents rather than inferring their boundaries from class names.

## 2. Semantic authority order

When determining intended semantics, use this order:

1. current explicit Master Specification;
2. applicable phase-specific requirements;
3. requirements matrix;
4. current repository implementation;
5. tests and generated/build artifacts;
6. comments and incidental documentation.

For current implementation facts, reverse the emphasis:

1. repository;
2. tests;
3. generated/build artifacts;
4. documentation.

Do not confuse "what the repository currently does" with "what the specification requires".

## 3. Historical versus normative text

Governing documents may retain dated audits, old checkpoints, superseded formulas, or legacy field names.

Do not treat historical text as current contract merely because it appears later in a file.

Prefer sections explicitly marked as:

- current;
- normative;
- active;
- semantic lock;
- superseding an earlier section.

`13_FINAL_ACCEPTANCE.md` explicitly states that retained historical Phase 01–02 checkpoints are evidence records, not normative contracts. Interpret legacy names through the current contracts in `01`–`12`.

When a historical section conflicts with a current normative section, report the conflict and use the current normative section.

## 4. Conflict protocol

Never silently choose between conflicting requirements.

When conflict exists, record:

- requirement/document A;
- requirement/document B;
- exact semantic conflict;
- affected phase;
- affected classes/interfaces/snapshots if known;
- whether the conflict is specification ambiguity or implementation drift;
- the smallest required policy/specification decision.

Stop the affected implementation path when a safe interpretation cannot be established.

Use `UNKNOWN` or `BLOCKED` rather than inventing a resolution.

## 5. Semantic reading rules

Do not reconstruct DynamicFood semantics from names such as:

- `EconomicCost`;
- `EconomicFactor`;
- `Difficulty`;
- `AcquisitionCost`;
- `TimeCost`;
- `Probability`.

Trace each term to its current governing definition.

Preserve these distinct layers:

```text
raw mechanical evidence
    -> normalized factor
    -> CostVector
    -> AcquisitionCost (path-level)
    -> path selection policy
    -> EconomicCost (resource-level)
    -> EconomicSnapshot
    -> population / identity
    -> calibration
    -> FoodIndex / food value
```

A class or field name never overrides the documented semantic boundary.

## 6. Phase-boundary discipline

Do not solve a later-phase problem inside an earlier phase merely because the implementation makes it convenient.

In particular:

- Phase 01 defines the economic semantic foundation;
- Phase 02 establishes acquisition evidence and path analysis;
- Phase 03 establishes population and identity;
- Phase 04 calibrates resolved economics into gameplay values;
- Phase 05 handles runtime behavior;
- Phase 06 verifies the complete system.

Do not use population, calibration, FoodIndex, or runtime observations as hidden inputs to static EconomicCost unless the governing specification explicitly makes them part of the current contract.

## 7. Evidence classification

When a document contains an assertion, classify it as one of:

- normative contract;
- implementation fact;
- verification evidence;
- historical evidence;
- unresolved requirement;
- proposed future policy.

Do not turn verification evidence or historical observations into new semantic rules without an explicit contract change.

## 8. Required output for semantic analysis

When reporting a semantic conclusion, state:

1. the governing document/section that establishes it;
2. the resulting rule;
3. the implementation consequence, if any;
4. remaining UNKNOWN or BLOCKED conditions.

If the task asks for implementation, identify the contract first. If the contract is absent or contradictory, stop at the semantic boundary instead of writing speculative code.

## 9. Repository inspection

Before changing code:

- inspect `05_State.md`;
- inspect current HEAD/commit;
- inspect the relevant classes and tests;
- verify the specification still matches the intended work.

Do not use a stale handoff, old commit hash, or prior chat transcript as proof of current repository state.
