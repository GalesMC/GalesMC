#!/bin/bash

###############################################################################
# Optimized EaglercraftX Paper 1.12.2 Server Launcher
# Cleaned up and improved for stability, logging, and performance
###############################################################################

# === CONFIGURATION ===
JAR_NAME="paper-1.12.2.jar"
MIN_RAM="4G"
MAX_RAM="8G"
RESTART_DELAY=10


# === JVM PERFORMANCE FLAGS ===
JVM_OPTS=(
  -Xms$MIN_RAM
  -Xmx$MAX_RAM
  -XX:+UseG1GC
  -XX:+ParallelRefProcEnabled
  -XX:MaxGCPauseMillis=100
  -XX:+UnlockExperimentalVMOptions
  -XX:+DisableExplicitGC
  -XX:+AlwaysPreTouch
  -XX:G1NewSizePercent=20
  -XX:G1MaxNewSizePercent=60
  -XX:G1HeapRegionSize=16M
  -XX:G1ReservePercent=15
  -XX:G1HeapWastePercent=3
  -XX:G1MixedGCCountTarget=6
  -XX:InitiatingHeapOccupancyPercent=20
  -XX:G1MixedGCLiveThresholdPercent=85
  -XX:G1RSetUpdatingPauseTimePercent=5
  -XX:SurvivorRatio=32
  -XX:MaxTenuringThreshold=1
  -Dcom.mojang.eula.agree=true
)

# === LOGGING ===
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/latest.log"
mkdir -p "$LOG_DIR"

# === SERVER LAUNCH LOOP ===
echo ""
echo "========================================================="
echo "  Starting EaglercraftX (Paper 1.12.2)"
echo "  RAM: $MIN_RAM to $MAX_RAM | Restart Delay: ${RESTART_DELAY}s"
echo "========================================================="
echo ""

while true; do
  echo "[INFO] Launching server..." | tee -a "$LOG_FILE"
  java "${JVM_OPTS[@]}" -jar "$JAR_NAME" nogui | tee -a "$LOG_FILE"

  echo "" | tee -a "$LOG_FILE"
  echo "[WARN] Server stopped. Restarting in $RESTART_DELAY seconds..." | tee -a "$LOG_FILE"
  sleep "$RESTART_DELAY"
done
