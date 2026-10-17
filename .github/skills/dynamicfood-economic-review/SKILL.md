---
name: dynamicfood-economic-review
description: Review DynamicFood economic designs, implementations, and changes for semantic correctness, objective economic basis, recursion safety, probability ownership, horizon compatibility, path selection, and policy violations. Use for PR review, proposed fixes, economic resolver changes, acquisition changes, or decisions about resolving UNKNOWN values.
---

# DynamicFood Economic Review Skill

## Purpose

Use this skill when reviewing a proposed or existing change that could affect:

- `EconomicCost`;
- `AcquisitionCost`;
- acquisition measurements;
- terminal economics;
- recursive economics;
- probability;
- quantity;
- materials;
- equipment;
- horizons/cycles;
- path selection;
- calibration boundaries;
- population boundaries;
- provider/effective mechanic semantics.

This is a semantic review skill.

Its goal is to detect plausible-looking solutions that violate the DynamicFood economic contract.

It must prefer an explicit UNKNOWN or BLOCKED result over a fabricated economic value.

---

## 1. Authority first

Before judging an economic change, read the current governing documents relevant to the change.

At minimum:

1. `01_Master_Spec.md`
2. `06_PHASE_01_ECONOMIC_MODEL.md`
3. `07_PHASE_02_ACQUISITION.md`
4. `11_PHASE_06_VERIFICATION.md`
5. `12_AI_WORK_PROTOCOL.md`
6. `13_FINAL_ACCEPTANCE.md`

Use the remaining governing documents when the change crosses their ownership boundary.

Use:

- `dynamicfood-spec-navigation`
- `dynamicfood-economic-model`
- `dynamicfood-acquisition-tracing`
- `dynamicfood-verification`
- `dynamicfood-change-discipline`

as applicable.

Never resolve a document conflict silently.

---

## 2. Primary review question

For every proposed economic mechanism, ask:

> What does one unit of this value mean, and can two independent implementations derive the same value from identical authoritative mechanical evidence without agreeing on an arbitrary balancing preference?

A valid economic basis must be:

```text
objectively grounded
deterministic from authoritative evidence
semantically defined
comparable where composed
compatible with terminal and recursive cases
cross-mechanic where required
compatible with horizon semantics
free of arbitrary exchange rates
free of hidden balancing constants
```

---

## 3. Required semantic separation

Reject any proposal that silently collapses:

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

especially:

```text
EconomicCost == AcquisitionCost
EconomicCost == Difficulty
EconomicCost == FoodIndex
```

Also reject:

```text
EconomicCost := rarity
EconomicCost := rank
EconomicCost := vanilla price
EconomicCost := fixed material price table
EconomicCost := calibration result
```

unless the governing specification explicitly establishes such a dependency.

---

## 4. Identify the layer being changed

Classify the proposed change before evaluating it.

Possible layers:

```text
provider/mechanical evidence
effective mechanic model
acquisition requirements
feasibility/access
measurement
cycle/horizon
cost vector
AcquisitionCost
path selection
EconomicCost
population/identity
calibration
runtime
```

Check that the implementation places the behavior in the correct semantic layer.

Common architecture violations:

- provider computing EconomicCost;
- acquisition analyzer performing balancing;
- resolver inventing missing mechanical evidence;
- calibration supplying terminal economic values;
- runtime state influencing static economics;
- FoodIndex influencing EconomicCost;
- an adapter turning diagnostics into canonical economics without a contract.

---

## 5. Terminal-resource gate

This is the highest-priority review.

Ask:

```text
Can a terminal resource receive an automatic EconomicCost
without already requiring EconomicCost of another unresolved resource?
```

For at least representative cases such as:

```text
stone
wheat
coal
iron_ore
mob drop
world-generated resource
```

trace:

```text
available evidence
→ measurable quantities
→ proposed economic derivation
→ terminal or recursive?
→ independent base?
→ UNKNOWN conditions
```

Reject any design that breaks recursion by adding unexplained terminal constants.

Do not accept:

```text
stone = 1
coal = 5
iron = 10
```

merely because the numbers make recursion converge.

A terminal constant is valid only if the governing contract explicitly defines an authoritative terminal basis.

---

## 6. Scalarization audit

Acquisition evidence can be multidimensional:

```text
quantity
probability
materials
equipment
duration
progression
transport
danger
startup
recurring
renewability
```

For every proposed scalarization, identify:

```text
source dimensions
conversion rule
unit
objective justification
comparability
composition rule
terminal applicability
```

Reject transformations such as:

```text
seconds + materials
materials × rarity
durability + time
danger × quantity
actions × arbitrary weight
```

unless every coefficient is itself objectively derived from the canonical economic basis and explicitly defined by the governing specification.

Do not accept “normalized” as a semantic explanation.

Normalization requires a defined input meaning and basis.

---

## 7. Candidate primitive review

When a proposal introduces or relies on a candidate economic primitive, test:

| Property | Review question |
|---|---|
| Objective | Is the value mechanically defined? |
| Comparable | Can it be meaningfully composed across supported mechanics? |
| Deterministic | Same authoritative inputs → same result? |
| Terminal | Can it value terminal resources without recursion? |
| Recursive | Can derived resources build on it? |
| Circular | Does it introduce self-reference/cycles? |
| Cross-mechanic | Does the same unit work for different acquisition mechanisms? |
| Horizon | Can startup/recurring/repeated operations use it correctly? |
| Probability | Does stochastic structure compose without double charging? |
| Path | Can alternative paths be handled without hidden preference? |
| Arbitrage | Can cycles produce zero/negative/unbounded value? |
| UNKNOWN | Are missing inputs represented honestly? |

A primitive that fails terminal applicability is not automatically invalid if the governing architecture explicitly permits authoritative external inputs. But that external input must be a defined policy/input, not an invented constant.

---

## 8. Probability review

Use `dynamicfood-probability-model`.

At minimum, identify which probability role is involved:

```text
AvailabilityProbability
ProgressProbability
SelectionProbability
RenewalProbability
```

Verify ownership:

```text
SelectionProbability → ExpectedQuantity
Availability/ProgressProbability → ProbabilityBurden
RenewalProbability → CycleProfile/material semantics
```

Check that the same stochastic event is not charged twice.

A common invalid pattern:

```text
P(drop) = 0.05
→ ExpectedQuantity = 0.05
→ + ProbabilityBurden(-ln(0.05))
```

when both derive from the same output-selection event.

A valid independent combination can exist:

```text
P(source available)
→ ProbabilityBurden

P(target selected | source)
→ ExpectedQuantity
```

because they represent distinct causal events.

---

## 9. Quantity review

Check whether the proposed design correctly distinguishes:

```text
quantity produced
expected quantity
selection probability
number of rolls
renewal quantity
material consumption
```

Do not independently penalize a result for low probability after the probability has already reduced expected quantity.

Verify that quantity normalization is defined and applied once.

---

## 10. Equipment review

Required equipment is economically relevant.

Review whether:

```text
EquipmentEconomicBurden
```

captures objectively derived:

```text
initial provisioning/acquisition
usage/depletion
repair/restoration
replacement
```

over the declared horizon.

Do not create a generic separate economic factor for “equipment requirement” when the current model places this in `EquipmentEconomicBurden`.

Do not re-normalize a child tool `EconomicCost` as if it were a raw metric.

Do not charge a reusable tool's entire acquisition cost on every operation when lifecycle reuse is objectively modeled.

If lifecycle cannot be resolved, UNKNOWN may be the correct result.

---

## 11. Horizon review

Default horizon:

```text
H = 100
```

Verify:

```text
startup
recurring
repeatability
renewal
```

through `CycleProfile`.

Startup is charged once.

Recurring burden scales with H.

The horizon must change raw modeled burden before normalization/composition.

Reject:

```text
EconomicCost × H
AcquisitionCost × H
normalizedFactor × H
```

as a substitute for real schedule modeling.

Check conceptual behavior for:

```text
H = 1
H = 10
H = 100
```

---

## 12. Path-selection review

Current default:

```text
best_known_repeatable_cost
```

A selected path must be:

- eligible;
- survival-valid;
- repeatable where required;
- core-complete for applicable measurements;
- economically resolved.

UNKNOWN alternatives are not:

```text
zero
infinite
automatic failure of every known path
```

Unless the governing policy says otherwise.

Selection quality must distinguish:

```text
BEST_KNOWN
PROVEN_GLOBAL_MIN
```

Do not claim globally cheapest acquisition when candidate discovery or alternative resolution is incomplete.

If the specification does not define aggregation semantics for multiple paths, report:

```text
BLOCKED BY POLICY DECISION
```

rather than choosing cheapest/common/first/average/all-path semantics silently.

---

## 13. Cycle and arbitrage review

Build a dependency graph for recursive economics when the change affects recursion.

Look explicitly for:

```text
A → A
A → B → A
A → B → C → A
zero-cost loops
self-supplying loops
renewable cycles
duplication cycles
mutually dependent terminal values
```

Check whether the proposed model can create:

- zero economic cost for a nontrivial resource;
- negative cost;
- divergent recursion;
- path-dependent values that depend on traversal order;
- arbitrary cycle breaking.

Do not accept an implementation simply because memoization prevents infinite recursion.

Memoization fixes execution behavior; it does not define economics.

---

## 14. EconomicProfileOverride review

`EconomicProfileOverride` is an explicit authoritative economic input where permitted by the current specification.

It is not:

```text
automatic acquisition evidence
AcquisitionCost
calibration data
hidden terminal primitive
reason to fabricate other terminal prices
```

Valid use:

```text
override → authoritative resource EconomicCost
→ recursive economic composition
```

Invalid use:

```text
override → pretend to be mechanical evidence for an acquisition analyzer
```

or:

```text
override exists for one resource
→ invent fixed prices for all other resources
```

---

## 15. Baseline review

Verify against the canonical starting state:

```text
inventory = empty
pre-owned equipment = none
intrinsic survival capabilities = ordinary survival-player capabilities
initial access = explicitly configured access only
target-specific preparation/infrastructure = none
```

Reject designs that silently assume:

```text
pre-owned tools
stockpiled materials
existing farms
existing infrastructure
already-unlocked progression
runtime player inventory
```

unless explicitly represented as configured policy.

A future alternative baseline is an economic policy change and must participate in the appropriate snapshot/signature boundary.

---

## 16. Calibration boundary review

Dependency must remain:

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

Reject reverse dependencies such as:

```text
FoodIndex → EconomicCost
calibration weight → terminal price
population ranking → terminal price
```

unless the governing documents explicitly redefine the architecture.

Changing calibration must not silently redefine the canonical economic primitive.

---

## 17. UNKNOWN review

UNKNOWN is a valid semantic result.

Review whether the proposed change improperly uses:

```text
0
default constant
fallback price
vanilla price
rarity heuristic
difficulty heuristic
first available number
average
arbitrary penalty
```

to resolve missing evidence.

Prefer:

```text
UNKNOWN
```

with a precise reason over a numerically complete but semantically false result.

Also preserve:

```text
NOT_APPLICABLE
INFEASIBLE
CONFLICT
```

as distinct statuses where applicable.

---

## 18. Objectivity test

A proposal passes the objectivity test only when:

```text
Implementation A
+
Implementation B
+
same authoritative evidence
+
same explicit economic policy
→ same result
```

without subjective balancing preferences.

Reject hidden parameters such as:

```text
TIME_WEIGHT = 0.4
MATERIAL_WEIGHT = 0.3
RARITY_WEIGHT = 0.3
```

unless the governing specification explicitly defines them as policy.

Even then, identify them as policy rather than objective economic truth.

---

## 19. Cross-mechanic review

A proposed common economic basis should be evaluated across:

```text
direct/manual acquisition
recipe
deterministic loot
probabilistic loot
worldgen
crop
villager trade
processing
required equipment
recursive intermediate resources
```

For every mechanic ask:

```text
What evidence exists?
Which DynamicFood channel owns it?
What is NOT_APPLICABLE?
What remains UNKNOWN?
Does the same basis remain meaningful?
```

Do not force every mechanic to expose every measurement.

Cross-mechanic comparability means a common semantic basis exists where the channels are applicable, not that every mechanism has identical measurements.

---

## 20. Provider boundary review

Providers should provide mechanical information, not economic policy.

Reject provider changes that make providers:

- calculate EconomicCost;
- calculate AcquisitionCost;
- normalize economic factors;
- choose the cheapest path;
- apply calibration;
- use FoodIndex;
- create hidden terminal prices.

Providers may contribute mechanical facts and requirements through the effective mechanic model.

Economic aggregation belongs in the appropriate central layer.

---

## 21. Minimal-change review

Even a semantically correct fix can be wrong for repository workflow if it is unnecessarily broad.

Check:

```text
Does the change solve the stated defect?
Does it alter unrelated semantics?
Does it rewrite existing architecture?
Does it add an adapter that hides a missing contract?
Does it change public behavior without documentation?
Does it modify unrelated phases?
```

Prefer the smallest implementation that satisfies the already-defined contract.

If the contract itself is missing, stop at the specification boundary rather than encoding a policy choice as code.

---

## 22. Required review report

Use this structure:

```text
## Review Scope

## Governing Authority

## Proposed Semantic Change

## Layer / Ownership

## Economic Primitive Test

## Terminal Test

## Recursion / Cycle Test

## Probability / Quantity Test

## Equipment Test

## Horizon Test

## Path Selection Test

## Baseline Test

## Calibration Boundary Test

## UNKNOWN Handling

## Objectivity Test

## Cross-Mechanic Test

## Findings

### BLOCKER
...

### MAJOR
...

### MINOR
...

### ACCEPTABLE
...

## Verdict
```

Use one of:

```text
APPROVE
REQUEST CHANGES
BLOCKED BY POLICY DECISION
UNKNOWN — NO DEFENSIBLE COMMON PRIMITIVE
```

Do not use `APPROVE` merely because the code compiles or tests pass.

---

## 23. Review severity guidance

### BLOCKER

Semantic violation that makes the economic result invalid.

Examples:

- fabricated terminal prices;
- double-counted probability;
- EconomicCost derived from FoodIndex;
- UNKNOWN converted to zero;
- hidden exchange rates;
- recursive self-pricing without independent basis;
- path aggregation silently chosen when unspecified.

### MAJOR

Correctness risk that may invalidate a class of resources or mechanics.

Examples:

- missing canonical starting-state enforcement;
- incorrect equipment lifecycle;
- horizon applied after normalization;
- incorrect path-selection quality;
- incompatible probability opportunity units.

### MINOR

Local issue that does not invalidate the canonical semantic result but should be corrected.

### ACCEPTABLE

Intentional behavior explicitly supported by current governing documents.

---

## 24. Hard stops

Do not approve a change that succeeds only by making more resources resolve.

Do not approve:

- arbitrary terminal constants;
- arbitrary scalar weights;
- hidden exchange rates;
- AcquisitionCost disguised as EconomicCost;
- Difficulty disguised as EconomicCost;
- rarity disguised as EconomicCost;
- calibration-derived economics;
- FoodIndex-derived economics;
- probability double charging;
- horizon double charging;
- runtime inventory as hidden static input;
- a resolver adapter around incomplete diagnostics;
- silent specification changes.

When the needed semantic decision is not defined by the current contract, report the exact policy/document decision required and stop there.
