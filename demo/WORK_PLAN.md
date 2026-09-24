# Guestboard duplicate repair

## Goal

Importing `Ada`, ` ada `, and `Lin` must produce two guest cards and a count of two.
Casing and surrounding spaces do not create a new guest. Blank lines remain ignored,
and distinct guests remain in first-seen order.

## Delivery plan

1. Confirm the prepared user-visible contract and delegate the bounded repair.
2. Correct normalization in the shared core used by the browser and tests.
3. Review one exact committed revision, its fast-unit evidence, and the presenter's
   manual browser observation.
4. Run the same fast regression for that revision in the prepared Docker sandbox.
5. Summarize the evidence and any remaining limitation.

```arch
{
  "v": 1,
  "kind": "layered",
  "title": "Guestboard repair flow",
  "layers": [
    {
      "id": "contract",
      "title": "Product contract",
      "detail": "What the audience should observe",
      "items": [
        { "id": "acceptance-contract", "label": "Acceptance criteria", "detail": "Product Manager · two cards, count two" }
      ]
    },
    {
      "id": "implementation",
      "title": "Implementation",
      "detail": "Smallest shared-core repair",
      "items": [
        { "id": "normalizer", "label": "Guest normalizer", "detail": "Claude Developer · terminal workspace" },
        { "id": "source-revision", "label": "Exact source revision", "detail": "Developer → independent reviewers" }
      ]
    },
    {
      "id": "verification",
      "title": "Independent verification",
      "detail": "Different owners, same revision",
      "items": [
        { "id": "core-regression", "label": "Core regression", "detail": "QA · separate workspace" },
        { "id": "browser-proof", "label": "Visible browser result", "detail": "QA + optional UI/UX observation" },
        { "id": "docker-proof", "label": "Docker sandbox check", "detail": "Adversarial Reviewer · isolated runtime" }
      ]
    },
    {
      "id": "outcome",
      "title": "Outcome",
      "detail": "Evidence-backed team result",
      "items": [
        { "id": "delivery-summary", "label": "Delivery summary", "detail": "Engineering Manager · revision and evidence" }
      ]
    }
  ],
  "flows": [
    { "from": "contract", "to": "implementation", "label": "agreed behavior" },
    { "from": "implementation", "to": "verification", "label": "exact revision" },
    { "from": "verification", "to": "outcome", "label": "review evidence" }
  ]
}
```

## Evidence rule

Every result shown in the room must identify whether it came from the Developer's fast
unit command, the presenter's manual browser observation, or the Docker verifier. The
plan is prepared; evidence is reported only after its bounded step occurs.
