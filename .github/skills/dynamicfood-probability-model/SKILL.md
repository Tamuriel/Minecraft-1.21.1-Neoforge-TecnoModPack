---
name: dynamicfood-probability-model
description: Define, inspect, and implement DynamicFood probability semantics, including availability, progress, selection, renewal, expected quantity, probability burden, opportunity units, stochastic composition, and double-counting prevention.
---

# DynamicFood Probability Model Skill

## Purpose

Use this skill whenever DynamicFood must interpret, extract, model, normalize, compose, or verify probability originating from Minecraft mechanics or acquisition processes.

Probability is an economic input only through explicitly defined semantic roles.

Do not treat every probability-like value as a generic scalar cost.

This skill defines the boundary between:

```text
Minecraft stochastic mechanics
        ↓
probability evidence
        ↓
DynamicFood probability semantics
        ↓
quantity / probability burden / renewal / cycle
```

The governing documents remain authoritative. Before changing semantic behavior, read the relevant current sections of:

- `01_Master_Spec.md`
- `06_PHASE_01_ECONOMIC_MODEL.md`
- `07_PHASE_02_ACQUISITION.md`
- `11_PHASE_06_VERIFICATION.md`
- `12_AI_WORK_PROTOCOL.md`
- `13_FINAL_ACCEPTANCE.md`

Also consult `dynamicfood-spec-navigation`, `dynamicfood-economic-model`, and `dynamicfood-semantic-mapping` where available.

---

## 1. Probability is structured evidence

Do not flatten probability into one generic field such as:

```text
probability
chance
rarity
weight
```

DynamicFood distinguishes at least four probability roles:

```text
AvailabilityProbability
ProgressProbability
SelectionProbability
RenewalProbability
```

The type is determined by the causal role of the stochastic event.

The same numeric value can have different semantics in different contexts.

For example:

```text
0.05 chance that a worldgen source is encountered per chunk
```

is not the same economic event as:

```text
0.05 chance that a loot-table branch selects a target item
```

---

## 2. AvailabilityProbability

### Meaning

Probability that a required acquisition opportunity/source becomes available within a declared search/provisioning unit.

Examples:

- source occurrence per chunk;
- feature availability per declared worldgen search unit;
- opportunity to encounter a required source.

### Economic owner

```text
ProbabilityBurden
```

when the availability process itself is a genuine independent burden.

### Requirements

An availability probability is not complete unless its opportunity/search unit is explicit.

Examples of valid units may include:

```text
chunk
section
declared feature-placement unit
explicit search unit
```

Do not compare probabilities expressed per incompatible units.

Do not invent a conversion between search units.

---

## 3. ProgressProbability

### Meaning

Probability that one declared stochastic opportunity advances a process.

Examples:

- crop growth opportunity;
- fishing trigger opportunity;
- random process step.

### Economic owner

```text
ProbabilityBurden
```

when the stochastic opportunity is an acquisition burden distinct from output selection.

For a simple repeated memoryless Bernoulli stage:

```text
p = progress probability per opportunity
E[opportunities] = 1 / p
ProbabilityBurden = -ln(p)
```

This formula is canonical only for the stated simple repeated process.

Do not apply it mechanically to arbitrary stochastic graphs.

---

## 4. SelectionProbability

### Meaning

Conditional probability that a particular output branch/result is selected after a relevant selection event.

Examples:

- loot-table branch selection;
- weighted result selection;
- fishing result selection;
- random reward branch.

### Economic owner

```text
ExpectedQuantity
```

not an independent second probability penalty.

Typical chain:

```text
SelectionProbability
+ QuantityDistribution
+ RollMultiplicity
→ ExpectedQuantity
```

Example:

```text
P(target) = 0.05
quantity = 1
ExpectedQuantity = 0.05
```

Do not additionally apply:

```text
-ln(0.05)
```

as `ProbabilityBurden` when the 0.05 event is only the output-selection process represented in ExpectedQuantity.

That would double-charge the same causal burden.

---

## 5. RenewalProbability

### Meaning

Probability that a production/acquisition cycle returns the state or input required to continue the cycle.

Examples:

- seed return;
- renewable catalyst;
- self-sustaining cycle input.

### Economic owner

RenewalProbability feeds:

```text
CycleProfile
and/or
material semantics
```

It does not automatically become another `ProbabilityBurden`.

Example:

```text
crop output
→ expected food quantity
→ expected seed return
→ renewal requirement
```

The renewal event can affect cycle sustainability without creating an additional independent stochastic charge.

---

## 6. Economic ownership invariant

The central rule is:

> The same causal stochastic event must not create more than one independent economic charge for the same burden.

However, the same event may be reused as evidence for different dependent calculations when those calculations represent different state information.

Valid:

```text
seed-return probability
→ expected seed output
→ renewal/cycle analysis
```

Invalid:

```text
seed-return probability
→ expected quantity penalty
→ probability burden
→ extra inverse-probability material charge
```

The distinction is causal, not based on whether the same numeric probability appears in multiple objects.

---

## 7. Probability profiles

A `ProbabilityProfile` should preserve enough structure to answer:

```text
What event is stochastic?
What is the opportunity/attempt unit?
What is the mechanical scope?
What is the parent/conditioning relation?
How many rolls/opportunities occur?
What distribution/result does it control?
What evidence supports it?
```

Record, where applicable:

- probability/distribution;
- opportunity or attempt unit;
- mechanical scope/context;
- conditioning/parent relation;
- multiplicity/roll semantics;
- estimate kind;
- source/provenance;
- applicable horizon/cycle context.

Avoid storing an unexplained scalar probability without the event and unit that give it meaning.

---

## 8. Weighted loot and branch selection

Loot weights, rolls, bonus rolls, conditions, and branch structure are stochastic mechanics.

Do not map:

```text
weight
→ ProbabilityBurden
```

directly.

First reconstruct the selection process well enough to derive conditional selection probability or expected quantity.

Distinguish:

```text
selection probability
roll multiplicity
quantity distribution
conditions
independent opportunities
```

A single probability scalar is not sufficient when the stochastic structure changes with rolls, branches, or conditions.

When exact reconstruction is not supported by available evidence:

```text
UNKNOWN
```

is preferable to an invented approximation.

---

## 9. Simple Bernoulli composition

For a sequence of independent or conditionally compatible burden-bearing stages with actual probabilities:

```text
p1, p2, ..., pn
```

the corresponding log burden may compose additively where the causal structure justifies it:

```text
-ln(p1) + -ln(p2) + ... + -ln(pn)
=
-ln(p1 * p2 * ... * pn)
```

Use this only when:

- the stages are genuine burden-bearing stages;
- the causal sequence is correctly identified;
- independence/conditional structure is understood;
- opportunity units are compatible;
- no stateful branching or retry semantics invalidate the simple product.

Do not collapse an arbitrary stochastic graph into a product of probabilities.

---

## 10. Diagnostic expected opportunities

For a simple Bernoulli stage:

```text
E[opportunities] = 1 / p
```

This is useful mechanical evidence.

It is not itself the canonical `ProbabilityBurden`.

Canonical scalar:

```text
ProbabilityBurden = -ln(p)
```

The logarithmic form provides an additive dimensionless burden for independent sequential stages.

Do not convert:

```text
1/p → arbitrary normalized factor
```

before determining whether the declared probability semantics call for `ProbabilityBurden`.

---

## 11. Zero and boundary values

For probability used in the probability model:

```text
p = 1
→ ProbabilityBurden = 0
```

A deterministic event has no stochastic burden.

For:

```text
p = 0
```

do not silently substitute a large finite cost.

Determine whether the event means:

- impossible/INFEASIBLE under the current mechanics;
- unavailable in the declared context;
- a malformed/invalid probability;
- an unresolved dynamic condition.

Represent the semantic state correctly.

Do not use epsilon unless the governing contract explicitly defines epsilon behavior.

---

## 12. Horizon interaction

Probability is not itself a horizon multiplier.

For repeated cycles, the horizon interacts with the process through:

```text
CycleProfile
repeatability
renewal
expected number of operations
startup/recurring schedule
```

Do not multiply a normalized probability burden by H simply because the acquisition repeats.

Model the underlying repeated stochastic process first.

Then let the established `CycleProfile` and cost composition derive the horizon-aware burden.

---

## 13. Probability and quantity must remain distinct

Verify this distinction:

```text
ProbabilityBurden
=
burden of stochastic opportunity/progress/availability

ExpectedQuantity
=
expected amount produced by the declared operation
```

These may depend on related evidence, but they are not interchangeable.

Example:

```text
rare loot result
P(target selection) = 0.05
quantity = 1
→ ExpectedQuantity = 0.05
```

No additional probability burden follows from selection probability alone.

Conversely:

```text
worldgen source found with P=0.02 per chunk
```

can produce:

```text
ProbabilityBurden = -ln(0.02)
```

because discovery/availability is a separate burden-bearing stage.

Worldgen discovery and loot output selection may therefore coexist without being contradictory, provided they are genuinely different causal events.

---

## 14. Probability and materials

Do not turn probability directly into material consumption.

A probability can change expected material requirements only when the renewal/cycle or quantity model objectively establishes that relationship.

Example:

```text
seed return probability
→ expected seed return
→ renewal/material requirement
```

Do not simultaneously add a generic stochastic cost for the same seed-return event.

---

## 15. Probability and equipment

Probability does not automatically imply equipment burden.

Equipment burden must come from actual equipment lifecycle evidence:

```text
provisioning
usage/depletion
repair/restoration
replacement
```

A rare drop that requires a tool does not make the tool a probability cost.

The stochastic process and equipment lifecycle remain distinct causal channels.

---

## 16. Unknown policy

Return UNKNOWN when:

- the stochastic event cannot be identified;
- the opportunity/attempt unit is missing or incomparable;
- selection and availability roles cannot be separated;
- the stochastic graph has unresolved dependencies;
- retries/state transitions cannot be modeled objectively;
- a required conversion between incompatible opportunity units is absent;
- the implementation only exposes an aggregate number whose semantics are ambiguous.

Do not resolve such cases using:

```text
rarity
difficulty
ticks
player time
arbitrary weights
fixed terminal prices
FoodIndex
calibration
```

---

## 17. Mapping procedure

For every new Minecraft probability-like input:

### Step 1

Identify the underlying event.

### Step 2

Identify its declared opportunity/attempt unit.

### Step 3

Classify the event:

```text
availability
progress
selection
renewal
```

### Step 4

Determine its economic owner.

### Step 5

Determine whether expected quantity already incorporates the stochastic selection.

### Step 6

Determine whether the event is independent from other burden-bearing stochastic stages.

### Step 7

Compose using the actual causal structure.

### Step 8

Check for double charging.

### Step 9

Preserve provenance and UNKNOWN conditions.

---

## 18. Required tests

At minimum, test conceptually or with implementation fixtures:

### Deterministic event

```text
p = 1
→ ProbabilityBurden = 0
```

### Simple progress event

```text
p = 0.5
→ expected opportunities = 2
→ ProbabilityBurden = ln(2)
```

### Rare availability

```text
p = 0.02 per declared search unit
→ expected search units = 50
→ ProbabilityBurden = -ln(0.02)
```

### Selection-only probability

```text
P(target) = 0.05
quantity = 1
→ ExpectedQuantity = 0.05
→ no independent ProbabilityBurden
```

### Independent availability + selection

```text
P(source available) = 0.02
P(target selected | source) = 0.05
```

Verify that the two probabilities retain different causal ownerships.

### Renewal

Verify that seed/catalyst return probability affects cycle/material semantics without becoming a second probability charge.

---

## 19. Hard stops

Never:

- add inverse probability to every rare event;
- apply `-ln(p)` to every probability field;
- treat loot weight as generic rarity;
- treat selection probability as probability burden;
- treat renewal probability as an additional stochastic charge when already represented in cycle/material semantics;
- invent probability units;
- compare probabilities with incompatible opportunity units;
- hide probability inside Difficulty or AcquisitionCost;
- use calibration weights to make probabilities comparable;
- resolve an unsupported stochastic graph with a heuristic scalar.

When exact semantics cannot be established:

```text
UNKNOWN
```

is the correct outcome.
