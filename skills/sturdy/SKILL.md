---
name: sturdy
description: >-
  Rules for writing code whose correctness, resource use, and failure
  behaviour are stated and checked: a contract and its critical invariants, a
  failure-containment policy, resource budgets with a source, external effects
  that are safe to retry, interfaces that tests can drive, deliberate
  dependencies, and performance work that follows a workload and a target. Use
  whenever you build a new feature, module, service, script, or library,
  change behaviour in a nontrivial way, or review such code, in any language,
  even when the request doesn't mention code quality. Use it by itself or
  alongside a workflow such as poteto-mode. Skip it for typo fixes, renames,
  config-only edits, and docs.
---

# Sturdy code

These rules are for code whose correctness, resource use, and failure
behaviour are stated and checked, not assumed.

Meet the correctness requirements and the resource requirements first. Among
the designs that meet them, choose the simplest. Code that a reader can follow
is part of safety, because a reader can check only what they can follow.

Be uncompromising about each requirement, and explicit about when a particular
mechanism is required. "Limit resource use" is a requirement. "Allocate
everything at startup" is one mechanism that meets it, and it is the wrong
mechanism for many programs.

## Work in this order

A problem costs least to fix in design, more in implementation, and most in
production. Think before you write code.

1. **Write a design note first.** Size the note to the change. A small feature
   needs a few lines. Put the note in your reply. When the module is new, also
   put it at the top of the module. The note answers these questions, in this
   order. Write "none" where the change has nothing to say.
   - **Contract.** What must the code do? Which harmful outcomes must it
     prevent?
   - **Invariants.** Which facts must hold for the contract to hold?
   - **Failure.** What can fail, inside the program and outside it? What does
     the program do then, and what state is safe afterwards?
   - **External effects.** What does the code change outside itself? What
     holds after a partial success, and why is each retry safe?
   - **Resources.** What can a caller or the environment scale? What is the
     limit on each dimension, where does the limit come from, and what is the
     aggregate cost?
   - **Performance.** What is the workload, what is the target, and which cost
     dominates?
   - **Structure.** What are the data structures and the interfaces?
   - **Mechanisms.** Does a stated requirement select the constrained-systems
     profile? Does the change add a dependency?
2. **Cover each invariant as you write.** Add the type, the validation, the
   assertion, or the test for an invariant when you write the code that
   depends on it. Don't add it afterwards.
3. **Revise.** The simple design comes from revision, not from the first
   attempt. When the code works, read it again and cut every part that it
   doesn't need.
4. **Verify and report.** Follow
   [Report what you verified](#report-what-you-verified).

**Don't knowingly leave a requirement unmet.** If the code can't meet an
agreed requirement inside the task, say so in your reply. Record each
improvement that you defer and each limitation that you find, in the place
where the repo tracks them. Deleting a TODO doesn't remove the limitation that
the TODO described.

**Stay inside the task.** Existing code may not follow these rules. Apply the
rules to the code that you write. Don't change code outside the task. Report
the violations that you see in that code.

**Say why.** When you depart from a rule in this skill, say so in the design
note and give the reason.

## Work alongside another workflow

A workflow such as poteto-mode may drive the task. The workflow then decides
the steps, who writes the code, and when to ask the user. This skill decides
what the code looks like.

- Write the design note during the workflow's design step.
- When you delegate the code to a subagent, give the subagent the path to this
  skill and the design note.
- If the workflow removes comments before review, as poteto-mode does, keep
  the design note out of the module. Put the design note in your reply and in
  the pull request description. Carry each reason in a name, a type, or an
  assertion before you carry it in a comment.

## State the contract and cover the invariants

The contract says what the code must do and which harmful outcomes it must
prevent. An invariant is a fact that must hold for the contract to hold. An
invariant is critical when a violation leads to one of those harmful outcomes.

- For each critical invariant, answer three questions. Where does the code
  establish it? What can invalidate it? How does the code detect a violation
  before the damage happens?
- Cover each invariant with the cheapest means that works. A type can make the
  bad state impossible to represent. Validation can reject the bad state at
  the boundary. An assertion can detect it inside. A test can show that the
  code preserves the invariant. Don't assert what the type system already
  proves.
- Treat the two kinds of error in opposite ways.
  - **Operating errors are expected.** Examples are bad input, a failed write,
    a timeout, and a full queue. Validate every external value at the boundary
    where it enters the program, and return an operating error when the value
    is invalid. Never assert on external input.
  - **Programmer errors are never expected.** A violated internal invariant
    means that the code is wrong. Inside the boundary, don't validate the data
    again. Assert the invariant, and follow the containment policy when the
    assertion fails.
- Put an assertion where the invariant could have been broken. Those places
  are after a transition that changes the state, where data passes between
  components, and before an effect that can't be undone.
- Check an invariant at distinct transitions. For example, check that a record
  is valid before the code writes the record, and again after the code reads
  the record back. A second copy of the same predicate, at a point where
  nothing could have changed, adds little.
- Assert what must not happen as well as what must happen. Bugs appear at the
  point where valid data becomes invalid.
- Put one condition in each assertion, so that a failure names the fact that
  broke. Write `assert(a); assert(b);`, not `assert(a && b)`. A chained
  comparison such as `0 <= index < count` counts as two conditions.
- Assert the relationships between constants. Do so at compile time if the
  language allows it, and at startup if not.
- When a fact is both critical and surprising, assert the fact instead of
  writing a comment.
- Don't count assertions. The measure is that every critical invariant is
  covered, not that the code has many checks.
- Separate essential guards from diagnostic checks. A guard that prevents
  damage runs in production. An expensive diagnostic check can run only in
  tests, or behind a build flag. Decide which kind each check is, and confirm
  that the production build keeps the guards.
- Test with valid data, with invalid data, and with valid data that becomes
  invalid.

## Contain failures

A violated invariant proves that an assumption is false. It doesn't show how
much state is wrong. Decide the response in the design, not in the handler.

- List what can fail outside the program, such as the disk, the network, the
  clock, a peer, or the input. Decide what the program does for each one.
  These failures are operating errors, and the program handles them without
  stopping.
- When an invariant fails, stop the work that depends on it. Never continue
  that work in the same state.
- Resume only across an isolation boundary whose state is still trustworthy.
  - If state that the whole process shares may be corrupt, terminate the
    process.
  - If the failed work ran in an isolated unit that can be discarded safely,
    discard the unit and let its supervisor restart it. A request that owns
    every piece of state that it changed, a worker process, and a task with
    its own data are examples.
- To choose between those two, answer four questions in the design note. Which
  state did the failed work own? Which writes can it leave half done? How does
  the program roll back or repair those writes? What does a restarted unit
  see?
- For each harmful outcome in the contract, check that the state after a
  failure can't produce it.
- Don't let a framework decide by accident. Many frameworks catch a failure
  and carry on. Find out what yours does, and make the policy explicit.
  [Language notes](#language-notes) lists common cases.
- Make the mechanism match the policy. A panic or an exception terminates the
  process only when nothing recovers it. If the policy is to terminate the
  process, use a call that no caller can intercept, such as an exit.
- Don't reach for a helper that logs and exits as the default. Exit is the
  right policy for a process whose shared state can't be trusted. The helper
  doesn't answer the four questions.

## Make external effects safe to retry

- Treat a timeout as an unknown outcome. The operation may have happened.
- Retry an operation that has an external effect only when a repeat is
  harmless. Make the operation idempotent with an idempotency key, a
  deduplication check, or a conditional write. Otherwise, find out the outcome
  before you retry. An attempt limit doesn't make a retry safe.
- For an effect with several steps, decide what holds after each partial
  success. Say what is committed, what is undone, what is retried, and how a
  restart finds where the work stopped.
- Limit the attempts, back off between them, and add jitter so that clients
  don't retry in step.

## Budget resources

- Limit every dimension that a caller or the environment can scale. The usual
  dimensions are bytes, item counts, concurrency, fan-out, expansion during
  decoding, and retained results.
- Derive the aggregate cost from the limits. Limits that look safe one at a
  time can multiply. A 1 MiB request limit with 1,000 concurrent requests
  allows about 1 GiB of raw input, before decoding, copies, and working state.
- Enforce each limit at admission, before the expensive allocation or work.
- Give each limit a source: a protocol constraint, a product requirement, a
  deployment budget, or a measured capacity. Hold the limit in a named
  constant with its unit. If a limit has no source, report it as an
  assumption. Don't invent a number because it looks reassuring.
- Decide what happens at each limit.
  - If load can reach the limit, then reaching the limit is an operating
    error. Reject the work or apply backpressure.
  - If only a bug can reach the limit, assert that the code never reaches it.
- Decide how much work the program accepts at once, and what it does with the
  excess. It can reject the excess, queue it within a limit, or push back on
  the sender.
- Give every loop a reason to end. A loop over a collection that is already
  limited needs no extra constant. Any other loop needs a limit or a timeout.
  A loop that runs for the life of the process needs a stop condition.
- Give recursion a depth limit that follows from a limited input. If you can't
  show one, iterate over an explicit stack that has a limit.
- Put a timeout on every wait for something outside the program.
- Know which memory goal applies, because the three goals differ. They are
  bounded retained memory, predictable allocation latency, and no allocation
  on a particular path. A streaming design meets the first goal for an input
  of any size.
- Know the range of every number, and choose a representation that holds the
  range. Use an explicitly sized integer where the width matters. The width
  matters in stored or transmitted data, in arithmetic that can overflow, and
  in a size that must match across platforms. Say how each division rounds.

## Keep control flow and state simple

- Use only simple, explicit control flow. Add an abstraction only when the
  abstraction models the domain better than plain code does.
- Handle every meaningful state. Where the language can check that the
  handling is exhaustive, as with a `switch` over an enum, let it. A guard
  clause and an intentional no-op are fine. Extra nesting doesn't prove that
  the handling is complete.
- When you split a function, keep the branching in the parent function and
  move the straight-line work into helper functions. Each helper function
  computes a result and has no side effects.
- State invariants positively. Write `if (index < count)`, and handle the
  failing case in the `else`, in place of `if (!(index >= count))`.
- Handle every error. Don't ignore a return value, and don't leave a `catch`
  block empty.
- Know which assumptions survive a suspension. After an `await` or a yield,
  other code may have run. Re-establish each assumption that the other code
  could have broken. Ownership, an immutable snapshot, a version check, a
  transaction, and a lock are the means.
- Keep one mutable source of truth for each fact. Two copies that can change
  independently will disagree. An immutable copy is safe, and is often what
  keeps a computation correct.
- Declare each variable in the smallest scope, next to the code that uses the
  variable. Check a value at the point of use, not earlier.
- Pass options to library calls explicitly. A default can change in a later
  version of the library.
- Use a strict, coherent compiler and linter configuration that suits the
  language and the repo. Don't enable every rule. Some rules conflict, and
  some only express a style.

## Design interfaces that tests can drive

- Expose as few functions and parameters as the callers need.
- Choose a return type that expresses the outcomes that callers must tell
  apart. An explicit result type lets the compiler check that a caller handles
  each outcome. A bare integer or boolean can hide several states behind one
  value.
- Inject access to external resources, so that a test can supply a
  deterministic implementation and inject faults. The clock, the network, the
  disk, and randomness are such resources. Cover every use of the clock,
  including sleeps and timeouts.
- Don't expect injection to do more than that. It doesn't make production
  behaviour deterministic, and it doesn't make concurrent execution
  reproducible.
- Make decisions in the caller, and transform data in the callee.
- When a caller could swap two arguments, such as two integers of the same
  type, take named arguments or an options struct.

## Choose dependencies deliberately

Writing the code yourself avoids the risk of a dependency and takes on the
risk of your own implementation. Compare both.

- Before you add a library or write your own version, compare the full cost
  of each option: correctness, maintenance, security, compatibility,
  performance, and distribution.
- Write the code yourself when the operation is small, stable, and well
  understood.
- Use an established implementation for cryptography, authentication, complex
  formats, and protocol handling. A local version of these is the riskier
  choice, even though it adds no package.
- Don't treat an installed dependency as a vetted one. A dependency that is
  already installed is convenient. That doesn't make it suitable or
  trustworthy.
- Report every dependency that you add, with the comparison that chose it.

## Make performance follow a workload and a target

Follow these steps in order.

1. Define the workload and the target. The workload is the request rate, the
   sizes, and the mix. The target is a latency, a throughput, a memory budget,
   or a cost.
2. Estimate the dominant costs with rough arithmetic across network, storage,
   memory, and compute. Put the numbers in the design note. For example, write
   "50,000 keys × 48 bytes = 2.4 MB of memory" or "200 events/s × 64 KB = 12.8
   MB/s of network".
3. Choose the algorithm and the representation that the estimate favours.
4. Measure the assumptions that the design depends on. Report an estimate that
   you didn't measure as an assumption.

These rules apply along the way.

- Treat "network is slowest, then storage, then memory, then compute" as a
  starting hypothesis. The workload decides, because a fast resource that the
  code uses very often can cost more than a slow one.
- Batch only with two limits. A batch trades latency for throughput, so give
  it a maximum size and a maximum wait, and choose both against the targets.
- Size each buffer against the latency target and the memory budget. A larger
  buffer absorbs a burst. It also allows a longer queue and retains more
  memory.
- Know where the hot path copies or re-encodes data, and decide whether each
  copy earns its cost. A copy can give a stable snapshot. Serialisation can
  give a portable, versioned boundary. Remove one only when a measurement says
  that it matters.
- When a check or a decision costs too much per item, do it once per batch.
  Keep the loop over the items plain.

## Select the constrained-systems profile only on a stated requirement

Some programs have requirements that the rules above don't meet. Examples are
a fixed memory budget, a path that must not allocate, a bounded stack, and a
bound on work per unit of time. The
[constrained-systems profile](profiles/constrained-systems.md) holds the
mechanisms for those requirements: allocation at startup, no recursion, a
fixed tick, and memory layout for a hot path.

- Select the profile only when the task, the repo, or the deployment states
  such a requirement. Don't select it because the code is important.
- Name the requirement in the design note, and apply only the mechanisms that
  the requirement calls for. Each mechanism has a cost, and the profile states
  it.
- When the profile applies, read the profile file before you design.

## House conventions

These conventions make code uniform for the people who read it. They are a
house style, not evidence that the code is safe. Each one has a cost. Where
the repo has its own convention, the repo's convention wins.

- Keep a function to 70 lines or fewer. The limit can force a split that
  spreads one idea across helpers. If a split would make the function harder
  to follow, keep the function whole and say why.
- Run the formatter. Keep every line within 100 columns. Put braces on every
  `if` that doesn't fit on one line.
- In a script, use long flags such as `--force`, not short flags such as `-f`.
  Write a script that has logic worth testing in the project's main language,
  not in shell.

Prefer single-value conditional checks and gates, rather than large
conjunctions or nested conditionals. For instance, prefer this:

  function process_widget(user: User, settings: UserSettings) {
    if (!user.isActive()) return
    if (!settings.enabled.widgets) return
    if (!user.processing.features.has('widgets')) return
    // do work
  }

Over:

  function process_widget(user: User, settings: UserSettings) {
    if (user.isActive() && settings.enabled.widgets && user.processing.features.has('widgets')) {
      // do work
    }
  }


Follow these conventions for names. They make names longer, which costs line
width.

- Name each value with a noun that says what the value is. Name each function
  with a verb that says what the function does.
- Don't abbreviate. Write `source`, not `src`.
- Put units and qualifiers last, and put the most significant word first.
  Write `latency_ms_max`, not `max_latency_ms`. Related names such as
  `latency_ms_min` then sort together and line up.
- Give related names the same length where a natural pair exists, such as
  `source` and `target`.
- Prefix the name of a helper function or a callback with the name of its
  caller, as in `read_sector()` and `read_sector_callback()`. Put callbacks
  last in a parameter list.
- Prefer a noun to an adjective or a participle. Write `pipeline`, not
  `preparing`.
- Give each name one meaning. Don't reuse a term that the project already uses
  for something else.
- Put meaning in a name that the type doesn't already carry. `deadline` tells
  the reader more than `time` does.
- Treat an `index`, a `count`, and a `size` as different types, and say in the
  name which one a value is. An index starts at 0. A count is one more than
  the last index. A size is a count multiplied by a unit.

Follow these conventions for comments and layout.

- Avoid comments wherever possible. Code that describes itself well is always
  preferable to code that needs comments to communicate intent.
- Say why. In a comment, give the reason for a decision, because the code
  already says what it does. Give the reason in commit messages too, in the
  repo's commit format.
- Write comments as sentences, with a capital letter and a full stop.
- Open each test with a description of the test's goal and method.
- Order a file so that a reader can read it from the top down. Put `main` and
  the most important things first.

## Language notes

- **Some assertions are compiled out.** Python `assert` under `-O`, C `assert`
  under `NDEBUG`, Java `assert` unless it is enabled, and Rust `debug_assert!`
  are examples. Use them only for diagnostic checks. Write an essential guard
  as an explicit check that the production build keeps.
- **Some runtimes catch a failure and carry on.** Go's `net/http` recovers a
  panic in a handler and serves the next request. A Python `except Exception`
  catches `AssertionError`. An asyncio callback that raises is logged, and the
  loop continues. JavaScript `console.assert` only logs. Where one of these
  applies, make the containment policy explicit.
- **A browser doesn't stop on an uncaught exception.** The browser reports
  the exception, and later events still run. Give a failed component an
  explicit disabled, disposed, or recovery state.
- **Number types differ.** A Python `int` has no fixed width, so only the
  application's range limits it. A JavaScript `Number` is a double. For an
  integer in a `Number`, check `Number.isSafeInteger` as well as the
  application's range. Use `BigInt` for a larger integer, and convert between
  the two types explicitly.
- **Use the language's formatter and its usual case.** The examples in this
  skill use `snake_case`. TypeScript uses `camelCase` and Go uses `MixedCaps`.
  The conventions for word order, units, and abbreviations still apply, so
  `latency_ms_max` becomes `latencyMsMax`. Use `snake_case` only where neither
  the language nor the repo has a convention.

## Report what you verified

End your reply with the evidence behind each claim. Keep these four kinds
apart, and don't promote a claim from one kind to a stronger one.

- **Checked by a tool.** The formatter, the type checker, the configured
  linter, and the test suite belong here. Name each command. A tool can check
  the length of a line. A tool can't check that no assertion depends on
  external input.
- **Exercised.** List the behaviour that you ran, such as load at a limit,
  cancellation, a timeout, a partial failure, and recovery after a restart.
  Name the test or the run.
- **Argued.** List the claims that rest on reasoning, such as ownership, an
  aggregate limit, and the containment policy. Give each argument in a
  sentence or two, so that a reviewer can check it.
- **Assumed.** List everything else. A limit without a source, an estimate
  that you didn't measure, and a failure path that you didn't exercise are
  assumptions.

## Review code against these rules

When you review code against these rules, report the findings in this order:
contract and failure behaviour, resource use, performance, and conventions.
For each finding, cite the line, name the rule, and give the fix. Say whether
you ran the code or only read it.
