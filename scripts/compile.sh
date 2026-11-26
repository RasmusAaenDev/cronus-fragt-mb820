#!/bin/bash
# Compile the AL project in ./app (or ./test) with the Business Central 28 compiler, natively on Linux.
#   scripts/compile.sh [app|test] [--codecop | --appsource]
#   --codecop   CodeCop, UICop, PerTenantExtensionCop and the project's cronusfragt.ruleset.json (as in .vscode/settings.json)
#   --appsource trial build: PerTenantExtensionCop is swapped for AppSourceCop (reads AppSourceCop.json in the project); not the normal build
# Needs the symbol cache and compiler in ~/.bc-tools/28.0.46665.51486 (see the README).
set -u
BC=${BC:-/home/rasmus/.bc-tools/28.0.46665.51486}
REPO=$(cd "$(dirname "$0")/.." && pwd)
PROJ=${1:-app}
WORK=/tmp/alc-cronus-fragt
CACHE=$WORK/pkgcache
mkdir -p "$CACHE"
ln -sf "$BC"/packagecache/*.app "$CACHE"/ 2>/dev/null
ALC="$BC/alext/extension/bin/linux/alc"
ANALYZE=""
for a in "$@"; do
  if [ "$a" = "--codecop" ] || [ "$a" = "--appsource" ]; then
    COPS="CodeCop UICop PerTenantExtensionCop"
    [ "$a" = "--appsource" ] && COPS="CodeCop UICop AppSourceCop"
    [ -f "$REPO/$PROJ/cronusfragt.ruleset.json" ] && ANALYZE="$ANALYZE /ruleset:$REPO/$PROJ/cronusfragt.ruleset.json"
    for d in $COPS; do
      dll=$(find "$BC/alext/extension/bin" -name "Microsoft.Dynamics.Nav.$d.dll" | head -1)
      [ -n "$dll" ] && ANALYZE="$ANALYZE /analyzer:$dll"
    done
  fi
done
if [ "$PROJ" = "test" ]; then
  "$ALC" /project:"$REPO/app" /packagecachepath:"$CACHE" /out:"$CACHE/Cronus_Cronus Fragt.app" >"$WORK/app-for-test.log" 2>&1 \
    || { echo "app build failed (the test project needs its symbols)"; grep ': error ' "$WORK/app-for-test.log" | head -30; exit 1; }
fi
LOG=$WORK/$PROJ.log
# shellcheck disable=SC2086
"$ALC" /project:"$REPO/$PROJ" /packagecachepath:"$CACHE" /out:"$WORK/$PROJ.app" $ANALYZE >"$LOG" 2>&1
rc=$?
echo "=== $PROJ: exit=$rc errors=$(grep -c ': error ' "$LOG") warnings=$(grep -c ': warning ' "$LOG") ==="
grep -E ': (error|warning) ' "$LOG" | sort -u | head -40
exit $rc
