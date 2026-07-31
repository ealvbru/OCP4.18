#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q16 - Must-Gather
═══════════════════════════════════════════════════════════════════════════════

  # Run must-gather
  oc adm must-gather

  # Find the output directory
  ls must-gather.local.*

  # Archive it
  tar -cvzf ~/must-gather-archive.tar.gz must-gather.local.*

Verify:
  ls -lh ~/must-gather-archive.tar.gz

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
