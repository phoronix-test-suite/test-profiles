#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/203160


echo "#!/bin/bash
. steam-env-vars.sh
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/Tomb\ Raider/bin

rm -f \$DEBUG_REAL_HOME/.local/share/feral-interactive/Tomb\ Raider/VFS/Local/benchmarks/*.txt

echo \"
Fullscreen = 1
ExclusiveFullscreen = 1
AspectRatio = 0
VSyncMode = 0
FullscreenWidth = \$1
FullscreenHeight = \$2
FullscreenRefreshRate = 60
StereoEnabled = 0
TextureQuality = 4
BestTextureFilter = 18
HairQuality = 0
AntiAliasingMode = 1
ShadowMode = 1
ShadowResolution = 0
SSAOMode = 1
DOFQuality = 1
ReflectionQuality = 2
LODScale = 4
EnablePostProcess = 1
EnableHighPrecisionRT = 0
EnableTessellation = 0
EnableMotionBlur = 1
EnableScreenEffects = 1
 QualityLevel = \$3
\" > tombraider-linux.ini

./TombRaider -benchmark tombraider-linux.ini

cat \$DEBUG_REAL_HOME/.local/share/feral-interactive/Tomb\ Raider/VFS/Local/benchmarks/*.txt > \$LOG_FILE
# rm -f \$DEBUG_REAL_HOME/.local/share/feral-interactive/Tomb\ Raider/VFS/Local/benchmarks/*.txt" > tomb-raider
chmod +x tomb-raider
