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
  "title": "Guestboard software architecture",
  "layers": [
    {
      "id": "presentation",
      "title": "Browser UI",
      "detail": "Static client-side interface",
      "items": [
        { "id": "import-form", "label": "Import form", "detail": "Textarea and import action" },
        { "id": "guest-board", "label": "Guest board", "detail": "Cards, count, and status" }
      ]
    },
    {
      "id": "domain",
      "title": "Shared guest-list logic",
      "detail": "Used by the browser and Node tests",
      "items": [
        { "id": "input-parser", "label": "Input parser", "detail": "Line splitting and safety limits" },
        { "id": "guest-normalizer", "label": "Guest normalizer", "detail": "Trim, case, deduplication, order" }
      ]
    },
    {
      "id": "delivery",
      "title": "Static preview delivery",
      "detail": "Local demo server",
      "items": [
        { "id": "preview-server", "label": "Preview server", "detail": "Explicit static assets only" },
        { "id": "source-version", "label": "Source metadata", "detail": "Branch, commit, and dirty state" }
      ]
    }
  ],
  "flows": [
    { "from": "presentation", "to": "domain", "label": "raw guest lines" },
    { "from": "domain", "to": "presentation", "label": "normalized guests" },
    { "from": "delivery", "to": "presentation", "label": "assets + source revision" }
  ]
}
```

## Evidence rule

Every result shown in the room must identify whether it came from the Developer's fast
unit command, the presenter's manual browser observation, or the Docker verifier. The
plan is prepared; evidence is reported only after its bounded step occurs.
