---
name: dynamicfood-verification
description: Verify DynamicFood implementation and design changes against the governing economic, acquisition, provenance, determinism, and acceptance contracts. Use when validating a fix, feature, refactor, PR, test result, snapshot, resolver, analyzer, or semantic change.
---

# DynamicFood Verification Skill

## Purpose

Use this skill to verify that an implementation or design change preserves the current DynamicFood contract.

This skill is a verification procedure, not an implementation recipe.

The governing repository documents are authoritative over assumptions, previous prompts, generated handoffs, and source-code conventions.

Before semantic verification, locate and read the governing documents that own the behavior being checked:

1. `01_Master_Spec.md`
2. `02_Baseline.md`
3. `03_Requirements_Matrix.md`
4. `04_Audit.md`
5. `05_State.md`
6. `06_PHASE_01_ECONOMIC_MODEL.md`
7. `07_PHASE_02_ACQUISITION.md`
8. `08_PHASE_03_POPULATION_IDENTITY.md`
9. `09_PHASE_04_CALIBRATION.md`
10. `10_PHASE_05_RUNTIME.md`
11. `11_PHASE_06_VERIFICATION.md`
12. `12_AI_WORK_PROTOCOL.md`
13. `13_FINAL_ACCEPTANCE.md`

Also use applicable repository skills, especially:

- `dynamicfood-spec-navigation`
- `dynamicfood-economic-model`
- `dynamicfood-acquisition-tracing`
- `dynamicfood-change-discipline`

Historical sections in state/audit/phase documents are evidence, not automatically current normative semantics. If a historical rule conflicts with a current normative section, report the conflict and follow the repository's documented authority order.

---

## 1. Verification hierarchy

Verify in this order:

```text
specification contract
    ↓
semantic model
    ↓
data/evidence flow
    ↓
implementation behavior
    ↓
tests
    ↓
runtime/snapshot output
```

Do not start from passing tests and infer that the specification must therefore be satisfied.

A green test is evidence of an observed behavior, not proof of semantic correctness.

When specification and implementation disagree:

- report the disagreement explicitly;
- identify the owning document/section;
- do not silently redefine the specification to match code;
- do not silently rewrite the code to match an assumed interpretation if the contract itself is ambiguous.

---

## 2. Hard invariants

The following are verification invariants.

### Economic identity

Do not allow:

```text
EconomicCost := AcquisitionCost
EconomicCost := Difficulty
EconomicCost := FoodIndex
EconomicCost := rarity
EconomicCost := rank
EconomicCost := vanilla price
EconomicCost := arbitrary normalized metric
```

`EconomicCost` is a resource-level economic result. `AcquisitionCost` is a path-level aggregate.

`EconomicCost`, `AcquisitionCost`, `Difficulty`, `FoodIndex`, `RawMetric`, and `NormalizedFactor` have distinct semantics.

### Status separation

These states are distinct:

```text
KNOWN
UNKNOWN
NOT_APPLICABLE
INFEASIBLE
CONFLICT
```

Never convert:

```text
UNKNOWN → 0
UNKNOWN → NOT_APPLICABLE
INFEASIBLE → UNKNOWN
NOT_APPLICABLE → 0
CONFLICT → known value
```

A measurable zero is `KNOWN(0)`.

### Canonical baseline

Unless the governing specification explicitly changes it, verify against:

```text
inventory = empty
pre-owned equipment = none
intrinsic capabilities = ordinary survival-player capabilities
initial access = explicitly configured access only
target-specific preparation/infrastructure = none
```

Static economics must not silently inherit the actual player's inventory, tools, infrastructure, stock, or runtime state.

### Economic channels

Current core economic channels are:

```text
quantity
probability_burden
material_consumption
equipment_economic_burden
```

`operation_duration` may be retained as an objective acquisition measurement but is not a universal core completeness gate unless the current contract explicitly enables it as one.

Do not require a numeric value for an inapplicable channel.

---

## 3. Core-completeness verification

For every candidate acquisition path, determine whether each applicable core measurement is:

```text
KNOWN
UNKNOWN
NOT_APPLICABLE
```

A path is core-complete only when every applicable core measurement is `KNOWN` or `NOT_APPLICABLE`.

Do not make core completeness stricter merely because an additional diagnostic metric is unavailable.

Do not make it weaker by inventing a substitute value.

When a measurement is missing, record:

- what evidence would be required;
- whether that evidence exists;
- whether the field is truly applicable;
- why it is UNKNOWN rather than zero or NOT_APPLICABLE.

---

## 4. Double-counting verification

Trace each economic charge back to its causal source.

Verify the following ownership rules:

```text
SelectionProbability
    → ExpectedQuantity

AvailabilityProbability
    → ProbabilityBurden

ProgressProbability
    → ProbabilityBurden

RenewalProbability
    → CycleProfile/material semantics

equipment acquisition + use + repair + replacement
    → EquipmentEconomicBurden
```

The same causal stochastic event may be used in multiple dependent calculations when it provides different state information, but it must not create multiple independent economic charges for the same burden.

Examples:

- A crop seed-return probability may influence both expected seed output and renewal semantics. It must not also become a second independent `ProbabilityBurden`.
- A rare loot selection probability may affect expected quantity. Do not additionally apply `-ln(p)` unless there is a separate causal availability/progress process represented by a distinct stochastic event.

Verify recursive child economics only once. Do not charge a child material/tool cost and then charge the same recursive economic cost again for the same event.

---

## 5. Probability verification

Do not treat every probability as a `ProbabilityBurden`.

Verify the probability type first:

```text
AvailabilityProbability
ProgressProbability
SelectionProbability
RenewalProbability
```

For a simple repeated memoryless Bernoulli stage:

```text
E[opportunities] = 1 / p
ProbabilityBurden = -ln(p)
```

Verify that:

- `p = 1` produces zero probability burden;
- `1/p` remains diagnostic expected-opportunity evidence;
- `-ln(p)` is not applied blindly to arbitrary branching/retry/state-transition graphs;
- composite stochastic processes use their actual causal/dependency structure;
- opportunity units are explicit and comparable;
- no exchange coefficient is invented merely to combine incompatible opportunity units.

---

## 6. Quantity verification

Verify that canonical quantity is based on the declared operation/cycle and its stochastic output structure.

Typical chain:

```text
selection probability
+ quantity distribution
+ roll multiplicity
→ expected quantity
```

Expected quantity may already include probability effects.

Do not subsequently apply an inverse-probability penalty to the same output-selection event.

Verify that quantity normalization is performed exactly once according to the governing contract.

---

## 7. Horizon verification

The default horizon is `H = 100` unless the current contract states otherwise.

Verify `CycleProfile` semantics:

```text
startup cost       → charged once
recurring burden   → scales with H
```

Horizon must affect the raw modeled burden before normalization/composition.

Never:

```text
normalized cost × H
EconomicCost × H
AcquisitionCost × H
```

when the schedule has already been normalized.

Check at minimum conceptually:

```text
H = 1
H = 10
H = 100
```

and verify that startup is not multiplied by H.

If a reusable tool is amortized over a horizon, verify its acquisition/provisioning, usage/depletion, repair/restoration, and replacement lifecycle consistently.

---

## 8. Equipment verification

Verify that `EquipmentEconomicBurden` contains the economic burden of required equipment itself.

There is no separate generic `EquipmentRequirement` economic factor.

For a required tool:

```text
tool child EconomicCost
× objectively derived lifecycle/provisioning events
→ equipment economic expenditure
→ equipment-specific bounded composition/normalization, once
```

Do not pass an already economic child value through a raw-metric normalizer as though it were a raw mechanical measurement.

Do not charge a reusable tool at full acquisition cost for every resource operation when it is objectively reused over the declared horizon.

If lifecycle usage, replacement, repair, or provisioning cannot be objectively established, the equipment burden may remain UNKNOWN.

---

## 9. Path selection verification

Current default path policy is `best_known_repeatable_cost`.

Verify:

- only eligible, survival-valid, repeatable, complete paths participate in the resolved minimum;
- known paths may resolve even when other eligible alternatives remain UNKNOWN;
- UNKNOWN alternatives are not interpreted as zero;
- UNKNOWN alternatives are not fabricated into a large penalty;
- selection quality is explicit.

Use:

```text
BEST_KNOWN
```

when the selected result is the best known qualifying path but not all eligible alternatives are definitively resolved.

Use:

```text
PROVEN_GLOBAL_MIN
```

only when candidate discovery is complete and every eligible repeatable alternative is definitively resolved.

Do not silently claim global optimality from incomplete path discovery.

---

## 10. Terminal and recursion verification

For terminal-like resources, verify that a result does not recurse into itself.

A recursive economic chain is valid only when it bottoms out in an independently resolved authoritative basis, such as explicit `EconomicProfileOverride` where permitted by the governing contract.

Example:

```text
wheat override = 10
3 wheat → bread
bread = 30
```

is valid recursion.

But:

```text
wheat UNKNOWN
3 wheat → bread
bread UNKNOWN
```

must remain unresolved unless bread has an independent resolved basis.

Do not invent terminal constants just to break recursion.

---

## 11. Determinism and evidence verification

With identical authoritative mechanical evidence and identical economic policy/configuration, independent implementations should produce the same result.

Check:

- deterministic provider/effective-model resolution;
- provider-order independence where required;
- stable path canonicalization/deduplication;
- stable path selection;
- stable horizon semantics;
- stable snapshot inputs/signature boundary;
- no dependence on runtime player state;
- no hidden random selection in analysis;
- no use of wall-clock time unless explicitly part of the declared contract.

Every derived number should be traceable to:

```text
source mechanic
→ evidence/measurement
→ transformation
→ semantic owner
→ final result
```

---

## 12. Population and calibration boundary

Verify the dependency direction:

```text
EconomicCost
    ↓
population / identity
    ↓
calibration
    ↓
FoodIndex
    ↓
food value
```

Calibration must not create or redefine terminal `EconomicCost`.

Changing population selection, calibration weights, or FoodIndex mapping must not silently change the canonical economic primitive unless the governing documents explicitly define that dependency.

Do not use FoodIndex, calibration data, or population-derived values as hidden economic inputs.

---

## 13. Snapshot and provenance verification

When the change affects generated economic state, verify that the snapshot records enough provenance to explain the result.

At minimum, where applicable:

- semantic/specification version;
- relevant economic policy;
- canonical starting-state policy;
- horizon;
- provider/effective-mechanic provenance;
- source/evidence provenance;
- path-selection quality;
- status/reason codes.

Do not allow a result to depend on policy that is absent from the effective input/signature boundary when the governing contract requires policy to be snapshot-stable.

---

## 14. Verification procedure

For each requested verification:

### Step 1 — Identify the claimed behavior

State exactly what changed or is claimed to be fixed.

### Step 2 — Identify the governing authority

Name the owning document and section.

### Step 3 — Trace the semantic path

```text
input/evidence
→ mapping
→ measurement
→ cycle/horizon
→ cost vector
→ acquisition cost
→ path policy
→ economic cost
```

### Step 4 — Test invariants

Check status, probability ownership, quantity, equipment, horizon, recursion, path selection, and determinism as applicable.

### Step 5 — Run implementation tests

Use repository tests/build tools when appropriate, but treat test results as evidence rather than specification.

### Step 6 — Inspect representative outputs

Prefer a small set of high-signal cases, including:

- one directly acquired terminal resource;
- one recursive recipe;
- one deterministic loot case;
- one probabilistic loot case;
- one worldgen case;
- one crop/renewal case;
- one required-tool case;
- one UNKNOWN case.

### Step 7 — Report semantic and technical results separately

Use:

```text
SPECIFICATION: PASS / FAIL / BLOCKED
SEMANTIC MODEL: PASS / FAIL / BLOCKED
IMPLEMENTATION: PASS / FAIL / BLOCKED
TESTS: PASS / FAIL / NOT RUN
```

Do not call the task fully verified if only implementation tests passed.

---

## 15. Required final verification report

Use this structure:

```text
## Verification Scope

## Governing Authority

## Claimed Change

## Semantic Trace

## Invariants Checked

## Representative Cases

## Test Results

## Evidence / Provenance

## Findings
- PASS
- FAIL
- BLOCKED
- UNKNOWN

## Required Changes
```

For every failure, identify:

```text
document
section
implementation location
violated invariant
observed behavior
expected behavior
minimal correction
```

Do not propose unrelated refactors.

---

## 16. Hard stops

Stop and report instead of guessing when:

- the governing contract does not define the needed semantic;
- a terminal value requires an invented constant;
- scalarization needs an unspecified exchange rate;
- probability ownership is ambiguous;
- path aggregation policy is unspecified;
- a measurement lacks an objective unit or protocol;
- a cycle can produce arbitrage/zero-cost loops and no cycle rule exists;
- the implementation and normative specification disagree and the authority cannot be resolved;
- a requested fix would require changing the contract rather than merely implementing it.

The objective of verification is not to maximize the number of resolved resources.

The objective is to establish that the implementation faithfully realizes the defined model and that unresolved cases remain honestly unresolved.
