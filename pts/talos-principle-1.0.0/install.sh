#!/bin/sh

HOME=$DEBUG_REAL_HOME steam steam://install/257510

echo "RunAsync(function()
  -- wait until start screen is shown
  Wait(CustomEvent(\"StartScreen_Shown\"));
  -- handle initial interactions
  gamHandleInitialInteractions();
  
  -- use medium speed by default
  prj_psGameOptionPlayerSpeed = 1;
  -- make sure developer cheats are enabled
  cht_bEnableCheats = 2;
  -- enable the bot
  cht_bAutoTestBot = 1;
  -- optional: make bot skip terminals and QR codes
  bot_bSkipTerminalsAndMessages = 1;
  -- start a new game
  local episode = \"Content/Talos/Levels/Demo.nfo\"
  bmk_bAutoQuit = 1;
  bmkStartBenchmarking(3, 30);
  prjStartNewTalosGame(episode);
  Wait(Delay(36))
  bmkResults();
  Quit();
  
  -- wait until game ends
  BreakableRunHandled(
    WaitForever,
    -- if fame ended
    On(CustomEvent(\"GameEnded\")),
    function()
      print(\"Finished auto test bot run\");
      BreakRunHandled();
    end,
    -- if test bot failed
    On(CustomEvent(\"AutoTestBot_Failed\")),
    function()
      BreakRunHandled();
    end
  )
  -- quit the game after finished running the auto test bot
  quit();
end);" > $DEBUG_REAL_HOME/talos-run-test.lua

echo "#!/bin/bash
#!/bin/sh
export HOME=\$DEBUG_REAL_HOME
export SteamStreaming=\"\"
export LD_LIBRARY_PATH=\"\$DEBUG_REAL_HOME/.steam/ubuntu12_32:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/panorama:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu:\$DEBUG_REAL_HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib::/usr/lib32:\$DEBUG_REAL_HOME/.steam/ubuntu12_32:\$DEBUG_REAL_HOME/.steam/ubuntu12_64:\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/The\ Talos\ Principle/Bin:\$DEBUG_REAL_HOME/.steam/steam/steamapps/common/The\ Talos\ Principle/Bin/bin\"
export STEAM_CLIENT_CONFIG_FILE=\"\$DEBUG_REAL_HOME/.steam/steam.cfg\"
export Steam3Master=\"127.0.0.1:57343\"
export SteamStreamingMaximumResolution=\"\"
export SteamStreamingAllowGameVsync=\"\"
export SDL_VIDEO_X11_DGAMOUSE=\"0\"
export SteamAppId=\"257510\"
export SteamTenfoot=\"0\"
cd \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/The\ Talos\ Principle/Bin
./Talos +exec $DEBUG_REAL_HOME/talos-run-test.lua
rm -f \$HOME/talos-run-test.lua
cat \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/The\ Talos\ Principle/Log/Talos.log > \$LOG_FILE
rm -f \$DEBUG_REAL_HOME/.steam/steam/steamapps/common/The\ Talos\ Principle/Log/Talos.log
" > talos-principle
chmod +x talos-principle
