---
description: Output the math tool template for documenting a reusable mathematical method
---

Print the following exactly, with no modifications:

---

Provide the below AI prompt, template, and example to your preferred AI such as ChatGPT. Call `/new-tool-submission` to add it to your tool library.

## AI Prompt

You will be provided with:
1. A **template** that defines the required structure and output format.
2. An **example** of the template filled out correctly.
3. The mathematical content from which the new output should be generated.

Complete this task in the following steps. **Step 1:** Identify all distinct techniques used in the solution and number them. **Step 2:** Confirm the list with the user. Ask the user, "Please confirm this list of techniques. If you would like to add or remove any techniques, let me know." **Step 3** Do not begin this step until Step 2 is completed. Ask the user, "Should I generate template entries for the entire list or only for selected ones. If only for selected ones, tell me which ones." **Step 4** Do not begin this step until Step 3 is completed. Ask the user, "The table will show an example of the technique in action. Which example should I reference for these techniques? If I should reference the problem and solution that was discussed, then type yes. Otherwise, let me know which one to reference, including the problem statement and solution. **Step 5** Do not begin this step until Step 4 is completed. Ask the user, "What is the source of this problem? For example, Algebra, 1st ed., Michael Artin. Exercise Ch. 1, 1.1." **Step 6:** Do not begin this step until step 5 is completed. For each numbered technique, generate a separate completed template entry - output each as its own Markdown table. Use the example only as a guide for formatting, level of detail, writing style, and organization. Do **not** copy or adapt the mathematical content from the example unless it is explicitly part of the new input.

When filling out the template as a Markdown table, follow these requirements:

### Tool

* Describe exactly one general mathematical operation, principle, or concept.
* The tool must represent a single atomic mathematical action (not a procedure or sequence of steps).
* The description should typically begin with a verb.
* Do not combine multiple mathematical ideas (e.g., transformation + solving + substitution).
* Do not reference specific exercises, problem instances, or numerical values unless intrinsic to the definition.

### Formal Source

* State the precise mathematical justification for the tool as a **named mathematical result** (e.g., theorem, lemma, proposition, definition, or corollary).
* State the actual mathematical result that justifies or defines the tool.
* Do **not** explain where the result was encountered.
* Do **not** simply restate the tool in different words.

### What It Accomplishes

* Describe the mathematical function of the tool.
* Explain what transformation, simplification, extension, computation, or type of argument the tool enables.
* Focus on **how the tool is used**, not on why it is true.

### Example

Provide a fully self-contained worked example demonstrating the tool.

The example must:

* Use at least one explicitly identifiable element (statement, equation, object, or step) taken directly from the provided mathematical content, and clearly correspond to it without restating or narrating the full solution.
* Treat any reused material as a standalone mathematical object, not as part of an argument or proof flow.
* Explicitly define every variable, function, set, matrix, or other mathematical object that appears.
* Demonstrate the application of the tool step by step using only the objects defined in the example itself.
* Avoid reconstructing or summarizing the broader solution; the example must not describe what happens “in the solution” or “in the argument.”
* Avoid context-dependent references such as “as above,” “earlier,” or “from the previous solution.”
* Be understandable on its own without requiring additional context beyond the explicitly included mathematical objects.
* Conclude with a bibliographic reference whenever applicable.
* Be contained within one row of the Markdown table.

### Mathematical Formatting

* Write all mathematical expressions in LaTeX.
* Use only `$...$`.

### Correctness

* Verify that every mathematical statement and derivation is correct.
* Do not invent definitions, theorems, or intermediate steps.
* If a claim cannot be justified from standard mathematical results or the provided context, explicitly state that it cannot be verified rather than presenting it as fact.

Your output should match the structure of the provided template exactly while replacing the content with the appropriate information derived from the new mathematical material and putting it all in a Markdown table.

Here is the template:

| Field | Template |
| --- | --- |
| **Tool** | One-sentence description of a single reusable mathematical implication or operation. State it generally, independent of any particular problem. A Tool must correspond to exactly one mathematical implication or operation, not a sequence of implications. |
| **Formal source** | The theorem, proposition, lemma, definition, or standard result that justifies the tool. |
| **What it accomplishes** | Describe the mathematical transformation, simplification, or class of problems the tool enables. |
| **Example** | Give a complete, self-contained example demonstrating the tool in action. The example should be understandable on its own and should conclude with a bibliographic reference, e.g., **Reference:** Harold Edwards, _Galois Theory_ (2nd ed.), Fourth Exercise Set, Exercise 11. |

---

Here is an example of the template filled out:

| Field | Value |
| --- | --- |
| **Tool** | Use the discriminant of an irreducible cubic polynomial to determine whether its Galois group over the base field is $A_3$ or $S_3$. |
| **Formal source** | Classical discriminant criterion for cubic polynomials: an irreducible cubic over a field $K$ has Galois group contained in $A_3$ iff its discriminant is a square in $K$; otherwise the Galois group is $S_3$. |
| **What it accomplishes** | Converts the discriminant into a determination of the permutation group of the roots, distinguishing between cyclic ($A_3$) and full symmetric ($S_3$) Galois behavior. |
| **Example** | Let $f(x)=x^3+px+q \in K[x]$ be irreducible with discriminant $\Delta=-4p^3-27q^2$. Assume $\Delta \notin K^2$. Then $\mathrm{Gal}(f)\cong S_3$. This implies the Galois group has 6 elements, not 3 elements as would be the case if $\mathrm{Gal}(f)\cong A_3$, so the orbit of a resolvent element under the group action consists of 6 conjugates, producing 6 linear factors in the associated splitting-field factorization. **Reference:** Harold Edwards, *Galois Theory* (2nd ed.), Fifth Exercise Set, Exercise 7. |
