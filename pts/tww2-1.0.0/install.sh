#!/bin/bash -e
# Install Total War WARHAMMER II on Linux and generate launcher scripts and preference templates

# Base constants
#
export STEAM_GAME_ID=594570
export GAME_PREFS="$DEBUG_REAL_HOME/.local/share/feral-interactive/Total War WARHAMMER II"
export GAME_INSTALL_DIR_BASE="steamapps/common/Total War WARHAMMER II/"
export DEFAULT_STEAM_INSTALL_BASE="$DEBUG_REAL_HOME/.steam/steam"


# Try and install the game in case it isn't already
#
echo "Ensuring game is installed"
HOME="$DEBUG_REAL_HOME" steam "steam://install/$STEAM_GAME_ID"


# Work out the steam install directory
#
export CONFIG_PATH="$DEBUG_REAL_HOME/.steam/steam/config/config.vdf"
echo "Searching ${CONFIG_PATH} for install directories"
_INSTALL_PATHS=$( awk '/BaseInstallFolder/ { gsub(/"/, "", $2); print $2 }' "${CONFIG_PATH}" )

# Find one that contains the game
while read -r STEAM_PATH; do
    _NEW_FULL_PATH="${STEAM_PATH}/${GAME_INSTALL_DIR_BASE}"
    echo "Checking for game install: ${_NEW_FULL_PATH}"
    if [ -d "${_NEW_FULL_PATH}" ]; then
        echo "Found game install: ${_NEW_FULL_PATH}"
        export GAME_INSTALL_DIR="${_NEW_FULL_PATH}"
    fi
done <<< "${_INSTALL_PATHS}"

# Allow the default location as well
if [ ! -d "${GAME_INSTALL_DIR}" ]; then
    export GAME_INSTALL_DIR="${DEFAULT_STEAM_INSTALL_BASE}/${GAME_INSTALL_DIR_BASE}"
    echo "Using default directory for game install: ${GAME_INSTALL_DIR}"
fi

# Bail if we still couldn't find the game
if [ ! -f "${GAME_INSTALL_DIR}/TotalWarhammer2.sh" ]; then
    >&2 echo "Missing run script in install dir - ${GAME_INSTALL_DIR}/TotalWarhammer2.sh"
    exit 1
fi

# Gather the steam env variables the game runs with
#
echo "Gathering environment variables for game"
HOME="$DEBUG_REAL_HOME" steam steam://run/$STEAM_GAME_ID &
sleep 6
GAME_PID=$( pidof TotalWarhammer2 | cut -d' ' -f1 )
if [ -z "$GAME_PID" ]; then
    echo "Could not find process TotalWarhammer2"
    exit 1
fi

echo '#!/bin/bash' > steam-env-vars.sh
echo "# Collected steam environment for Total War: Warhammer II\n# PID : $GAME_PID" >> steam-env-vars.sh
while read -rd $'\0' ENV ; do
    NAME=$(echo "$ENV" | cut -zd= -f1); VAL=$(echo "$ENV" | cut -zd= -f2)
    case $NAME in
	*DBUS*) true
	;;
	*)
        echo "export $NAME=\"$VAL\""
	;;
    esac
done < "/proc/$GAME_PID/environ" >> steam-env-vars.sh
killall -9 TotalWarhammer2
sleep 6



if [ -z "${STEAM_ACCOUNT_ID}" ]; then
    pushd "${GAME_PREFS}/SaveData/"
    STEAM_ACCOUNT_ID="$(ls |head -1)"
    popd
else
    STEAM_ACCOUNT_ID="Steam Saves (${STEAM_ACCOUNT_ID})"
fi

RESULTS_PREFIX="${GAME_PREFS}/SaveData/${STEAM_ACCOUNT_ID}/"


# Create the game launching script
#
echo "Generating run script"
cat > tww2.sh <<- EOM
#!/bin/bash
# Generated run script for Total War: WARHAMMER II
# $( date )

# Source the steam runtime environment
#
. steam-env-vars.sh

# Run the game
#
cd "${GAME_INSTALL_DIR}"
./TotalWarhammer2.sh

# Grab the output (most recent non _frametimes txt file)
RESULTS_DIR="${RESULTS_PREFIX}benchmarks/"
mkdir -p "\${RESULTS_DIR}"
cd "\${RESULTS_DIR}"
true > "\$LOG_FILE"
FPS_VALUES=\$( grep -A3 "frames per second" \$(ls -t | grep -P "benchmark_.*[0-9]+.txt" | head -n 1) | tail -n 3 )
cat benchmark_*.txt >>  "\$LOG_FILE"
echo "\${FPS_VALUES}" >> "\$LOG_FILE"
EOM
chmod +x tww2.sh


# Create the template preferences file
#
echo "Generating settings template"
cat > preferences.template.xml <<- EOM
<?xml version="1.0" encoding="UTF-8"?>
<registry>
    <key name="HKEY_CLASSES_ROOT">
    </key>
    <key name="HKEY_CURRENT_CONFIG">
    </key>
    <key name="HKEY_CURRENT_USER">
        <key name="AutoValueRemap">
            <key name="GPURemap">
                <key name="keys">
                    <value name="Software\IndirectX\Direct3D\Config" type="integer">1</value>
                </key>
                <key name="values">
                    <value name="Software\Feral Interactive\Total War WARHAMMER II\Setup\FullScreen" type="integer">1</value>
                    <value name="Software\Feral Interactive\Total War WARHAMMER II\Setup\ScreenH" type="integer">1</value>
                    <value name="Software\Feral Interactive\Total War WARHAMMER II\Setup\ScreenW" type="integer">1</value>
                </key>
            </key>
        </key>
        <key name="Software">
            <key name="Feral Interactive">
                <key name="Total War WARHAMMER II">
                    <key name="Setup">
                        <!-- disable pausing -->
                        <value name="AllowPausing" type="integer">0</value>
                        <value name="PauseMoviesOnPause" type="integer">0</value>
                        <value name="PauseOnSuspend" type="integer">0</value>
                        <value name="PauseSoundOnPause" type="integer">0</value>
                        <value name="PauseTimersOnPause" type="integer">0</value>

                        <value name="AllowSendUsageData" type="integer">0</value>


                        <!-- Don't show splash screen -->
                        <value name="GameOptionsDialogLastTab" type="integer">60000</value>
                        <value name="GameOptionsDialogShouldShow" type="integer">0</value>
                        <value name="GameOptionsDialogShouldShowBigPicture" type="integer">0</value>
                        <value name="GameOptionsDialogShown" type="integer">1</value>

                        <!-- Disable Splash Screen Warnings -->
                        <value name="SoftwareUpdatedAskedUser" type="integer">1</value>
                        <value name="SoftwareUpdatedCanCheck" type="integer">0</value>

                        <key name="GraphicsSettings">
                            <value name="advice_level" type="integer">2</value>
                            <value name="advisor_mode" type="integer">2</value>
                            <value name="alliance_faction_colours" type="integer">0</value>
                            <value name="audio_api_type" type="integer">0</value>
                            <value name="audio_mute_in_background" type="integer">1</value>
                            <value name="audio_quality" type="integer">0</value>
                            <value name="audio_speaker_configuration" type="integer">0</value>
                            <value name="battle_camera_shake_enabled" type="integer">1</value>
                            <value name="battle_defend_default" type="integer">0</value>
                            <value name="battle_groups_locked_by_default" type="integer">0</value>
                            <value name="battle_run_by_default" type="integer">1</value>
                            <value name="battle_skirmish_default" type="integer">1</value>
                            <value name="camera_move_speed" type="binary">0000000000005940</value>
                            <value name="camera_turn_speed" type="binary">0000000000001440</value>
                            <value name="cinematic_smoothing" type="binary">0000000000002ec0</value>
                            <value name="default_battle_camera_type" type="integer">0</value>
                            <value name="gfx_aa" type="integer">@gfx_aa@</value>
                            <value name="gfx_alpha_blend" type="integer">0</value>
                            <value name="gfx_blood_effects" type="integer">1</value>
                            <value name="gfx_brightness_setting" type="binary">000000403333f33f</value>
                            <value name="gfx_building_quality" type="integer">@gfx_building_quality@</value>
                            <value name="gfx_depth_of_field" type="integer">0</value>
                            <value name="gfx_device_type" type="integer">1</value>
                            <value name="gfx_distortion" type="integer">1</value>
                            <value name="gfx_effects_quality" type="integer">@gfx_effects_quality@</value>
                            <value name="gfx_first_run" type="integer">0</value>
                            <value name="gfx_fog" type="integer">@gfx_fog@</value>
                            <value name="gfx_gamma_setting" type="binary">0000000000000040</value>
                            <value name="gfx_gpu_select" type="integer">0</value>
                            <value name="gfx_grass_quality" type="integer">@gfx_grass_quality@</value>
                            <value name="gfx_lighting_quality" type="integer">@gfx_lighting_quality@</value>
                            <value name="gfx_resolution_scale" type="binary">000000000000f03f</value>
                            <value name="gfx_screen_space_reflections" type="integer">0</value>
                            <value name="gfx_shadow_quality" type="integer">@gfx_shadow_quality@</value>
                            <value name="gfx_sharpening" type="integer">1</value>
                            <value name="gfx_sky_quality" type="integer">@gfx_sky_quality@</value>
                            <value name="gfx_ssao" type="integer">@gfx_ssao@</value>
                            <value name="gfx_terrain_quality" type="integer">@gfx_terrain_quality@</value>
                            <value name="gfx_tesselation" type="integer">0</value>
                            <value name="gfx_texture_filtering" type="integer">@gfx_texture_filtering@</value>
                            <value name="gfx_texture_quality" type="integer">@gfx_texture_quality@</value>
                            <value name="gfx_tree_quality" type="integer">@gfx_tree_quality@</value>
                            <value name="gfx_unit_quality" type="integer">@gfx_unit_quality@</value>
                            <value name="gfx_unit_size" type="integer">@gfx_unit_size@</value>
                            <value name="gfx_unlimited_video_memory" type="integer">0</value>
                            <value name="gfx_vignette" type="integer">0</value>
                            <value name="gfx_vsync" type="integer">0</value>
                            <value name="gfx_water_quality" type="integer">@gfx_water_quality@</value>
                            <value name="invert_cam_x_axis" type="integer">0</value>
                            <value name="invert_cam_y_axis" type="integer">0</value>
                            <value name="mouse_wheel_sensitivity" type="integer">50</value>
                            <value name="porthole_3d" type="integer">@porthole_3d@</value>
                            <value name="proximity_fading" type="integer">1</value>
                            <value name="scroll_transition_enabled" type="integer">1</value>
                            <value name="show_projectile_trails" type="integer">1</value>
                            <value name="sound_advisor_volume" type="integer">100</value>
                            <value name="sound_master_enabled" type="integer">1</value>
                            <value name="sound_master_volume" type="integer">100</value>
                            <value name="sound_music_enabled" type="integer">1</value>
                            <value name="sound_music_volume" type="integer">100</value>
                            <value name="sound_sfx_volume" type="integer">100</value>
                            <value name="sound_vo_enabled" type="integer">1</value>
                            <value name="sound_vo_volume" type="integer">100</value>
                            <value name="subtitles" type="integer">0</value>
                            <value name="ui_colour_profile" type="integer">0</value>
                            <value name="ui_mouse_scroll" type="integer">1</value>
                            <value name="ui_scale" type="binary">000000000000f03f</value>
                            <value name="ui_unit_id_scale" type="binary">0000000000000000</value>
                            <value name="ui_unit_tooltip_expand_mode" type="integer">2</value>
                            <value name="voice_chat_enable" type="integer">1</value>
                            <value name="voice_chat_microphone_gain" type="integer">100</value>
                            <value name="voice_chat_microphone_gain_boost" type="integer">1</value>
                            <value name="voice_chat_transmit_only_when_key_pressed" type="integer">1</value>
                            <value name="voice_chat_volume" type="integer">100</value>
                        </key>

                        <value name="AvoidSwapInjectionDuringPGOW" type="integer">1</value>
                        <value name="ConstrainLiveWindowResize" type="integer">1</value>
                        <value name="DisableMomentumScrolling" type="integer">1</value>
                        <value name="DoneMinOS" type="integer">1</value>
                        <value name="DonePromotional" type="integer">1</value>
                        <value name="DoneUnsupported" type="integer">1</value>
                        <value name="ForceSystemFullscreen" type="integer">1</value>
                        <value name="FullScreen" type="integer">1</value>
                        <value name="GameSelected" type="integer">0</value>
                        <value name="LiveWindowResizePercentage" type="integer">0</value>
                        <value name="LiveWindowResizeThreshold" type="integer">0</value>
                        <value name="MinWindowedHeight" type="integer">0</value>
                        <value name="MinWindowedWidth" type="integer">0</value>
                        <value name="MissionControlDetection" type="integer">1</value>
                        <value name="ScreenH" type="integer">@screen_height@</value>
                        <value name="ScreenW" type="integer">@screen_width@</value>
                        <value name="SpecificationFirstLaunchCheck" type="integer">0</value>
                        <value name="UseDynamicShroud" type="integer">1</value>
                        <value name="UseRestrictedWorkGroupSize" type="integer">1</value>
                        <value name="UseSpecializedShaders" type="integer">1</value>
                    </key>
                </key>
            </key>
            <key name="MacDoze">
                <key name="Config">
                    <value name="ExtraCommandLine" type="string">game_startup_mode benchmark_auto_quit script/benchmarks/@benchmark_name@</value>
                    <value name="ExtraCommandLineEnabled" type="integer">1</value>
                </key>
            </key>
        </key>
    </key>
    <key name="HKEY_LOCAL_MACHINE">
        <key name="Hardware">
        </key>
        <key name="Software">
        </key>
    </key>
    <key name="HKEY_USERS">
    </key>
</registry>
EOM
