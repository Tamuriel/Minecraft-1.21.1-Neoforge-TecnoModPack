---

name: dynamicfood-provider-architecture
description: Design, implement, review, or debug DynamicFood mechanical providers and the Effective Mechanic Model. Use when working with provider contributions, ADD/REPLACE/REMOVE/MODIFY semantics, precedence, conflicts, AcquisitionContext, AcquisitionRequirements, CapabilitySatisfaction, mechanic adapters, path discovery, or provider-driven invalidation.
---

# DynamicFood Provider Architecture

## Purpose

Providers are the mechanical boundary between Minecraft/mod APIs and DynamicFood's acquisition model.

A provider describes mechanics. It does not decide economics.

The governing documents remain authoritative. Read at minimum:

1. `01_Master_Spec.md`
2. `05_State.md`
3. `06_PHASE_01_ECONOMIC_MODEL.md`
4. `07_PHASE_02_ACQUISITION.md`
5. `12_AI_WORK_PROTOCOL.md`

Inspect the actual repository before editing code. Preserve current public contracts unless the governing specification requires a semantic change.

---

# 1. Provider responsibility boundary

A provider may contribute mechanical facts such as:

* `AcquisitionContext`;
* `AcquisitionRequirements`;
* `RequirementExpression`;
* `Capability`;
* `CapabilitySatisfaction`;
* access/transition edges;
* acquisition candidates;
* raw mechanical measurements;
* probability/distribution evidence;
* evidence/provenance.

A provider must NOT directly calculate or assign:

* `EconomicCost`;
* `AcquisitionCost`;
* factor-normalizer weights;
* final normalized economic factors;
* calibration results;
* FoodIndex;
* population-derived terminal values.

If a provider appears to need an economic number to describe a mechanic, first determine whether that number is actually mechanical evidence. Do not move policy into the provider layer merely because it is convenient.

---

# 2. Layer separation

Keep these layers distinct:

```text
Provider Contributions
    -> Effective Mechanic Model
    -> Acquisition Discovery
    -> AcquisitionPath
    -> Context / Requirements / Capability Satisfaction
    -> AcquisitionMeasurements
    -> economic model
```

Definitions:

### AcquisitionContext

Mechanical circumstances in which an operation exists.

Context is not an economic factor.

### AcquisitionRequirements

Objectively established constraints that a candidate path must satisfy.

A requirement does not become a cost simply because it exists.

### RequirementExpression

Use:

```text
ATOM(X)
ALL(A, B, C)
ANY(A, B, C)
```

`ANY` creates alternative path choices. `ALL` requires all satisfiers.

### Capability / CapabilitySatisfaction

A capability describes what a mechanism can satisfy. A satisfaction records how the concrete path meets the requirement.

For example:

```text
requirement: pressure_resistance >= 2
satisfier A: diving_suit
satisfier B: submarine
```

Do not create an artificial path containing both alternatives merely because both are present in the registry.

---

# 3. Contribution model

Supported contribution operations are:

```text
ADD
REPLACE
REMOVE
MODIFY
```

Providers contribute to a central registry.

Providers must not directly mutate another provider's internal state or output.

The registry resolves contributions into the `EffectiveMechanicModel` before acquisition analysis.

Acquisition analyzers consume the effective model, not the raw union of provider declarations.

---

# 4. Deterministic resolution

For identical authoritative inputs, effective provider resolution must be identical.

Registration or load order alone must not change the result.

Deterministic resolution may use explicit precedence rules, but those rules must be part of the model rather than an incidental collection iteration order.

If contributions cannot be reconciled under declared rules:

```text
CONFLICT
```

is the correct result.

Do not resolve conflicts by:

* last writer wins merely because of registration order;
* hash-map iteration order;
* arbitrary provider priority invented in code;
* silent dropping of one provider;
* guessing which mechanic “looks right”.

---

# 5. ADD

Use `ADD` when a provider contributes a previously absent mechanic/candidate/evidence element and does not supersede an existing definition.

Before adding, determine the identity key used to decide whether the contribution is actually new.

Do not use a descriptive string or class name as a substitute for a stable semantic identity if the repository already has a canonical identifier.

---

# 6. REPLACE

Use `REPLACE` only when the contribution explicitly supersedes an existing definition under the declared precedence/identity rules.

A replacement must be deterministic and auditable.

Do not use `REPLACE` to hide an unresolved conflict.

Do not replace an entire mechanic when only one field requires modification; prefer `MODIFY` when the contract defines field-level modification semantics.

---

# 7. MODIFY

Use `MODIFY` for explicit changes to an existing mechanic contribution.

A modification must identify:

* target contribution identity;
* field/semantic property being modified;
* new value or operation;
* precedence/conflict behavior;
* provenance where required.

Do not infer a modification from structurally similar but differently identified contributions.

---

# 8. REMOVE

Use `REMOVE` only when the removal is explicitly contributed and its target identity is unambiguous.

Removing a mechanic must not be confused with declaring it unsupported.

If the effective model cannot establish whether a mechanic exists because provider evidence conflicts, use `CONFLICT` rather than silently removing it.

---

# 9. Effective Mechanic Model invariant

The registry output is the authoritative mechanical model for Phase 02 analysis.

Conceptually:

```text
raw provider declarations
        |
        v
validation
        |
        v
contribution resolution
        |
        v
EffectiveMechanicModel
```

The effective model must contain enough information for deterministic acquisition discovery without consulting arbitrary provider internals at analysis time.

Do not let analyzers reconstruct provider precedence themselves.

Do not let individual analyzers interpret raw provider conflicts independently.

---

# 10. Provider failures

A malformed or unsupported contribution should be localized where possible.

Use an explicit failure state such as:

```text
UNKNOWN
CONFLICT
rejected contribution
```

according to the governing API.

Never turn provider failure into:

* zero cost;
* zero quantity;
* false feasibility;
* fabricated equipment;
* fabricated material;
* arbitrary path eligibility.

If provider implementation is unsupported, report the limitation and preserve the unresolved state.

---

# 11. Mechanical evidence vs economics

The provider layer may expose evidence such as:

* biome;
* dimension;
* feature placement;
* loot structure;
* recipe inputs;
* profession;
* station;
* placement count;
* cluster size;
* item durability;
* process ticks;
* output distributions.

These are not automatically economic factors.

For example:

```text
biome = Plains
```

is context/evidence, not an economic burden.

```text
loot weight = 5
```

is stochastic selection evidence, not automatically `ProbabilityBurden`.

```text
item max durability = 2031
```

is equipment lifecycle evidence, not itself an economic cost.

The semantic mapping stage determines what DynamicFood measurement, if any, the evidence supports.

---

# 12. Provider access to Minecraft APIs

Providers may inspect authoritative game/mod configuration and APIs to extract mechanical evidence.

Prefer static, deterministic sources where available:

* recipes;
* loot tables;
* worldgen definitions;
* item/block properties;
* crop/growth mechanics;
* trade definitions;
* supported mod registries/configuration.

Do not simulate a player to manufacture missing mechanical facts unless the specification explicitly defines a simulation-based protocol.

When the API does not expose enough evidence to establish a required measurement:

```text
UNKNOWN
```

is preferable to a guessed proxy.

---

# 13. Provider -> path boundary

A provider may expose multiple mechanically plausible acquisition candidates.

Do not prematurely merge them into one path.

Candidate construction should preserve distinctions that can affect:

* requirements;
* capability satisfiers;
* access;
* material consumption;
* equipment lifecycle;
* cycle/renewal semantics;
* stochastic distributions;
* source identity.

Later canonicalization/deduplication decides which candidates are semantically identical.

---

# 14. Survival evidence

Provider discovery does not prove survival acquisition.

Do not infer:

```text
registered mechanic -> survival = true
loot table exists -> player can safely acquire it
item exists -> survival obtainable
```

Survival eligibility must be evidence-backed and may be:

```text
TRUE
FALSE
UNKNOWN
```

A provider can supply evidence for this determination but should not silently mark unsupported mechanics as survival-valid.

---

# 15. Probability evidence

When a provider exposes stochastic mechanics, preserve typed probability evidence rather than collapsing it immediately into one generic number.

Use the semantic roles defined by the economic model:

```text
AvailabilityProbability
ProgressProbability
SelectionProbability
RenewalProbability
```

Provider responsibility is to expose the mechanical stochastic relationship, including where possible:

* raw probability/distribution;
* opportunity/attempt unit;
* conditioning/dependency;
* roll multiplicity;
* distribution semantics;
* evidence/provenance;
* estimate kind.

The provider does not decide the final economic charge ownership beyond preserving the mechanical role accurately.

---

# 16. Generation and invalidation

Provider implementation identity/version is part of the economic-generation input boundary when provider behavior can alter acquisition evidence.

Changes to relevant provider behavior can require a new economic generation.

Ordinary gameplay cannot be a provider-model invalidation event.

Do not rebuild static economics because:

* a crop grew;
* one loot roll happened;
* one villager restocked;
* one block was mined;
* one recipe was executed.

---

# 17. Testing requirements

Every provider/effective-model change should be tested at the semantic boundary where possible.

At minimum cover:

* `ADD`;
* `REMOVE`;
* `REPLACE`;
* `MODIFY`;
* deterministic precedence;
* unresolved conflict;
* registration-order invariance;
* stable contribution identity;
* provider/version signature when generation identity requires it;
* unsupported provider behavior;
* path discovery from effective model;
* no direct EconomicCost assignment.

A good invariance test is:

```text
same contributions + different registration order
    -> same EffectiveMechanicModel
```

A good conflict test is:

```text
irreconcilable contributions
    -> CONFLICT
    -> no fabricated path/economics
```

---

# 18. Review checklist

Before accepting a provider change, verify:

* Is it describing mechanics rather than economics?
* Does it feed the effective model rather than bypass it?
* Are contribution operations explicit?
* Is resolution deterministic?
* Are conflicts explicit?
* Are `ANY` alternatives preserved as alternatives?
* Are requirements distinct from economic factors?
* Is capability satisfaction distinct from equipment economic burden?
* Is raw evidence typed and attributable?
* Are unsupported APIs preserved as UNKNOWN?
* Does provider version participate in generation identity when economically relevant?
* Does the change avoid simulation and hidden runtime state?

If any answer is no, stop before adding compensating logic elsewhere.

---

# 19. Hard prohibitions

Never:

* set `EconomicCost` in a provider;
* set `AcquisitionCost` in a provider;
* hide normalization inside provider code;
* apply calibration inside provider code;
* use FoodIndex as provider evidence;
* mutate another provider;
* rely on registration order;
* silently choose a conflicting contribution;
* turn provider failure into zero;
* infer survival from registry presence;
* simulate gameplay to invent missing economics;
* let analyzers reconstruct raw provider precedence;
* collapse alternative satisfiers into one artificial path;
* make runtime events invalidate the provider/economic model.

