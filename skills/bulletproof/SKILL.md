---
name: bulletproof
description: Make every assumption bulletproof before building on it. Use when starting a ticket, designing a change, or claiming how the system behaves.
---

# bulletproof

Every assumption I build on is proven, not guessed.

- Read the unit and integration tests in the domain before reading the code. They show what behaviour is intended and which edge cases someone already cared about.
- Verify every assumption about data against prod with the `edstart` MCP: how many records, which states they are in, whether the case actually happens. Say the population and the count.
- Name a case by what the data shows it is ("the term's drawdown was skipped"), not by what it might mean ("funding stopped").
- A ticket's requirements are proposals, often written before anyone weighed their technical cost. Most add something the user needs, so build them. When one comes at a high technical cost, say what it costs and what it gives the user, and take it back to the stakeholders to discuss rather than building it at any price or quietly leaving it out. When the change conflicts with a stated requirement, say so plainly, and why.
- Verify every assumption about a third-party API against its official docs, not our client code or memory: limits, units, windows, error responses, what a field holds. Cite the page, and say where the docs are silent.
- Trace the real flow end to end, every caller and every path that reaches it. Never assume from one file or one name.
- Say which assumptions are proven and how. List the rest as "assumptions still open", never a bare "still open", which reads like open tickets or conversations.
