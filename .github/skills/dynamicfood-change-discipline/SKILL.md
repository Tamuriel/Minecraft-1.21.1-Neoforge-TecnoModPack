---
name: dynamicfood-change-discipline
description: Enforce DynamicFood's minimal-correct-change and repository work protocol. Use when modifying source, tests, configuration, specifications, snapshots, generators, analyzers, or runtime code, especially in agent mode or during multi-phase implementation work.
---

# DynamicFood Change Discipline

Use this skill whenever making repository changes. Its purpose is to prevent speculative implementation, unrelated refactoring, phase mixing, semantic drift, and completion claims without evidence.

## 1. Start from current state

Before coding:

1. read `05_State.md`;
2. inspect current HEAD/commit;
3. inspect the applicable governing documents;
4. identify the active phase;
5. inspect the relevant classes, interfaces, tests, and generated artifacts;
6. identify the exact requirement(s) being changed.

Do not rely on a stale handoff or an old commit hash as proof of current state.

## 2. Specification before implementation

The specification defines intended semantics; the repository defines current implementation facts.

When they disagree:

1. identify the mismatch;
2. determine whether it is specification drift or implementation drift;
3. do not silently pick an interpretation;
4. follow the governing conflict protocol.

If a required semantic rule does not exist, is contradictory, or would require inventing economics, stop at the contract boundary and report the required specification decision.

Do not use implementation convenience to create a new economic rule.

## 3. Minimal correct change

Prefer the smallest coherent change that satisfies the requirement.

Do not:

- rewrite unrelated architecture;
- perform cosmetic refactors while fixing semantics;
- rename APIs solely for aesthetics;
- replace stable structures with a preferred pattern without need;
- broaden scope because additional cleanup is available.

However, minimal diff size never overrides semantic correctness. A violating abstraction may be replaced when it makes the required behavior impossible or unsafe.

## 4. No speculative economic implementation

Never implement a missing economic primitive by inventing:

- terminal resource prices;
- arbitrary constants;
- exchange rates;
- rarity scores;
- hidden time-to-value conversions;
- Difficulty-to-EconomicCost mappings;
- FoodIndex-to-EconomicCost mappings;
- calibration-derived economic values;
- population statistics as economic seeds.

Do not convert `UNKNOWN` to numeric zero or a guessed default merely to increase resolution coverage.

If the requested feature would require such a rule, report:

```text
BLOCKED BY POLICY DECISION
```

or:

```text
UNKNOWN
```

as appropriate, and identify the exact document/section requiring a change.

## 5. Respect phase boundaries

Do not silently mix phases.

Examples:

- do not redesign calibration while repairing acquisition analysis;
- do not use Phase 03 population statistics to define Phase 01 EconomicCost;
- do not solve runtime FoodProperties by mutating static economic generation;
- do not add Phase 03 identity semantics to a Phase 02 acquisition fix unless explicitly required;
- do not claim Phase 02 completion because a Phase 01 semantic test passes.

Small interface changes needed to consume an already-established upstream contract are acceptable when they are explicitly scoped and verified.

## 6. Specification-document changes

Do not modify the governing specification merely to make an implementation pass.

When a contract change is genuinely necessary, report first:

```text
Document:
Section:
Current semantic rule:
Proposed semantic change:
Reason:
Affected phases/classes/snapshots:
```

Only apply the document change when the task explicitly authorizes it.

Do not silently rewrite historical evidence into current claims.

## 7. Preserve semantic layers

Keep these boundaries intact:

```text
mechanical evidence
    !=
factor normalization
    !=
AcquisitionCost
    !=
EconomicCost
    !=
FoodIndex
    !=
runtime food value
```

Providers are mechanical adapters, not EconomicCost calculators.

Runtime code consumes static EconomicSnapshot data; it must not become a hidden second economic engine.

## 8. Safe unsupported-source behavior

When an implementation encounters:

- unsupported mod mechanics;
- unavailable APIs;
- incomplete worldgen evidence;
- incomplete trade progression;
- unresolved crop cycles;
- missing equipment lifecycle evidence;
- non-comparable stochastic processes;

preserve the source/evidence, classify the limitation, record the reason, and use `UNKNOWN` or `BLOCKED` as required by the contract.

Do not fabricate compatibility behavior.

## 9. Determinism

For deterministic economic computation verify:

- stable ordering;
- stable grouping;
- stable identity;
- stable configuration;
- stable evaluator/version inputs;
- stable approximation seed when approximation is explicitly allowed;
- stable sample count where applicable;
- stable snapshot signature.

Do not rely on:

- unordered map iteration;
- registry iteration order;
- uncontrolled randomness;
- wall-clock time;
- thread scheduling.

## 10. Validation after changes

At the end of each coherent work unit:

1. run focused tests;
2. run relevant regression tests;
3. inspect the diff;
4. inspect generated/configuration changes;
5. verify no unrelated files changed;
6. verify the semantic requirement actually changed as intended;
7. update `05_State.md` when the work unit changes project state.

Do not claim completion because compilation succeeds alone.

## 11. Tests must prove semantics

Tests should distinguish at minimum:

- KNOWN;
- UNKNOWN;
- NOT_APPLICABLE;
- resolved zero;
- unresolved recursive dependency;
- probability ownership without double-counting;
- horizon startup versus recurring behavior;
- equipment lifecycle burden;
- deterministic repeated evaluation;
- path-selection quality where applicable.

Do not weaken a semantic test because the implementation is inconvenient.

## 12. Diff discipline

Before finalizing:

- inspect all changed files;
- look for accidental generated files;
- look for unrelated formatting or import churn;
- look for changed configs that were not required;
- verify no public semantic contract changed unintentionally;
- verify tests cover the new behavior.

A broad diff is not automatically wrong, but every changed file must have a reason tied to the task.

## 13. Failure classification

When a task cannot proceed, classify the failure as one of:

- `IMPLEMENTATION BUG`
- `TEST BUG`
- `SPECIFICATION AMBIGUITY`
- `API LIMITATION`
- `MISSING INTEGRATION`
- `ENVIRONMENT LIMITATION`
- `BLOCKED`

When a probabilistic or economic result cannot be defended, prefer `UNKNOWN` over an unsupported approximation.

## 14. Requirements conflict

If two requirements conflict, report:

- requirement A;
- requirement B;
- exact conflict;
- affected implementation;
- affected EconomicSnapshot / generation boundary if any;
- proposed semantic resolution;
- whether user/spec clarification is required.

Stop the affected implementation path when necessary. Never encode one interpretation silently.

## 15. Completion claims

Do not call a phase or feature complete merely because:

- classes exist;
- the project compiles;
- unit tests pass;
- TODOs were removed;
- one fixture works;
- one runtime path works.

Completion requires the applicable acceptance criteria, verification evidence, lifecycle behavior, and state documentation.

Use:

```text
NOT_TESTED
PARTIAL
UNKNOWN
BLOCKED
DONE
```

accurately.

## 16. State-file discipline

`05_State.md` must remain factual.

When changing project state, record as appropriate:

- current HEAD/commit;
- active phase;
- implemented requirements;
- verified tests;
- EconomicSnapshot/CalibrationSnapshot lifecycle state;
- known limitations;
- next action.

Do not remove known limitations merely because they make the status look incomplete.

## 17. Final work-session report

Use this structure after a substantive change:

```text
## Changed
<semantic and implementation changes>

## Verified
<tests and actual evidence>

## Remaining
<known limitations>

## Generation / Lifecycle
<relevant snapshot/generation information>

## Commit
<commit hash if committed>

## State
<phase/status>
```

Do not claim more than the evidence proves.

## 18. Non-negotiable rules

1. Do not guess economics.
2. Do not use UNKNOWN as zero.
3. Do not use NOT_APPLICABLE as a convenience flag.
4. Do not equate discovery with acquisition.
5. Do not equate candidate with resolved.
6. Do not silently collapse semantic layers.
7. Do not double-charge probability already represented by ExpectedQuantity.
8. Do not normalize child EconomicCost again.
9. Do not mutate a published EconomicSnapshot during ordinary gameplay.
10. Do not mix economic generations.
11. Do not create a hidden second economic engine in runtime code.
12. Do not claim completion without evidence.
13. Do not mix phases without a documented reason.
14. Do not modify governing documents without explicit authorization.
15. Prefer the smallest coherent change that preserves semantic correctness.
