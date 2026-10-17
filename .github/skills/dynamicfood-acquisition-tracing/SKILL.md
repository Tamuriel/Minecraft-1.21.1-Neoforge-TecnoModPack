---

name: dynamicfood-acquisition-tracing
description: Trace a DynamicFood acquisition path from current Minecraft/mod mechanics through context, requirements, capability satisfaction, feasibility, canonicalization, measurements, cycle/horizon semantics, CostVector, AcquisitionCost, and resource-level EconomicCost. Use when implementing, debugging, reviewing, or explaining acquisition analyzers, path construction, recursive economics, probability evidence, or UNKNOWN propagation.
---

# DynamicFood Acquisition Tracing

## Purpose

Use this skill to reason about how an observable Minecraft acquisition mechanic becomes a DynamicFood acquisition path and, when the contract permits, an economic result.

This skill traces semantics. It does not invent missing economics.

The governing documents remain authoritative. At minimum, read:

1. `01_Master_Spec.md`
2. `02_Baseline.md`
3. `03_Requirements_Matrix.md`
4. `04_Audit.md`
5. `05_State.md`
6. `06_PHASE_01_ECONOMIC_MODEL.md`
7. `07_PHASE_02_ACQUISITION.md`

For lifecycle, generation, calibration, or runtime questions also inspect the applicable phase documents and `12_AI_WORK_PROTOCOL.md`.

When repository code and the governing documents disagree, identify the disagreement. Do not silently invent a third interpretation.

---

# 1. Canonical acquisition pipeline

Reason through acquisition in this order:

```text
Provider Contributions
    -> validation
    -> Effective Mechanic Model
    -> acquisition discovery
    -> candidate AcquisitionPath
    -> AcquisitionContext
    -> AcquisitionRequirements
    -> Capability / Access Satisfaction
    -> Feasibility
    -> Path canonicalization / deduplication
    -> AcquisitionMeasurements
    -> Probability / distribution analysis
    -> CycleProfile / horizon semantics
    -> CostVector
    -> AcquisitionCost(path, H)
    -> eligible/repeatable path selection
    -> EconomicCost(resource)
    -> EconomicSnapshot
```

Do not skip semantic layers merely because a direct calculation appears convenient.

Do not let runtime gameplay re-enter this static acquisition pipeline.

---

# 2. Canonical starting state

Automatic acquisition analysis uses this economic protocol unless the active specification explicitly changes it:

```text
inventory = empty
pre-owned equipment = none
intrinsic survival capabilities = ordinary survival-player capabilities
initial access = only explicitly configured starting dimensions/access
target-specific preparation/infrastructure = none
```

This is a cross-path economic baseline, not a literal spawn-state claim.

Never silently assume:

* an existing tool;
* existing stock/materials;
* pre-built infrastructure;
* pre-completed target progression;
* a runtime player's current inventory;
* a runtime player's current location or state.

Required equipment and prerequisite resources must therefore be modeled recursively from the baseline when their economics are in scope.

---

# 3. Context, requirements, satisfiers, measurements

Keep these concepts separate.

### AcquisitionContext

Describes the circumstances under which a mechanic exists:

* resource;
* source/mechanic;
* dimension/world context;
* environment/state;
* source object;
* other explicit mechanical evidence.

Context is not an economic factor merely because it is numeric or enumerable.

### AcquisitionRequirements

Describe objectively established conditions that the path must satisfy.

Examples include:

* mining tier;
* required station;
* required access;
* required mechanism;
* required state.

A requirement does not become an economic charge merely because it exists.

### Capability / Access Satisfaction

Describes how a requirement is satisfied.

For example:

```text
requirement: pressure_resistance >= 2
satisfier A: diving_suit
satisfier B: submarine
```

`ANY(A,B)` creates alternative candidate paths. `ALL(A,B)` requires all branches.

Do not manufacture impossible combined paths by merging mutually alternative satisfiers.

### AcquisitionMeasurements

Measure the already selected operation/path. They are not requirements and not final economics.

Current semantic vocabulary includes:

* `quantity`;
* `operation_duration`;
* `material_consumption` evidence;
* equipment usage/lifecycle evidence;
* `ProbabilityProfile` where stochastic mechanics are present.

The economic core is not a universal requirement to produce four numeric values on every mechanic.

---

# 4. Measurement applicability

Classify each applicable economic measurement as:

```text
KNOWN
UNKNOWN
NOT_APPLICABLE
```

Also preserve `INFEASIBLE` and `CONFLICT` at the path/model level where applicable.

Rules:

* `KNOWN(0)` is a measured zero, not `NOT_APPLICABLE`.
* `UNKNOWN` means evidence is insufficient for a defensible result.
* `NOT_APPLICABLE` means the burden does not belong to the declared operation, or the same burden is already represented by another canonical channel and charging it again would double count.
* `INFEASIBLE` means the path is known impossible; it is not a high-cost path.
* `CONFLICT` means deterministic mechanic resolution failed; do not guess.

Never convert `UNKNOWN` to zero, infinity, a default penalty, or a fabricated estimate.

---

# 5. Current economic core

The active core economic measurements are:

```text
quantity
probability_burden
material_consumption
equipment_economic_burden
```

`operation_duration` remains a supported objective measurement but is not a universal core completeness gate.

A path is `CORE-COMPLETE` only when every applicable core measurement is `KNOWN` or `NOT_APPLICABLE`.

Do not use an old phase document, historical audit, or stale class comment to restore `time` as a universal core factor. Historical checkpoints may retain the former model for evidence only.

---

# 6. Quantity tracing

Canonical quantity means expected player-obtainable output per declared operation/cycle where stochastic output exists.

For stochastic output:

```text
SelectionProbability
+ QuantityDistribution
+ RollMultiplicity
    -> ExpectedQuantity
```

Use the actual mechanical distribution when it is analytically supported.

Do not:

* add an inverse-probability penalty to output-selection probability already reflected in expected quantity;
* count raw roll count as economic cost by itself;
* confuse units per operation with units per tick without an explicit conversion;
* infer quantity from item rarity or registry frequency.

A lower expected quantity may produce greater normalized quantity burden under the active quantity normalizer. That is a policy transformation at the factor boundary, not a universal raw economic unit.

---

# 7. Probability tracing

Preserve a typed `ProbabilityProfile` when stochastic mechanics are present.

Recognize these semantic roles:

```text
AvailabilityProbability -> ProbabilityBurden
ProgressProbability     -> ProbabilityBurden
SelectionProbability    -> ExpectedQuantity
RenewalProbability      -> CycleProfile / material semantics
```

For a simple repeated memoryless Bernoulli stage:

```text
expected opportunities = 1 / p
ProbabilityBurden = -ln(p) = ln(expected opportunities)
```

Do not apply this formula mechanically to arbitrary stochastic graphs, retries, branching systems, or renewal processes.

The attempt/opportunity unit must be explicit. Probabilities without a comparable opportunity unit are not automatically comparable.

The same causal event may feed several dependent calculations as evidence, but it must not create more than one independent economic charge for the same burden.

---

# 8. Equipment tracing

`equipment_economic_burden` is the single economic representation of required equipment.

It may include:

* initial acquisition;
* usage/durability depletion;
* repair/restoration;
* replacement;
* horizon-dependent lifecycle events.

There is no separate economic `EquipmentRequirement` factor.

When equipment economics recurse:

```text
required equipment
    -> child EconomicCost
    -> mechanically established lifecycle event count
    -> equipment economic expenditure
    -> one equipment-specific bounded normalization, if configured
```

Never raw-normalize a child `EconomicCost` again.

Do not separately charge the same tool-manufacturing materials in the parent's material channel when they are already represented by the equipment lifecycle.

If required equipment or its lifecycle cannot be resolved without guessing, equipment burden is `UNKNOWN`.

---

# 9. Material and recursive economics

Material consumption is evidence of resources consumed by the acquisition operation.

A material child may contribute recursively only when its resource-level `EconomicCost` is resolved or an authoritative `EconomicProfileOverride` exists.

Conceptually:

```text
A requires B
B EconomicCost = resolved
    -> B contributes to A's material economics
```

If:

```text
B EconomicCost = UNKNOWN
```

then recursive material economics that depend on B remain unresolved.

Do not break recursion by inventing a terminal child price.

Do not use:

* AcquisitionCost as a terminal child economic price;
* Difficulty;
* rarity;
* FoodIndex;
* calibration statistics;
* vanilla currency prices.

`EconomicProfileOverride` is allowed only because it is explicit authoritative economic input.

---

# 10. Cycle and horizon tracing

Use the active `CycleProfile` and configured economic horizon.

Default horizon is `H = 100` unless the governing configuration says otherwise.

Keep:

```text
startup cost = charged once
recurring cost = scales with H
```

Do not multiply a normalized factor or an already normalized AcquisitionCost by H.

Model horizon effects in raw/derived burden before final normalization.

Repeatability and renewability are lifecycle/eligibility semantics, not arbitrary standalone scalar penalties.

---

# 11. Path construction and canonicalization

A concrete `AcquisitionPath` should have stable identity based on material acquisition semantics, source/mechanic, requirements/satisfiers, cycle profile, and relevant evidence.

Before economic aggregation:

```text
candidate discovery
    -> requirements
    -> capability/access satisfaction
    -> feasibility
    -> canonicalization
    -> deduplication
```

Do not create multiple economically distinct paths that differ only by irrelevant provider or iteration order.

Do not merge paths whose material acquisition semantics are actually different.

---

# 12. Path selection

The active default policy is:

```text
best_known_repeatable_cost
```

Choose the minimum resolved `AcquisitionCost` among eligible, survival-valid, repeatable, complete paths at the same horizon.

Record selection quality:

```text
BEST_KNOWN
PROVEN_GLOBAL_MIN
```

Use `PROVEN_GLOBAL_MIN` only when candidate discovery is complete and every eligible repeatable alternative has definitive comparison state.

Do not interpret an UNKNOWN alternative as zero or as an enormous penalty.

If no eligible repeatable path resolves, resource-level `EconomicCost` remains `UNKNOWN`.

---

# 13. Common acquisition-family rules

### Recipe

Trace actual output quantity, ingredient alternatives, ingredient counts, processing duration when exposed, reusable/remainder inputs, and recursive material economics.

### Loot

Trace loot pools, rolls, weighted/conditional selection, quantity distributions, and supported analytical semantics. Unsupported dynamic functions or conditions remain `UNKNOWN` rather than guessed.

### Crop

Trace growth/progress stochasticity, cycle output, seed/renewal semantics, and lifecycle. Do not invent a generic player action time.

### Worldgen

Separate source availability evidence from extraction economics. Placement frequency does not automatically become player search time or a universal rarity cost. Use an explicit search/provisioning unit only when the mechanic defines one.

### Mob loot

Trace supported loot semantics. Generic combat duration is outside the core contract unless an explicit combat protocol is declared.

### Fishing

Trace supported stochastic wait/progress and loot-selection semantics. Do not charge selection probability twice.

### Villager trade

Separate trade operation from provisioning. Payment/output quantities are evidence; profession, workstation, progression, rerolling and restock are separate structural or operational concerns. Do not invent a generic trade-duration factor.

---

# 14. Evidence quality

Supported results should identify one of:

```text
EXACT
ANALYTICAL
APPROXIMATED
UNKNOWN
```

`APPROXIMATED` requires reproducibility metadata: method, parameters, assumptions, algorithm/version, and deterministic seed where sampling is used.

Runtime observations are not static acquisition evidence unless the governing specification explicitly defines adaptive learning. Ordinary gameplay must not modify an EconomicSnapshot.

---

# 15. Debugging procedure

When a resource is unexpectedly `UNKNOWN`, trace backwards in this exact order:

1. resource identity;
2. candidate path discovery;
3. survival eligibility;
4. requirements and satisfiers;
5. feasibility;
6. path canonicalization/deduplication;
7. measurement applicability;
8. missing core measurement;
9. probability distribution/evidence;
10. cycle/horizon resolution;
11. recursive child EconomicCost;
12. CostVector completeness;
13. AcquisitionCost;
14. path selection quality;
15. EconomicCost publication.

Report the first unresolved semantic boundary. Do not patch the final resolver just to make the value appear.

---

# 16. Hard prohibitions

Never:

* convert UNKNOWN to 0;
* treat NOT_APPLICABLE as UNKNOWN;
* fabricate terminal prices;
* use rarity as EconomicCost;
* use Difficulty as EconomicCost;
* use FoodIndex/calibration as terminal economics;
* use runtime frequency as static economics;
* double count selection probability;
* charge equipment twice;
* charge recursive child economics twice;
* invent travel/search/combat time without an explicit protocol;
* make runtime gameplay rebuild acquisition economics;
* bypass canonical starting state by assuming pre-owned assets;
* select a path across incompatible horizons;
* claim global optimum when only BEST_KNOWN is proved.

When the contract cannot establish the result, preserve `UNKNOWN` and report the missing evidence or policy decision.

