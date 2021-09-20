# Documenting code

Before submitting a change, you are required to document all code (including private, unreleased code). Write examples if possible.

First, build the docs with private objects hidden:

> $ rake docs_priv

then list all undocumented objects:

> $ rake list_undoc

If `100.00% documented` is displayed, proceed to the next step. Else, all undocumented objects will be displayed so you can document them.

Next, build the docs with private objects hidden:

> $ rake docs

and run the local documentation server:

> $rake doc_server

It will host the docs on http://localhost:8808. Open it in your browser, and thoroughly review all documentation you've written.

Once reviewed, this step is complete!
