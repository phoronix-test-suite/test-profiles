#!/bin/sh
unzip -o SuperTuxKart-1.5-beta1-mac.zip
cat > config.xml <<'EOT'
<?xml version="1.0"?>
<stkconfig version="8" >
    <Audio
        sfx_on="false"
        music_on="false"
        sfx_numerator="10"
        sfx_volume="0.267800"
        music_numerator="10"
        music_volume="0.267800"
        volume_denominator="15"
    >
    </Audio>
    <RaceSetup
        numkarts="8"
        numlaps="4"
        gp-reverse="0"
        random-gp-num-tracks="1"
        ffa-time-limit="3"
        use-ffa-mode="false"
        lap-trial-time-limit="3"
        numgoals="3"
        soccer-default-team="0"
        soccer-time-limit="3"
        soccer-use-time-limit="false"
        random-arena-item="false"
        difficulty="0"
        game_mode="0"
        soccer-red-ai-num="0"
        soccer-blue-ai-num="0"
        karts-powerup-gui="false"
        soccer-player-list="false"
        addon-tux-online="false"
        random-player-pos="false"
    >
    </RaceSetup>
    <WiiMote
        wiimote-raw-max="20.000000"
        wiimote-weight-linear="1.000000"
        wiimote-weight-square="0.000000"
        wiimote-weight-asin="0.000000"
        wiimote-weight-sin="0.000000"
    >
    </WiiMote>
    <Multitouch
        multitouch_active="1"
        multitouch_draw_gui="false"
        multitouch_inverted="false"
        multitouch_auto_acceleration="false"
        multitouch_controls="0"
        multitouch_deadzone="0.100000"
        multitouch_sensitivity_x="0.200000"
        multitouch_sensitivity_y="0.650000"
        multitouch_tilt_factor="4.000000"
        multitouch_scale="1.200000"
        screen_keyboard_status="0"
    >
    </Multitouch>
    <GpStartOrder
        most_points_first="true"
        player_last="false"
    >
    </GpStartOrder>

    <additional_gp_directory value="" />
    <Video
        real_width="1920"
        real_height="1200"
        width="1920"
        height="1200"
        fullscreen="true"
        prev_real_width="1920"
        prev_real_height="1200"
        prev_fullscreen="false"
        remember_window_location="false"
        window_x="-1"
        window_y="-1"
        show_fps="true"
        show_story_mode_timer="true"
        show_speedrun_timer="false"
        max_fps="9999"
        force_legacy_device="false"
        split_screen_horizontally="true"
        enable_texture_compression="true"
        enable_high_definition_textures="3"
        enable_glow="true"
        enable_bloom="true"
        enable_light_shaft="true"
        enable_dynamic_lights="true"
        enable_dof="true"
        old_driver_popup="true"
        scale_rtts_factor="1.000000"
        max_texture_size="512"
        hq_mipmap="false"
        font_size="3.000000"
        render_driver="gl"
        vulkan_fullscreen_desktop="true"
        non_ge_fullscreen_desktop="false"
    >
    </Video>
    <Recording
        limit_game_fps="true"
        video_format="0"
        audio_bitrate="112000"
        video_bitrate="20000"
        recorder_jpg_quality="90"
        record_fps="30"
    >
    </Recording>

    <!-- Wan server bookmarks -->
    <server-bookmarks>
    </server-bookmarks>

    <!-- Wan server bookmarks order -->
    <server-bookmarks-order>
    </server-bookmarks-order>

    <!-- Last 5 IP addresses that user entered -->
    <address-history>
    </address-history>

    <!-- The stun servers that will be used to know the public address (ipv4 only) with port -->
    <ipv4-stun-servers>
        <stun-server address="stunv4.7.supertuxkart.net:3478" ping="0"/>
        <stun-server address="stunv4.8.supertuxkart.net:3478" ping="0"/>
        <stun-server address="stunv4.linuxreviews.org:3478" ping="0"/>
    </ipv4-stun-servers>

    <!-- The stun servers that will be used to know the public address (including ipv6) with port -->
    <ipv6-stun-servers>
        <stun-server address="stun.linuxreviews.org:3478" ping="0"/>
        <stun-server address="stun.stunprotocol.org:3478" ping="0"/>
        <stun-server address="stun.supertuxkart.net:3478" ping="0"/>
    </ipv6-stun-servers>
    <Network
        enable-network-splitscreen="false"
        log-network-packets="false"
        random-client-port="true"
        random-server-port="false"
        lobby-chat="true"
        race-chat="true"
        ipv6-lan="true"
        max-players="8"
        timer-sync-difference-tolerance="5"
        default-ip-type="0"
        lan-server-gp="false"
        wan-server-gp="true"
    >
    </Network>

    <!-- The Number of karts per gamemode. -->
    <num-karts-per-gamemode>
        <gamemode-list gamemode="0" num-karts="4"/>
        <gamemode-list gamemode="1002" num-karts="5"/>
        <gamemode-list gamemode="1100" num-karts="4"/>
        <gamemode-list gamemode="1101" num-karts="4"/>
        <gamemode-list gamemode="2000" num-karts="4"/>
        <gamemode-list gamemode="2001" num-karts="4"/>
    </num-karts-per-gamemode>
    <GFX
        particles-effecs="2"
        christmas-mode="2"
        easter-ear-mode="2"
        animated-characters="true"
        geometry_level="0"
        anisotropic="16"
        swap-interval="0"
        motionblur_enabled="true"
        mlaa="true"
        ssao="true"
        light_scatter="true"
        shadows_resolution="1024"
        Degraded_IBL="false"
    >
    </GFX>

    <cache-overworld value="true" />

    <crashed value="false" />
    <camera-normal
        distance="1.000000"
        forward-up-angle="0.000000"
        forward-smoothing="true"
        backward-distance="2.000000"
        backward-up-angle="5.000000"
        fov="80"
    >
    </camera-normal>

    <!-- Use ball camera in soccer mode, instead of reverse -->
    <reverse-look-use-soccer-cam value="false" />

    <!-- The current used camera. 0=Custom; 1=Standard; 2=Drone chase -->
    <camera-present value="1" />
    <standard-camera-settings
        distance="1.000000"
        forward-up-angle="0.000000"
        forward-smoothing="true"
        backward-distance="2.000000"
        backward-up-angle="5.000000"
        fov="80"
        reverse-look-use-soccer-cam="false"
    >
    </standard-camera-settings>
    <drone-camera-settings
        distance="2.600000"
        forward-up-angle="33.000000"
        forward-smoothing="false"
        backward-distance="2.000000"
        backward-up-angle="10.000000"
        fov="100"
        reverse-look-use-soccer-cam="false"
    >
    </drone-camera-settings>
    <saved-camera-settings
        distance="1.000000"
        forward-up-angle="0.000000"
        forward-smoothing="true"
        backward-distance="2.000000"
        backward-up-angle="5.000000"
        fov="80"
        reverse-look-use-soccer-cam="false"
    >
    </saved-camera-settings>
    <camera
        reverse_look_threshold="0"
        fpscam_rotation_speed="0.003000"
        fpscam_smooth_rotation_max_speed="0.040000"
        fpscam_angular_velocity="0.020000"
        fpscam_max_angular_velocity="1.000000"
    >
    </camera>

    <!-- Name of the .items file to use. -->
    <item_style value="items" />

    <!-- Name of the last track used. -->
    <last_track value="olivermath" />

    <!-- Last selected track group -->
    <last_track_group value="all" />

    <!-- Discord Client ID (Set to -1 to disable) -->
    <discord_client_id value="817760324983324753" />

    <!-- If debug logging should be enabled for rich presence -->
    <rich_presence_debug value="false" />

    <!-- Name of the skin to use -->
    <skin_name value="classic" />

    <!-- Minimap Setup Settings
             display : display: 0 bottom-left, 1 middle-right, 2 hidden, 3 center
             size : Size of the the minimap (480 = full screen height; scaled afterwards)
             ai-icon : The size of the icons for the AI karts on the minimap.
             player-icon : The size of the icons for the player kart. -->
    <Minimap
        display="0"
        size="180.000000"
        ai-icon="16.000000"
        player-icon="20.000000"
    >
    </Minimap>

    <!-- PowerUp Setup Settings
             display : display: 0 center, 1 right side, 2 hidden (see karts' held powerups)
             powerup-icon-size : Size of the powerup icon (scaled afterwards) -->
    <PowerUp
        display="0"
        powerup-icon-size="64.000000"
    >
    </PowerUp>

    <!-- Everything related to spectator mode.
             camera-distance : Distance between kart and camera.
             camera-angle : Angle between ground, kart and camera. -->
    <Spectator
        camera-distance="6.750000"
        camera-angle="40.000000"
    >
    </Spectator>

    <!-- Everything related to handicaps.
             per_player_difficulty : If handicapped users can be selected -->
    <Handicap
        per_player_difficulty="false"
    >
    </Handicap>

    <!-- Status of internet: 0 user wasn't asked, 1: allowed, 2: not allowed -->
    <enable_internet value="0" />

    <!-- Everything related to hardware configuration.
             report-version : Version of hardware report that was reported last
             random-identifier : A random number to avoid duplicated reports.
             hw-report-enabled : If HW reports are enabled. -->
    <HWReport
        report-version="0"
        random-identifier="0"
        hw-report-enabled="false"
    >
    </HWReport>

    <!-- Always show the login screen even if last player's session was saved. -->
    <always_show_login_screen value="false" />
    <AddonServer
        news_last_updated="0"
        news_frequency="0"
        news_display_count=""
        last_important_message_id="-1"
        news_list_shown_id="0"
        addon_last_updated="0"
        latest_addon_time="0"
    >
    </AddonServer>

    <!-- Which language to use (language code or 'system') -->
    <language value="system" />

    <!-- Whether to enable track debugging features -->
    <artist_debug_mode value="false" />

    <!-- Whether to hide the GUI (artist debug mode) -->
    <debug_hide_gui value="false" />

    <!-- Enable all karts and tracks: 0 = disabled, 1 = everything except final race, 2 = everything -->
    <unlock_everything value="2" />

    <!-- Allows one to set commandline args in config file -->
    <commandline value="" />

</stkconfig>
EOT
mkdir -p ~/Library/Application\ Support/SuperTuxKart/config-0.10/
cp -f config.xml ~/Library/Application\ Support/SuperTuxKart/config-0.10/config.xml
echo "#!/bin/sh
rm -f ~/Library/Application\ Support/SuperTuxKart/config-0.10/stdout.log
./SuperTuxKart.app/Contents/MacOS/supertuxkart \$@ 2>&1
cp ~/Library/Application\ Support/SuperTuxKart/config-0.10/stdout.log \$LOG_FILE
cat ~/Library/Application\ Support/SuperTuxKart/config-0.10/stdout.log.perf-report-black_forest.csv >> \$LOG_FILE" > supertuxkart
chmod +x supertuxkart
