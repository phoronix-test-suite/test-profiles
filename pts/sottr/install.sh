#!/bin/bash -e
# Install Shadow of the Tomb Raider on Linux and generate launcher scripts and preference templates

# Base constants
#
export STEAM_GAME_ID=750920
export GAME_PREFS="$DEBUG_REAL_HOME/.local/share/feral-interactive/Shadow of the Tomb Raider"
export GAME_INSTALL_DIR_BASE="steamapps/common/Shadow of the Tomb Raider/"
export DEFAULT_STEAM_INSTALL_BASE="$HOME/.steam/steam"
GAME_INSTALL_DIR="/var/data0/SOTTR/data"

# Create the game launching script
#
cat > shadowofthetombraider <<- EOM
#!/bin/bash
# Generated run script for Shadow of the Tomb Raider
# Mon Oct 28 13:46:00 PDT 2019

# Source the steam runtime environment
#
. steam-env-vars.sh

# Clear the results dir

RESULTS_DIR="/home/perflab1/.local/share/feral-interactive/Shadow of the Tomb Raider/SaveData/"
if [ -d "\${RESULTS_DIR}" ]; then
    rm -R "\${RESULTS_DIR}"
    mkdir -p "\${RESULTS_DIR}"
fi

# Run the game
#
cd "/var/data0/SOTTR/data"
./ShadowOfTheTombRaider.sh

# Grab the output (most recent xml file results line)
#
# NOTE: There's also a location_machine_frametimes_datetime.txt file for more detailed results
cd "\${RESULTS_DIR}"
true > "\$LOG_FILE"
FPS_VALUES=\$(grep --text --no-filename FPS -R --include="*.txt" | head -3 | tr -d '\r' | paste -s )
echo "\${BENCH}: \${FPS_VALUES}" >> "\${LOG_FILE}"
EOM
chmod +x shadowofthetombraider


# Create the template preferences file
#
cat > preferences.template.xml <<- EOM
<?xml version="1.0" encoding="UTF-8"?>
<registry>
    <key name="HKEY_CLASSES_ROOT">
    </key>
    <key name="HKEY_CURRENT_CONFIG">
    </key>
    <key name="HKEY_CURRENT_USER">
        <key name="Software">
            <key name="Eidos Montreal">
                <key name="Shadow of the Tomb Raider">
                    <value name="ChannelFormat" type="integer">0</value>
                    <value name="FirstRun" type="integer">0</value>
                    <value name="SteamLanguage" type="integer">0</value>
                    <value name="TextLanguage" type="integer">0</value>
                    <value name="VOLanguage" type="integer">0</value>
                    <key name="Graphics">
                        <key name="Defaults">
                            <value name="AA" type="integer">@gfx_aa@</value>
                            <value name="AmbientOcclusionQuality" type="integer">@gfx_ao@</value>
                            <value name="Bloom" type="integer">@gfx_bloom@</value>
                            <value name="DOFQuality" type="integer">@gfx_dof_quality@</value>
                            <value name="Fullscreen" type="integer">1</value>
                            <value name="FullscreenHeight" type="integer">@ScreenH@</value>
                            <value name="FullscreenWidth" type="integer">@ScreenW@</value>
                            <value name="LevelOfDetail" type="integer">@gfx_lod@</value>
                            <value name="MotionBlur" type="integer">@gfx_motion_blur@</value>
                            <value name="Preset" type="integer">@gfx_preset@</value>
                            <value name="ScreenSpaceContactShadows" type="integer">@gfx_contact_shadows@</value>
                            <value name="ScreenSpaceReflections" type="integer">@gfx_reflections@</value>
                            <value name="ShadowQuality" type="integer">@gfx_shadow_quality@</value>
                            <value name="Tessellation" type="integer">@gfx_tessellation@</value>
                            <value name="TextureFiltering" type="integer">@gfx_tex_filter@</value>
                            <value name="TextureQuality" type="integer">@gfx_tex_quality@</value>
                            <value name="TressFX" type="integer">@gfx_tressfx@</value>
                            <value name="VolumetricLighting" type="integer">@gfx_volumetric@</value>
                        </key>
                    </key>
                </key>
            </key>
            <key name="Feral Interactive">
                <key name="Shadow of the Tomb Raider">
                    <key name="Setup">
                        <value name="AllowPausing" type="integer">0</value>
                        <value name="AllowSendCrashReports" type="integer">0</value>
                        <value name="AllowSendUsageData" type="integer">0</value>
                        <value name="AvoidSwapInjectionDuringPGOW" type="integer">1</value>
                        <value name="ConstrainLiveWindowResize" type="integer">1</value>
                        <value name="DoneMinOS" type="integer">0</value>
                        <value name="DonePromotional" type="integer">0</value>
                        <value name="DoneUnsupported" type="integer">0</value>
                        <value name="GameOptionsDialogShouldShow" type="integer">0</value>
                        <value name="GameOptionsDialogShouldShowBigPicture" type="integer">0</value>
                        <value name="GameOptionsDialogShown" type="integer">1</value>
                        <value name="GameSelected" type="integer">0</value>
                        <value name="IgnoreLanguageHeadings" type="integer">1</value>
                        <value name="LiveWindowResizePercentage" type="integer">0</value>
                        <value name="LiveWindowResizeThreshold" type="integer">0</value>
                        <value name="MinWindowedHeight" type="integer">0</value>
                        <value name="MinWindowedWidth" type="integer">0</value>
                        <value name="PauseMoviesOnPause" type="integer">0</value>
                        <value name="PauseOnSuspend" type="integer">0</value>
                        <value name="PauseSoundOnPause" type="integer">0</value>
                        <value name="PauseTimersOnPause" type="integer">0</value>
                        <value name="RestoreMouseOnSuspend" type="integer">1</value>
                        <value name="RestoreResOnSuspend" type="integer">1</value>
                        <value name="ScreenH" type="integer">0</value>
                        <value name="ScreenW" type="integer">0</value>
                        <value name="ShowAssertAlerts" type="integer">0</value>
                        <value name="ShowLevelSelect" type="integer">1</value>
                        <value name="ShowTheHideDockCheckbox" type="integer">0</value>
                        <value name="SoftwareUpdatedAskedUser" type="integer">1</value>
                        <value name="SoftwareUpdatedCanCheck" type="integer">1</value>
                        <value name="SpecificationFirstLaunchCheck" type="integer">0</value>
                        <key name="SpecificationAlerts">
                            <value name="DriverOrHardwareUnsupported" type="integer">1</value>
                            <value name="LnxCPUGovernorSubOptimal" type="integer">1</value>
                        </key>               
                    </key>
                </key>
            </key>
            <key name="MacDoze">
                <key name="Config">
                    <value name="ClearSavesEnabled" type="integer">0</value>
                    <value name="DisableClearSaveDataAlert" type="integer">0</value>
                    <value name="ExtraCommandLine" type="string">--feral-benchmark</value>
                    <value name="ExtraCommandLineEnabled" type="integer">1</value>
                </key>
            </key>
        </key>
    </key>
</registry>
EOM
