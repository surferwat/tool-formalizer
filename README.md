# tool-formalizer

A simple system for formalizing reusable mathematical techniques.

You're working through a textbook, you hit a technique worth keeping. Without a system, it gets lost. This gives it a permanent, searchable home.

## Installation

```
git clone https://github.com/surferwat/tool-formalizer.git
```

## Getting started

1. Navigate into the project folder.
```
cd tool-formalizer
```

2. Open Claude Code.
```
claude
```

3. Point the system at your tools folder.
```
/setup
```

## Usage

1. Get the template.
```
/new-tool
```

2. Submit the completed template.
```
/new-tool-submission
```

## The template

| Field | Template |
| --- | --- |
| **Tool** | One-sentence description of a single reusable mathematical implication or operation. State it generally, independent of any particular problem. A Tool must correspond to exactly one mathematical implication or operation, not a sequence of implications. |
| **Formal source** | The theorem, proposition, lemma, definition, or standard result that justifies the tool. |
| **What it accomplishes** | Describe the mathematical transformation, simplification, or class of problems the tool enables. |
| **Example** | Give a complete, self-contained example demonstrating the tool in action. The example should be understandable on its own and should conclude with a bibliographic reference, e.g., **Reference:** Harold Edwards, _Galois Theory_ (2nd ed.), Fourth Exercise Set, Exercise 11. |

## Example completed template

| Field | Value |
| --- | --- |
| **Tool** | Use the discriminant of an irreducible cubic polynomial to determine whether its Galois group over the base field is $A_3$ or $S_3$. |
| **Formal source** | Classical discriminant criterion for cubic polynomials: an irreducible cubic over a field $K$ has Galois group contained in $A_3$ iff its discriminant is a square in $K$; otherwise the Galois group is $S_3$. |
| **What it accomplishes** | Converts the discriminant into a determination of the permutation group of the roots, distinguishing between cyclic ($A_3$) and full symmetric ($S_3$) Galois behavior. |
| **Example** | Let $f(x)=x^3+px+q \in K[x]$ be irreducible with discriminant $\Delta=-4p^3-27q^2$. Assume $\Delta \notin K^2$. Then $\mathrm{Gal}(f)\cong S_3$. This implies the Galois group has 6 elements, not 3 elements as would be the case if $\mathrm{Gal}(f)\cong A_3$, so the orbit of a resolvent element under the group action consists of 6 conjugates, producing 6 linear factors in the associated splitting-field factorization. **Reference:** Harold Edwards, *Galois Theory* (2nd ed.), Fifth Exercise Set, Exercise 7. |

## Example workflow

After solving a math problem, paste your solution into ChatGPT. Start up Claude Code in the project folder, then run `/new-tool` and copy its output, which includes the prompt, the instructions, a blank template, and a completed example. Paste this entire output into ChatGPT. Once the AI has generated template tables that you are satisfied with, run `/new-tool-submission` separately for each completed table.

## Running tests

1. Make the test script executable (first time only).
```
chmod +x test.sh
```

2. Run the test.
```
./test.sh
```