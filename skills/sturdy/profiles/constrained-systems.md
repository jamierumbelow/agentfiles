# Constrained-systems profile

This profile holds mechanisms for requirements that the general rules in
[SKILL.md](../SKILL.md) don't meet. Apply a mechanism only when a stated
requirement calls for it. The table maps each requirement to its mechanism.

| Stated requirement | Mechanism |
| --- | --- |
| A fixed memory budget, or a bounded heap | [Allocate at startup](#allocate-at-startup) |
| No allocation on a named path, or predictable allocation latency | [Allocate at startup](#allocate-at-startup) |
| A bounded stack | [Don't recurse](#dont-recurse) |
| A bound on work per unit of time, or reproducible scheduling | [Run on a fixed tick](#run-on-a-fixed-tick) |
| A measured memory or cache bottleneck on a hot path | [Lay out memory for the hot path](#lay-out-memory-for-the-hot-path) |

Name the requirement and the mechanism in the design note. A requirement that
nobody stated doesn't select a mechanism, however important the code is.

## Allocate at startup

- Allocate at startup all the memory that the requirement covers, and size it
  from the resource budget. After startup, allocate nothing and free nothing
  in that scope. The scope is the whole program for a fixed memory budget, and
  the named path for a path that must not allocate.
- Work out the worst-case memory use as part of the design.
- In a language with a garbage collector, fix every capacity at startup,
  preallocate, and reuse buffers. The language can't forbid allocation, so
  prove the claim with a test that counts allocations on the path.
- When you reuse a buffer, zero the part that you don't overwrite, so that
  stale bytes can't leak.

The cost is memory that the program reserves for the worst case even when it
is idle. A change of capacity also needs a restart.

## Don't recurse

- Replace recursion with a loop over an explicit stack that has a limit.
- Derive the limit from the stack budget and the size of one frame.

The cost is that an explicit stack can be harder to read than the recursion
that it replaces.

## Run on a fixed tick

- Don't do work directly in reaction to an external event. Queue the event,
  and process the queue in batches on a fixed tick.
- Limit the batch size and the cost of each item. A tick limits the work per
  unit of time only when both are limited.
- Choose the interval against the latency target. A tick adds waiting. With
  evenly spread arrivals and no backlog, an interval of `T` adds `T / 2` on
  average before the work starts.
- Give the tick loop a stop condition. After the loop, assert that a stop
  request is the reason the loop exited.

The cost is the added latency, and a queue that needs its own limit.

## Lay out memory for the hot path

Apply these rules only to a path that a measurement shows is limited by memory
bandwidth or by the cache.

- Use fixed-size structs that the hot path reads in place, without a copy or a
  decode. Keep copies and serialisation at the edges, where a stable snapshot
  or a versioned boundary is worth the cost.
- Use an explicitly sized integer for every field in a fixed layout.
- Order the fields of a struct from largest to smallest, so that the layout
  needs no padding.
- Align a struct to the cache line only to fix false sharing or an access
  pattern that you have demonstrated. Alignment pads the struct, so fewer
  structs fit in the cache.
- Extract each hot loop into a standalone function that takes primitive
  arguments and doesn't take `self`. Don't rely on the compiler to hoist field
  reads for you.

The cost is code that is tied to one layout, which is harder to change and to
port.
