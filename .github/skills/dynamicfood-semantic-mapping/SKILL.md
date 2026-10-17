---
name: dynamicfood-semantic-mapping
description: Map Minecraft and mod mechanical properties to DynamicFood semantic evidence, measurements, requirements, probability profiles, lifecycle data, or structural signals without inventing economic meaning. Use when deciding what a Minecraft API value means in DynamicFood, adding adapters/providers, tracing raw fields, or reviewing mappings between game mechanics and DynamicFood concepts.
---

# DynamicFood Semantic Mapping

## Purpose

This skill defines the semantic boundary between Minecraft/mod mechanics and DynamicFood.

The central rule is:

```text
Minecraft field/value
    -> Minecraft mechanical meaning
    -> DynamicFood semantic type
    -> evidence/measurement role
    -> economic ownership, if any
```

Never map values by Java type, field name, magnitude, or convenience alone.

A numeric Minecraft property is not automatically an economic number.

The governing documents remain authoritative. Read at minimum:

1. `01_Master_Spec.md`
2. `06_PHASE_01_ECONOMIC_MODEL.md`
3. `07_PHASE_02_ACQUISITION.md`
4. `12_AI_WORK_PROTOCOL.md`

Use actual dependency source/mappings and repository usage for version-specific Minecraft 1.21.1 / NeoForge 21.1.249 semantics. Do not replace version-specific evidence with generic Minecraft assumptions.

---

# 1. Mapping procedure

For every proposed mapping, answer all of these:

1. **What does the Minecraft value mechanically mean?**
2. **What game event/process produces it?**
3. **What is its unit or reference domain?**
4. **What DynamicFood semantic type represents that meaning?**
5. **Is the result direct evidence, derived measurement, structural evidence, or diagnostic-only information?**
6. **Does it have an economic owner?**
7. **Can it be compared across acquisition mechanics?**
8. **Can it be composed without arbitrary exchange rates?**
9. **What makes it UNKNOWN or NOT_APPLICABLE?**
10. **Could the mapping double-count a burden already represented elsewhere?**

Do not approve a mapping until these questions have defensible answers.

---

# 2. Semantic type taxonomy

Classify source values using one of these roles before assigning a DynamicFood destination:

```text
DIRECT_MEASUREMENT
DERIVED_MEASUREMENT
PROBABILITY_EVIDENCE
QUANTITY_EVIDENCE
LIFECYCLE_EVIDENCE
STRUCTURAL_EVIDENCE
FEASIBILITY_EVIDENCE
CONTEXT_EVIDENCE
DIAGNOSTIC_ONLY
NO_CANONICAL_MAPPING
```

The classification is semantic, not based on the Java primitive type.

For example, a `double weight` may be probability evidence, while a different `double weight` may represent something unrelated.

---

# 3. Core DynamicFood semantic targets

Current core economic measurements are:

```text
quantity
probability_burden
material_consumption
equipment_economic_burden
```

`operation_duration` is a supported objective measurement but is not a universal core completeness gate.

Structural concepts such as these are not automatically scalar economic factors:

```text
progression
prerequisite
intermediate
transport/access
repeatability
renewability
startup/recurring
danger
```

Their concrete consequences may matter only when they are represented through an actual canonical economic channel and the active policy says how to use that channel.

---

# 4. Common mapping patterns

### Recipe ingredient count

```text
Minecraft meaning:
    amount of an input consumed by one recipe operation

DynamicFood:
    material_consumption evidence
```

The resulting child economic burden comes later through recursive resource economics.

Do not treat ingredient count itself as an already-valued economic scalar.

---

### Recipe output count

```text
Minecraft meaning:
    units produced per completed operation

DynamicFood:
    quantity
```

For stochastic outputs, use the actual distribution and expected quantity.

---

### Loot entry weight

```text
Minecraft meaning:
    relative selection weight inside a loot-selection mechanism

DynamicFood:
    SelectionProbability / quantity-distribution evidence
```

Do **not** map loot weight directly to `ProbabilityBurden`.

Selection probability owns expected quantity when it changes output amount through the selection distribution.

---

### Availability / occurrence probability

```text
Minecraft meaning:
    chance a source/opportunity becomes available within a declared search/provisioning unit

DynamicFood:
    AvailabilityProbability
    -> ProbabilityBurden
```

An explicit opportunity unit is required for comparability.

Worldgen rarity without a declared search/provisioning unit must not be turned into arbitrary search time or a universal rarity price.

---

### Progress probability

```text
Minecraft meaning:
    stochastic probability that one declared opportunity advances a process

DynamicFood:
    ProgressProbability
    -> ProbabilityBurden
```

The opportunity unit and process semantics must be explicit.

---

### Output-selection probability

```text
Minecraft meaning:
    conditional probability that a specific output branch/result is selected

DynamicFood:
    SelectionProbability
    -> ExpectedQuantity
```

Do not also charge the same probability as an independent `ProbabilityBurden`.

---

### Renewal / return probability

```text
Minecraft meaning:
    probability that a production cycle returns the renewable state/input needed for continuation

DynamicFood:
    RenewalProbability
    -> CycleProfile / material semantics
```

Do not automatically apply another logarithmic probability charge.

A seed-return probability, for example, may feed expected renewal/material requirements without creating a second independent charge for the same event.

---

### Intrinsic process duration

Examples include exposed processing time or fixed-context operation duration.

```text
Minecraft meaning:
    mechanically entailed duration of the declared operation

DynamicFood:
    operation_duration
```

Default scope excludes:

- search;
- travel;
- setup;
- generic player reaction/input time;
- generic combat time;

unless an explicit acquisition protocol defines them as measured operations.

A duration value is not automatically an economic time currency. Its eventual use is governed by the active economic policy.

---

### Equipment durability/max damage

```text
Minecraft meaning:
    mechanical lifecycle boundary for an equipment item

DynamicFood:
    equipment lifecycle evidence
    -> equipment_economic_burden
```

Do not treat `maxDamage` as economic cost.

Actual usage/depletion per acquisition operation must be established separately where required.

---

### Tool requirement / mining tier

```text
Minecraft meaning:
    condition for successful operation

DynamicFood:
    AcquisitionRequirements / CapabilitySatisfaction
```

The requirement itself is not a second economic factor.

The economic burden of required equipment belongs to `equipment_economic_burden` when the equipment has an objectively resolvable lifecycle.

---

### Biome / dimension / environment

```text
Minecraft meaning:
    mechanical context or access condition

DynamicFood:
    AcquisitionContext / structural evidence
```

Do not automatically map these to:

- rarity;
- danger;
- transport cost;
- time cost.

Those interpretations require explicit mechanical/economic semantics.

---

### Worldgen placement count / rarity modifier

```text
Minecraft meaning:
    generation/placement evidence

DynamicFood:
    availability/worldgen evidence
```

It does not automatically mean player search time, expected walking distance, or economic rarity.

If a declared search model exists, map the relevant occurrence probability to `AvailabilityProbability` with an explicit search unit.

---

### Mob health / attack damage

These describe combat mechanics.

They do not automatically map to:

```text
operation_duration
ProbabilityBurden
EconomicCost
```

Generic combat burden remains outside the core contract unless an explicit acquisition/combat protocol defines how it is measured and economically owned.

---

### Player movement speed / travel distance

These can be mechanically real but have no automatic DynamicFood economic mapping.

Default:

```text
NO_CANONICAL_MAPPING
```

unless an explicit acquisition protocol defines a transport/search operation and its economic meaning.

Do not convert meters, blocks, or movement speed into seconds and then into economic burden without a defined protocol.

---

### Runtime frequency of an event

```text
Minecraft meaning:
    one observed gameplay occurrence

DynamicFood:
    runtime observation / provenance
```

It is not automatically static acquisition probability or EconomicCost evidence.

Static probability must come from declared mechanics/distributions, not from one player's observed history, unless adaptive learning is explicitly part of the specification.

---

# 5. Probability mapping rules

The probability model is causal, not purely numerical.

Use:

```text
AvailabilityProbability -> ProbabilityBurden
ProgressProbability     -> ProbabilityBurden
SelectionProbability    -> ExpectedQuantity
RenewalProbability      -> CycleProfile / material semantics
```

A shared causal event may feed multiple dependent calculations when those calculations expose different state information, but it must not create more than one independent charge for the same burden.

For simple Bernoulli opportunity processes:

```text
E[opportunities] = 1/p
ProbabilityBurden = -ln(p)
```

This is not a universal probability transformation.

Do not:

- apply inverse probability to every chance value;
- apply `-ln(p)` to selection probability already represented in expected quantity;
- multiply probabilities merely because fields coexist;
- add unrelated probability values;
- ignore opportunity/attempt units.

When causal composition is not defensible, the correct output is `UNKNOWN`.

---

# 6. Quantity mapping rules

Quantity is the expected player-obtainable result per declared operation/cycle.

For a stochastic output:

```text
SelectionProbability
+ QuantityDistribution
+ RollMultiplicity
    -> ExpectedQuantity
```

Use analytical expectation when supported.

Do not separately charge the same selection probability as probability burden.

Do not confuse:

```text
items per operation
operations per time
items per time
```

without an explicit mechanical conversion.

---

# 7. Equipment mapping rules

There is one economic equipment channel:

```text
EquipmentEconomicBurden
```

Map source mechanics in stages:

```text
requirement
    -> capability satisfier
    -> equipment identity
    -> lifecycle usage/depletion
    -> restoration/replacement events
    -> child equipment EconomicCost
    -> equipment economic burden
```

Do not introduce a separate economic `EquipmentRequirement` factor.

Do not raw-normalize the child equipment EconomicCost again.

If equipment lifecycle data are incomplete, preserve `UNKNOWN`.

---

# 8. NOT_APPLICABLE vs UNKNOWN

This distinction is mandatory.

Use `NOT_APPLICABLE` when:

- the burden genuinely does not belong to the declared operation; or
- the burden is already represented by another canonical channel and charging it again would double count.

Use `UNKNOWN` when:

- the burden applies;
- the mechanic exposes insufficient evidence;
- a required conversion is missing;
- a stochastic composition is not defensible;
- the source API does not expose enough version-correct information.

Never use `NOT_APPLICABLE` simply because the implementation does not know how to calculate a value.

Never use `UNKNOWN` as an excuse to invent a proxy.

---

# 9. Mapping quality test

A proposed mapping is acceptable only when two independent implementations with the same authoritative mechanical evidence would derive the same semantic result without agreeing on subjective balancing preferences.

Reject mappings that require hidden:

- exchange rates;
- terminal prices;
- rarity constants;
- “effort points”;
- time-to-material coefficients;
- balancing weights presented as physical economics;
- calibration-derived economic values.

Configuration is acceptable only when the governing specification explicitly defines the configuration as semantic policy.

---

# 10. Evidence vs economic ownership

Every mapping should document both:

```text
source evidence
    -> DynamicFood semantic destination
    -> economic owner
```

Examples:

```text
loot weight
    -> SelectionProbability evidence
    -> Quantity / ExpectedQuantity

worldgen occurrence per chunk
    -> AvailabilityProbability
    -> ProbabilityBurden

tool durability usage
    -> lifecycle evidence
    -> EquipmentEconomicBurden

recipe ingredient count
    -> MaterialConsumption
    -> recursive child EconomicCost

biome id
    -> AcquisitionContext
    -> no direct economic charge
```

This ownership step prevents the same mechanical fact from entering multiple economic channels without justification.

---

# 11. Mapping from Minecraft API variables is not name-based

Never assume:

```text
double chance -> probability_burden
double weight -> cost
double duration -> economic time
int count -> quantity burden
boolean required -> economic penalty
```

The mapping must be based on the API's actual mechanic semantics.

The same Java type/name can represent different things in different subsystems.

Always inspect:

- actual 1.21.1 dependency source/mappings;
- call sites;
- surrounding API contract;
- actual mechanic execution semantics;
- governing DynamicFood specification.

---

# 12. When there is no mapping

Use:

```text
NO_CANONICAL_MAPPING
```

when a Minecraft property is real and relevant but the current DynamicFood contract provides no semantic destination.

Examples may include:

- player movement speed as a generic economic variable;
- mob HP as generic acquisition cost;
- biome rarity as terminal EconomicCost;
- creative-tab ordering;
- item rarity color;
- tooltip text;
- arbitrary developer metadata.

Do not force such evidence into the nearest-looking factor.

A missing semantic mapping is a specification boundary, not an implementation bug by default.

---

# 13. Unsupported source semantics

If a mechanic is too dynamic, conditional, version-specific, or unsupported to derive a defensible semantic value:

1. preserve the raw source/evidence where practical;
2. classify the unsupported aspect;
3. record the reason;
4. mark the semantic result `UNKNOWN` where the burden is applicable;
5. do not substitute a generic proxy.

For approximate methods, preserve:

- approximation method;
- parameters;
- assumptions;
- deterministic seed when sampling;
- bounds/error information where available;
- algorithm/schema version.

---

# 14. Mapping review checklist

Before accepting a Minecraft -> DynamicFood mapping, verify:

- Have I established the Minecraft mechanical meaning?
- Is the unit/reference domain explicit?
- Is the DynamicFood semantic destination named?
- Is it evidence, measurement, structural state, or diagnostic data?
- Does it have an economic owner?
- Is that owner distinct from other channels?
- Could it double count quantity/probability/equipment/material?
- Is the mapping deterministic?
- Is it version-correct for the target Minecraft/NeoForge environment?
- What makes it UNKNOWN?
- What makes it NOT_APPLICABLE?
- Would two independent implementations agree without subjective weighting?

If any answer is unresolved, do not silently code the mapping as an economic factor.

---

# 15. Hard prohibitions

Never map a Minecraft value directly to `EconomicCost` merely because it is numeric.

Never use:

- rarity as terminal EconomicCost;
- vanilla prices;
- Difficulty as EconomicCost;
- FoodIndex as EconomicCost;
- calibration outputs as terminal economics;
- item names/namespace as prices;
- runtime event counts as static probabilities;
- arbitrary time/material exchange rates;
- arbitrary danger/transport/effort coefficients;
- generic probability inversion;
- generic “one point per action” economics.

When the contract does not define a canonical mapping, preserve evidence and return `UNKNOWN` or `NO_CANONICAL_MAPPING` according to whether the target semantic is applicable.
