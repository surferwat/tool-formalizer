#!/usr/bin/env bash
set -eu

PROJECT_DIR="tmp"
TOOLS_PATH="$PROJECT_DIR/tools"
INPUT_FILE="$PROJECT_DIR/input.md"
EXPECTED_FILE="$PROJECT_DIR/expected.md"

cleanup() {
  rm -rf "$PROJECT_DIR"
}
trap cleanup EXIT

init_env() {
  rm -rf "$PROJECT_DIR"
  mkdir -p "$TOOLS_PATH"
  mkdir -p "$PROJECT_DIR/.claude/skills"
}

setup_fixture() {
  cp -R .claude/skills/new-tool-submission \
    "$PROJECT_DIR/.claude/skills/"

  cat > "$PROJECT_DIR/CLAUDE.md" <<EOF
## Configuration

TOOLS_PATH=$TOOLS_PATH
EOF

  cat > "$INPUT_FILE" <<'EOF'
| Field | Value |
| --- | --- |
| **Tool** | Use the discriminant of an irreducible cubic polynomial to determine whether its Galois group over the base field is $A_3$ or $S_3$. |
| **Formal source** | Classical discriminant criterion for cubic polynomials: an irreducible cubic over a field $K$ has Galois group contained in $A_3$ iff its discriminant is a square in $K$; otherwise the Galois group is $S_3$. |
| **What it accomplishes** | Converts the discriminant into a determination of the permutation group of the roots, distinguishing between cyclic ($A_3$) and full symmetric ($S_3$) Galois behavior. |
| **Example** | Let $f(x)=x^3+px+q \in K[x]$ be irreducible with discriminant $\Delta=-4p^3-27q^2$. Assume $\Delta \notin K^2$. Then $\mathrm{Gal}(f)\cong S_3$. This implies the Galois group has 6 elements, not 3 elements as would be the case if $\mathrm{Gal}(f)\cong A_3$, so the orbit of a resolvent element under the group action consists of 6 conjugates, producing 6 linear factors in the associated splitting-field factorization. **Reference:** Harold Edwards, *Galois Theory* (2nd ed.), Fifth Exercise Set, Exercise 7. |
EOF

  cat > "$EXPECTED_FILE" <<'EOF'
| Field | Value |
| --- | --- |
| **Tool** | Use the discriminant of an irreducible cubic polynomial to determine whether its Galois group over the base field is $A_3$ or $S_3$. |
| **Formal source** | Classical discriminant criterion for cubic polynomials: an irreducible cubic over a field $K$ has Galois group contained in $A_3$ iff its discriminant is a square in $K$; otherwise the Galois group is $S_3$. |
| **What it accomplishes** | Converts the discriminant into a determination of the permutation group of the roots, distinguishing between cyclic ($A_3$) and full symmetric ($S_3$) Galois behavior. |
| **Example** | Let $f(x)=x^3+px+q \in K[x]$ be irreducible with discriminant $\Delta=-4p^3-27q^2$. Assume $\Delta \notin K^2$. Then $\mathrm{Gal}(f)\cong S_3$. This implies the Galois group has 6 elements, not 3 elements as would be the case if $\mathrm{Gal}(f)\cong A_3$, so the orbit of a resolvent element under the group action consists of 6 conjugates, producing 6 linear factors in the associated splitting-field factorization. **Reference:** Harold Edwards, *Galois Theory* (2nd ed.), Fifth Exercise Set, Exercise 7. |
EOF
}

run_claude() {
  (
    cd "$PROJECT_DIR"
    claude -p /new-tool-submission < input.md --allowedTools "Bash,Read,Write"
  )
}

assert_output() {
  shopt -s nullglob

  files=("$TOOLS_PATH"/*.md)

  [ ${#files[@]} -eq 1 ] || {
    echo "FAIL: expected 1 file, got ${#files[@]}"
    exit 1
  }

  diff -u "$EXPECTED_FILE" "${files[0]}" || {
    echo "FAIL: output does not exactly match expected"
    exit 1
  }
}

init_env
setup_fixture
run_claude
assert_output

echo "PASS"