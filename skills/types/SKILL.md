---
name: types
description: Avoid unnecessary optionality, and type entity ids. Use when writing or reviewing types.
---

# Types

Avoid unnecessary optionality, for example a Kotlin function argument typed `X?`, or a TypeScript one typed `X | null` or `X | undefined`.

Ideally the caller handles the null, or the type is stricter.

## Verify every optional

Check every optional the change adds, whatever its type: each `?` in Kotlin, and each `?:`, `| null` or `| undefined` in TypeScript, on arguments, fields, properties and mirrors alike. For each one, establish what null means and whether anything produces it: who sets it (every caller, the JSON the server sends, the stored data, counted in prod when it's persisted) and who reads it. Then ask whether a value of the type already means the same as missing: if readers treat missing like that value, the type holds one state two ways and the `?` is unnecessary. Example: an optional boolean prop that's missing means `false` (`canSwitchUnit?`).

A front-end form field the user hasn't filled in or chosen yet may be optional: missing means "not answered yet". That covers a row react-hook-form only creates as the user types (`amount?`, `unit?` and `applied?` on a student's concession row). A field the form always starts with a value for, such as a question that defaults to No or a list that starts empty, is not one of these.

Before raising one, check it can be made mandatory: find where the value would come from at every point the thing is created, such as each caller of a prop. If there's no such point, don't raise it.

The reviewer does this work, not the author. Raise only an optional you've shown is unnecessary, with the evidence that shows it; never ask the author whether one is needed, which hands them the work. List the ones you keep in what was looked at but not raised, each with what its null means and why no value of the type could say it.

For each optional argument, ask whether more than one caller would write the same null branch. If not, make it non-null and let the caller handle it. If yes, keep the `?` and the null branch inside.

Example: `DrawdownRequest.tuitionYear(billingPeriod: BillingPeriod?)`.

## Collections, booleans and strings

A collection, boolean or string, whether an argument, a field or a property, is non-null: a collection defaults to empty, a boolean to false and a string to `""`. Keep it nullable only when null means something that empty, false or `""` can't, and say what in its doc. If nothing ever stores an empty collection where it's set, empty can stand for "not set".

A nullable string ends up holding "none" two ways: admin's text field stores `""` when a field is cleared, so readers have to check for both null and blank. `Bursary.description: String? = null` is better as `description: String = ""`.

A TypeScript mirror states what the client receives. Admin's entity GET loads the entity and serializes it (`EntityHandler.get`): null fields are left out, and every non-null field is sent, an empty collection as `[]`, including on entities saved before the field existed. So a nullable server field mirrors as `?`, and a non-null one, `bursaries: List<Bursary> = emptyList()` included, mirrors as required: `bursaries: Bursary[]`.

Settle what the client gets from the client's own request (on beta, the response to the page's own call), not from `get_entity`: it's a filtered view that leaves out `schoolGroupIds`, which admin receives as `[]`.

## One shape, one kind

Make illegal states unrepresentable (Yaron Minsky's phrase): a type that can hold a state the domain never has, such as a picked bursary with no name, lets code that would break on it compile. Watch for a field made optional so a different kind of entry can share a list. TypeScript compares types by their structure, so once `name` is optional, a nameless free-entry bursary fits among the school bursaries a family picks. After that the type can't promise a picked bursary has a name, and code that relies on it compiles without one. Ask why the field is optional: if the answer is "so the other kind fits", give the other kind its own field. The cost is usually one extra line where both are handled.

## Typed ids

An entity's id is `Id<T>`, never a bare `UUID`, in parameters, returns, fields and collections alike. `Id<FileInfo>` says what it identifies, and the compiler refuses an account's id where a file's belongs; a `UUID` does neither. Unwrap with `.id` only at the call into an API that takes a `UUID`, such as `repo.addRelation`, and wrap a ref's `toId` with `.toId()`.

Example: `CustomerInvoice.fileIds(repo): List<UUID>` beside `ManualInvoiceCreator.create(fileIds: List<Id<FileInfo>>)`, one concept typed two ways.

## Precedent

Judge each type by what it holds, never by its neighbours. Optional fields around it are no reason to keep one optional, and no reason to make one required either; check it against its source. Don't cite a neighbour as the reason a type is fine.
