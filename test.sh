#!/usr/bin/env bash
set -eu

if [ $# -ne 1 ]; then
  echo "Usage: $0 <claude|codex>"
  exit 1
fi

CODING_AGENT="$1"

TEMP_DIR="tmp"
TOOLS_DIR="tools"
TEST_TOOLS_PATH="$TEMP_DIR/$TOOLS_DIR"
INPUT_FILE="$TEMP_DIR/input.md"
EXPECTED_FILE="$TEMP_DIR/expected.md"

case "$CODING_AGENT" in
  claude)
    CONFIG_FILE="CLAUDE.md"
    SKILLS_DIR=".claude/skills"
    SUBMISSION_COMMAND="/new-tool-submission"
    ;;
  codex)
    CONFIG_FILE="AGENTS.md"
    SKILLS_DIR=".agents/skills"
    SUBMISSION_COMMAND="\$new-tool-submission"
    ;;
  *)
    echo "Usage: $0 <claude|codex>"
    exit 1
    ;;
esac

cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

init_env() {
  rm -rf "$TEMP_DIR"

  mkdir -p "$TEST_TOOLS_PATH"
  mkdir -p "$TEMP_DIR/$SKILLS_DIR"
}

setup_fixture() {
  if [ ! -d "$SKILLS_DIR/new-tool-submission" ]; then
    echo "Missing skill: $SKILLS_DIR/new-tool-submission"
    exit 1
  fi

  cp -R "$SKILLS_DIR/new-tool-submission" \
    "$TEMP_DIR/$SKILLS_DIR/"

  cat > "$TEMP_DIR/$CONFIG_FILE" <<EOF
## Configuration

TOOLS_PATH=$TOOLS_DIR
EOF

  cat > "$INPUT_FILE" <<'EOF'
| Field | Value |
| --- | --- |
| **Tool** | Use the discriminant of an irreducible cubic polynomial to determine whether its Galois group over the base field is $A_3$ or $S_3$. |
| **Formal source** | Classical discriminant criterion for cubic polynomials: an irreducible cubic over a field $K$ has Galois group contained in $A_3$ iff its discriminant is a square in $K$; otherwise the Galois group is $S_3$. |
| **What it accomplishes** | Converts the discriminant into a determination of the permutation group of the roots, distinguishing between cyclic ($A_3$) and full symmetric ($S_3$) Galois behavior. |
| **Example** | Let $f(x)=x^3+px+q \in K[x]$ be irreducible with discriminant $\Delta=-4p^3-27q^2$. Assume $\Delta \notin K^2$. Then $\mathrm{Gal}(f)\cong S_3$, hence $\|Gal(f)\|=6$, whereas in the case of $\mathrm{Gal}(f)\cong A_3$, one has $\|Gal(f)\|=3$. **Reference:** Harold Edwards, *Galois Theory* (2nd ed.), Fifth Exercise Set, Exercise 7. |
EOF

  cat > "$EXPECTED_FILE" <<'EOF'
| Field | Value |
| --- | --- |
| **Tool** | Use the discriminant of an irreducible cubic polynomial to determine whether its Galois group over the base field is $A_3$ or $S_3$. |
| **Formal source** | Classical discriminant criterion for cubic polynomials: an irreducible cubic over a field $K$ has Galois group contained in $A_3$ iff its discriminant is a square in $K$; otherwise the Galois group is $S_3$. |
| **What it accomplishes** | Converts the discriminant into a determination of the permutation group of the roots, distinguishing between cyclic ($A_3$) and full symmetric ($S_3$) Galois behavior. |
| **Example** | Let $f(x)=x^3+px+q \in K[x]$ be irreducible with discriminant $\Delta=-4p^3-27q^2$. Assume $\Delta \notin K^2$. Then $\mathrm{Gal}(f)\cong S_3$, hence $\|Gal(f)\|=6$, whereas in the case of $\mathrm{Gal}(f)\cong A_3$, one has $\|Gal(f)\|=3$. **Reference:** Harold Edwards, *Galois Theory* (2nd ed.), Fifth Exercise Set, Exercise 7. |
EOF
}

run_agent() {
  (
    cd "$TEMP_DIR"

    case "$CODING_AGENT" in
      claude)
        claude \
          -p "$SUBMISSION_COMMAND" \
          < input.md \
          --allowedTools "Bash,Read,Write"
        ;;
      codex)
        codex \
          exec "$SUBMISSION_COMMAND" \
          < input.md \
          > /dev/null 2>&1
        ;;
    esac
  )
}

assert_output() {
  shopt -s nullglob

  files=("$TEST_TOOLS_PATH"/*.md)

  [ ${#files[@]} -eq 1 ] || {
    echo "FAIL: expected 1 file, got ${#files[@]}"
    exit 1
  }

  diff -u "$EXPECTED_FILE" "${files[0]}" || {
    echo "FAIL: output does not exactly match expected"
    exit 1
  }
}

echo "Starting test ..."

init_env
setup_fixture
run_agent
assert_output

echo "PASS"