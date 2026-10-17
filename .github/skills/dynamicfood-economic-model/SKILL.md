---
name: dynamicfood-economic-model
description: Apply DynamicFood's current economic model without semantic drift. Use when designing, reviewing, implementing, or debugging EconomicCost, AcquisitionCost, CostVector, recursive economics, probability handling, equipment burden, horizon semantics, path selection, or EconomicProfileOverride behavior.
---

# DynamicFood Economic Model

This skill defines the active economic semantics. Treat it as a guardrail against converting arbitrary Minecraft measurements into fabricated economic values.

## 1. Core semantic separation

Always keep these distinct:

```text
RawMetric
NormalizedFactor
AcquisitionCost
EconomicCost
Difficulty
FoodIndex
Nutrition
Saturation
```

In particular:

```text
EconomicCost != AcquisitionCost
EconomicCost != Difficulty
EconomicCost != FoodIndex
```

`AcquisitionCost` is path-level.

`EconomicCost` is resource-level and is the canonical economic value used for cross-resource comparison and recursive material economics.

`EconomicCost` is a policy-defined economic burden, not a universal market price discovered from the name of a resource.

## 2. Static economic pipeline

Preserve this direction:

```text
Provider Contributions
    -> Validation
    -> Effective Mechanic Model
    -> Acquisition Discovery
    -> Candidate Acquisition Paths
    -> Context / Requirements / Capability Satisfaction
    -> AcquisitionMeasurements
    -> Probability / Distribution Analysis
    -> Feasibility Resolution
    -> Path Canonicalization / Deduplication
    -> Canonical Economic Factors
    -> CostVector
    -> AcquisitionCost(path, H)
    -> eligible/repeatable path selection
    -> EconomicCost(resource)
    -> EconomicSnapshot
    -> population / identity
    -> calibration
    -> runtime
```

Do not reverse this dependency graph.

## 3. Canonical economic measurements

The current core economic measurement set is exactly:

```text
quantity
probability_burden
material_consumption
equipment_economic_burden
```

Every applicable core measurement must be classified as:

```text
KNOWN
UNKNOWN
NOT_APPLICABLE
```

Rules:

- `KNOWN(0)` is a real measurement;
- `NOT_APPLICABLE` means the channel does not participate in the declared operation or is already represented by another canonical channel;
- `UNKNOWN` means the channel applies but cannot currently be established defensibly;
- `UNKNOWN != 0`;
- `NOT_APPLICABLE != UNKNOWN`.

An applicable UNKNOWN core measurement blocks `CORE-COMPLETE` for that path.

`operation_duration` remains an objective acquisition measurement, but it is not a universal core economic dimension. Do not make every path unresolved merely because a general player-obtaining time is unavailable.

## 4. Quantity semantics

`quantity` represents canonical expected player-obtainable output per declared operation/cycle.

Preserve:

- unit;
- source;
- evidence;
- estimate kind.

When stochastic output selection determines expected output, derive expected quantity from the actual stochastic model. Do not apply another inverse-probability or rarity penalty for the same selection event.

Example:

```text
P(target output) = 0.05
conditional quantity = 1
ExpectedQuantity = 0.05
```

That probability is owned economically by the quantity channel for this output-selection event.

## 5. Probability ownership

Use typed probability roles:

```text
AvailabilityProbability
ProgressProbability
SelectionProbability
RenewalProbability
```

They do not all become independent economic penalties.

Economic ownership:

```text
SelectionProbability
    -> ExpectedQuantity

AvailabilityProbability
ProgressProbability
    -> ProbabilityBurden, when they represent an independent burden-bearing opportunity process

RenewalProbability
    -> CycleProfile / material renewal semantics
```

The same causal stochastic event may feed more than one dependent calculation when it provides different state information, but it must not create more than one independent economic charge for the same burden.

For a simple repeated memoryless Bernoulli stage:

```text
E[opportunities] = 1 / p
ProbabilityBurden = -ln(p) = ln(E[opportunities])
```

`1/p` is diagnostic expected-opportunity evidence, not the canonical scalar itself.

Do not apply `-ln(p)` mechanically to arbitrary branching, retries, state-transition, or renewal graphs. Composite stochastic processes require causal/dependency analysis, an explicit opportunity unit, and a finite defensible composition. Otherwise the result is `UNKNOWN`.

Probability values without comparable opportunity units are not cross-mechanic comparable.

## 6. Material consumption and recursion

Material consumption is resource-specific evidence. It is not a universal scalar until the material resources themselves have a resolved economic magnitude under the active policy.

If resource A requires B:

```text
EconomicCost(A) depends on EconomicCost(B)
```

Only a resolved child `EconomicCost` or an explicitly authoritative `EconomicProfileOverride` may seed the recursive economic magnitude.

If the child is UNKNOWN, the dependent material contribution remains UNKNOWN unless another independent parent path avoids that dependency.

A child EconomicCost is already on the active [0,1] policy scale. **Never pass it through a raw-metric normalizer again.**

Do not use:

- Difficulty;
- FoodIndex;
- rarity;
- population rank;
- arbitrary terminal constants;
- vanilla prices;
- hidden exchange rates

to close recursive UNKNOWN values.

## 7. Equipment economic burden

`equipment_economic_burden` is the single canonical economic channel for required equipment.

There is no separate economic `EquipmentRequirement` factor.

The burden may include, where mechanically supported:

- initial equipment acquisition;
- usage/depletion;
- durability consumption;
- repair/restoration;
- replacement over horizon H.

The tool's own materials are resolved through the tool's recursive economics and are not charged again as parent-path material consumption for the same event.

Conceptually, for a required equipment item `e`:

```text
A_e(H) = expected lifecycle acquisition/restoration/replacement events
C_e    = resolved EconomicCost(e) or authoritative override
```

The equipment channel composes those mechanically derived lifecycle events with `C_e`, then applies any explicitly defined equipment-specific bounded normalization exactly once.

Do not normalize `C_e` as if it were a raw metric.

If the required equipment's lifecycle cannot be resolved without inventing a value, the equipment burden is UNKNOWN.

## 8. Operation-duration semantics

`operation_duration` means intrinsic/mechanically entailed duration of the declared acquisition operation under the specified protocol and context.

It does not automatically include:

- search time;
- travel time;
- setup time;
- generic progression time;
- player reaction/input time;
- generic combat time;
- locating a world-generated resource.

Those require an explicit acquisition protocol if they are to become economic measurements.

Do not treat Minecraft ticks, elapsed time, or player activity time as a universal economic numeraire merely because they are numeric.

## 9. Cycle and horizon

`CycleProfile` owns:

- startup semantics;
- recurring semantics;
- repeatability;
- renewability;
- lifecycle behavior.

Default horizon:

```text
H = 100
```

Startup is charged once.

Recurring burdens scale with the declared horizon where appropriate.

Apply the horizon to the raw modeled lifecycle/burden structure before normalization. Never multiply an already normalized AcquisitionCost or EconomicCost by H.

Do not invent durability lifetimes or repair cycles that the mechanics do not establish.

## 10. AcquisitionCost

`AcquisitionCost` is the path-level weighted aggregate of normalized economic factors under the active Economic Policy and declared horizon.

It is not the same semantic type as EconomicCost.

A path is `CORE-COMPLETE` only when every applicable core measurement is KNOWN or NOT_APPLICABLE.

Additional structural/lifecycle concepts such as progression, prerequisite, intermediate, danger, transport, repeatability, startup, and recurring semantics are not silently converted into arbitrary generic scalar factors.

KNOWN additional evidence may affect the path only where the active contract explicitly gives it economic ownership.

## 11. EconomicCost path selection

The default resource policy is:

```text
best_known_repeatable_cost
```

Choose the minimum resolved `AcquisitionCost` among eligible, survival-valid, repeatable paths at the same configured horizon.

The result carries selection quality:

```text
BEST_KNOWN
```

unless candidate path discovery is complete and every eligible repeatable path has a definitive comparison state, in which case:

```text
PROVEN_GLOBAL_MIN
```

An UNKNOWN eligible alternative is not a numeric candidate and is not interpreted as zero or as an arbitrarily large penalty.

If no eligible complete path resolves, resource-level `EconomicCost` remains `UNKNOWN`.

Do not silently substitute:

- cheapest path because the specification changed it;
- first discovered path;
- average path;
- sum of all paths;
- most common path.

Only use the currently declared path-selection policy.

## 12. EconomicCost bounds and override

Under the active Economic Policy:

```text
0 <= AcquisitionCost <= 1
0 <= EconomicCost <= 1
```

A resolved value must be finite, deterministic, and comparable only under the same policy version/configuration.

`EconomicProfileOverride` is an explicit authoritative resource-level EconomicCost input.

It is NOT:

- acquisition evidence;
- AcquisitionCost;
- calibration data;
- an inferred terminal primitive;
- a hidden substitute for automatic economics.

It may seed recursive economics exactly as an authoritative resource-level EconomicCost.

Do not silently rescale legacy overrides outside the active policy range.

## 13. Provider boundary

Providers describe mechanical facts and evidence. They do not directly calculate EconomicCost.

Providers may contribute:

- AcquisitionContext;
- AcquisitionRequirements;
- RequirementExpression;
- Capability / CapabilitySatisfaction;
- access/transition edges;
- acquisition candidates;
- raw measurements;
- evidence/provenance.

Provider conflicts must resolve through the deterministic Effective Mechanic Model. Registration order must not silently decide semantics.

## 14. Normalization boundary

Always know whether a value is:

```text
raw
normalized
absolute economic magnitude
```

Never pass:

- a normalized factor through a raw normalizer;
- a child EconomicCost through a raw normalizer;
- AcquisitionCost directly into a factor normalizer;
- EconomicCost into a factor normalizer.

Use explicit semantic boundaries instead.

## 15. Calibration and runtime boundary

Never derive EconomicCost from:

- FoodIndex;
- calibration weights;
- population rank;
- food curves;
- runtime gameplay observations.

The dependency direction is:

```text
EconomicCost
    -> population / identity
    -> calibration
    -> FoodIndex
    -> food value
    -> runtime
```

Calibration-only changes must not silently redefine static EconomicCost.

Ordinary gameplay must not mutate a published EconomicSnapshot.

## 16. Failure-safe behavior

When evidence is missing, unsupported, contradictory, or non-comparable:

```text
preserve evidence
classify the limitation
record provenance/reason
return UNKNOWN or BLOCKED as appropriate
```

Never use zero as a missing-value fallback.

Do not fabricate a terminal seed simply to break recursion.

Do not increase resolution coverage merely by weakening semantic gates.

## 17. Economic model review checklist

Before accepting an economic implementation change, verify:

- semantic scope is explicit;
- core applicability is explicit;
- UNKNOWN/NOT_APPLICABLE/KNOWN(0) remain distinct;
- quantity and probability ownership are explicit;
- probability is not double-counted;
- material recursion has a defined child boundary;
- equipment lifecycle is charged once through its canonical channel;
- horizon semantics are applied before normalization;
- child EconomicCost is not normalized again;
- path selection is the declared policy;
- EconomicCost remains resource-level;
- overrides remain authoritative but non-automatic;
- calibration and population remain downstream;
- unsupported mechanics remain UNKNOWN;
- deterministic policy/configuration is preserved.
