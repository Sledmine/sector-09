
(global boolean player_tracking 0)


(global boolean loadout_mode 1)


(global short player_location -1)


(global boolean location_update 0)


(global boolean alive 0)


(global boolean intro 1)


(global boolean firefight 0)


(global short wave 1)


(global short music 0)


(global long wave_total 1)


(global long set 1)


(global boolean nickster 0)


(global short lives_count 7)


(global short wave1_number -1)


(global short wave2_number -1)


(global short wave3_number -1)


(global short wave4_number -1)


(global short wave5_number -1)


(global boolean reinforcements 0)


(global boolean respawning 0)


(global boolean commands 0)


(global boolean camera_switch 1)


(global boolean variable 0)


(global boolean firefight_variables 0)


(global boolean support 0)


(global short a_support 0)


(global boolean block 0)


(global boolean legendary_mode 0)


(global boolean support_squads 0)


(global boolean camera_mode 0)


(global boolean death 0)


(global boolean debugging 1)


(global boolean visr 0)


(global boolean flashlight_state 0)


(global boolean visr_needs_to_toggle 0)


(global boolean visr_state 0)


(global boolean visr_vehicle 0)


(global boolean visr_edge 1)


(global short loadout 0)


(global boolean loadout_confirm 0)

(script stub unit player0
    (unit (list_get (players) 0))
)


(script continuous firefight_debugging
    (sleep_until (= firefight_variables 1))
    (ai 0)
    (player_enable_input 0)
    (game_speed 1.000000)
    (sleep 30)
    (sleep 120)
    (inspect firefight)
    (inspect wave)
    (inspect music)
    (inspect wave_total)
    (inspect nickster)
    (inspect lives_count)
    (inspect reinforcements)
    (sleep 120)
    (inspect respawning)
    (inspect commands)
    (inspect camera_switch)
    (inspect variable)
    (inspect (get_yaw_rate 3))
    (inspect (get_yaw_rate 3))
    (inspect (get_yaw_rate 2))
    (inspect (get_pitch_rate 1))
    (inspect (get_yaw_rate 4))
    (sleep 120)
    (ai 0)
    (player_enable_input 0)
    (game_speed 1.000000)
    (inspect player_tracking)
    (inspect player_location)
    (inspect location_update)
    (sleep 120)
    (ai 0)
    (player_enable_input 0)
    (game_speed 1.000000)
    (inspect loadout)
    (inspect loadout_confirm)
    (sleep 60)
    (player_enable_input 1)
    (game_speed 1.000000)
    (sleep 90)
    (ai 1)
    (set firefight_variables 0)
)


(script startup cheats (set cheat_deathless_player 1))


(script continuous cleanup
    (sleep 2400)
    (rasterizer_decals_flush)
    (garbage_collect_now)
)


(script continuous waveprinter
    (cls)
    (inspect wave_total)
)


(script continuous lives_display
    (sleep_until (= alive 1))
    (if
        (<= lives_count -1)
        (sleep -1)
    )
    (if
        (= lives_count 0)
        (cinematic_set_title 0lives)
    )
    (if
        (= lives_count 1)
        (cinematic_set_title 1lives)
    )
    (if
        (= lives_count 2)
        (cinematic_set_title 2lives)
    )
    (if
        (= lives_count 3)
        (cinematic_set_title 3lives)
    )
    (if
        (= lives_count 4)
        (cinematic_set_title 4lives)
    )
    (if
        (= lives_count 5)
        (cinematic_set_title 5lives)
    )
    (if
        (= lives_count 6)
        (cinematic_set_title 6lives)
    )
    (if
        (= lives_count 7)
        (cinematic_set_title 7lives)
    )
    (if
        (= lives_count 8)
        (cinematic_set_title 8lives)
    )
    (if
        (= lives_count 9)
        (cinematic_set_title 9lives)
    )
    (if
        (= lives_count 10)
        (cinematic_set_title 10lives)
    )
    (if
        (= lives_count 11)
        (cinematic_set_title 11lives)
    )
    (if
        (= lives_count 12)
        (cinematic_set_title 12lives)
    )
)


(script continuous cheat_detector
    (if
        (or
            (= cheat_infinite_ammo 1)
            (= cheat_medusa 1)
            (= cheat_bottomless_clip 1)
            (= cheat_super_jump 1)
            (= cheat_omnipotent 1)
            (= cheat_bump_possession 1)
        )
        (quit)
    )
)


(script static void visr_on
    (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\visr-on\visr-on none 1.000000)
    ;(if
    ;    (= visr_edge 1)
    ;    (begin
    ;        ;(pp_set_effect_instance_fade 0 0.000000 1.000000 0.300000)
    ;        ;(pp_set_effect_instance_fade 1 0.000000 1.000000 0.300000)
    ;        ;(pp_set_effect_instance_active 0 1)
    ;        ;(pp_set_effect_instance_active 1 1)
    ;    )
    ;)
    (set visr_state 1)
)


(script static void visr_off
    (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\visr-off\visr-off none 1.000000)
    ;(pp_set_effect_instance_fade 0 1.000000 0.000000 0.250000)
    ;(pp_set_effect_instance_fade 1 1.000000 0.000000 0.250000)
    ;(pp_set_effect_instance_active 0 0)
    ;(pp_set_effect_instance_active 1 0)
    (set visr_state 0)
)


(script continuous flashlight_state_check
    (if
        (= (unit_get_current_flashlight_state (player0)) 1)
        (begin
            (set flashlight_state 1)
            (set visr 1)
            (if
                (= visr_state 0)
                (set visr_needs_to_toggle 1)
            )
        )
    )
    (if
        (= (unit_get_current_flashlight_state (player0)) 0)
        (begin
            (set flashlight_state 0)
            (set visr 0)
            (if
                (= visr_state 1)
                (set visr_needs_to_toggle 1)
            )
        )
    )
)


(script continuous visr_set
    (if
        (and
            (= flashlight_state 1)
            (= visr 1)
        )
        (if
            (= visr_needs_to_toggle 1)
            (begin
                (visr_on)
                (set visr_needs_to_toggle 0)
            )
        )
    )
    (if
        (and
            (= flashlight_state 0)
            (= visr 0)
        )
        (if
            (= visr_needs_to_toggle 1)
            (begin
                (visr_off)
                (set visr_needs_to_toggle 0)
            )
        )
    )
)


(script continuous loadout
    (sleep_until (= loadout_mode 1))
    ;(display_scripted_ui_widget loadouts)
    (set loadout_mode 0)
)


(script static void loadout_a
    (set loadout 1)
    (set loadout_confirm 1)
)


(script static void loadout_b
    (set loadout 2)
    (set loadout_confirm 1)
)


(script static void loadout_c
    (set loadout 3)
    (set loadout_confirm 1)
)


(script static void loadout_d
    (set loadout 4)
    (set loadout_confirm 1)
)


(script static void loadout_e
    (set loadout 5)
    (set loadout_confirm 1)
)

(script continuous loadout_spawn
    (sleep_until
        (and
            (= loadout_confirm 1)
            (>= loadout 1)
        )
    )
    (fade_out 0.000000 0.000000 0.000000 0)
    (player_add_equipment
        (unit (list_get (players) 0))
        empty
        1
    )
    (sleep 3)
    (player_add_equipment
        (unit (list_get (players) 0))
        balls
        1
    )
    (sleep 3)
    (player_add_equipment
        (unit (list_get (players) 0))
        empty
        1
    )
    (sleep 3)
    (player_add_equipment
        (unit (list_get (players) 0))
        empty
        1
    )
    (sleep 3)
    (if
        (= loadout 1)
        (player_add_equipment
            (unit (list_get (players) 0))
            loadout_a
            1
        )
    )
    (if
        (= loadout 2)
        (player_add_equipment
            (unit (list_get (players) 0))
            loadout_b
            1
        )
    )
    (if
        (= loadout 3)
        (player_add_equipment
            (unit (list_get (players) 0))
            loadout_c
            1
        )
    )
    (if
        (= loadout 4)
        (player_add_equipment
            (unit (list_get (players) 0))
            loadout_d
            1
        )
    )
    (if
        (= loadout 5)
        (player_add_equipment
            (unit (list_get (players) 0))
            loadout_e
            1
        )
    )
    (player_enable_input 1)
    (cinematic_set_title fire)
    (sleep_until (= (player_action_test_primary_trigger) 1))
    (show_hud_help_text 0)
    (sleep 90)
    (object_teleport
        (unit (list_get (players) 0))
        starting_point
    )
    (camera_control 0)
    (fade_in 0.000000 0.000000 0.000000 30)
    (cinematic_show_letterbox 0)
    (set loadout 0)
    (sleep 120)
    (if
        (= intro 1)
        (begin
            (sound_looping_stop rzs_halo\levels\s9_final\sounds\music\intro\all)
            (sleep 180)
        )
    )
    (if
        (= intro 0)
        (ai 1)
    )
    (set loadout_confirm 0)
    (set loadout_mode 0)
    (set firefight 1)
    (set debugging 1)
    (set alive 1)
    (camera_set loadout_cam 0)
    (set camera_mode 0)
)


(script continuous hunt
    (sleep_until (= player_tracking 1))
    (if
        (=
            (volume_test_objects base_left (player0))
            1
        )
        (begin
            (set player_location 1)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/1)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/1)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/1)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/1)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/1)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/1)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/1)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/1)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/1)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/1)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/1)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/1)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/1)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/1)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/1)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/1)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/1)
            )
            (sleep_until
                (!=
                    (volume_test_objects base_left (player0))
                    1
                )
            )
        )
    )
    (if
        (=
            (volume_test_objects base_right (player0))
            1
        )
        (begin
            (set player_location 2)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/2)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/2)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/2)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/2)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/2)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/2)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/2)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/2)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/2)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/2)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/2)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/2)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/2)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/2)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/2)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/2)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/2)
            )
            (sleep_until
                (!=
                    (volume_test_objects base_right (player0))
                    1
                )
            )
        )
    )
    (if
        (=
            (volume_test_objects base_upper_deck (player0))
            1
        )
        (begin
            (set player_location 3)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/3)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/3)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/3)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/3)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/3)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/3)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/3)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/3)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/3)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/3)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/3)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/3)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/3)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/3)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/3)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/3)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/3)
            )
            (sleep_until
                (!=
                    (volume_test_objects base_upper_deck (player0))
                    1
                )
            )
        )
    )
    (if
        (=
            (volume_test_objects ammo_room (player0))
            1
        )
        (begin
            (set player_location 0)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/0)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/0)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/0)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/0)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/0)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/0)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/0)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/0)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/0)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/0)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/0)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/0)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/0)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/0)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/0)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/0)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/0)
            )
            (sleep_until
                (!=
                    (volume_test_objects ammo_room (player0))
                    1
                )
            )
        )
    )
    (if
        (=
            (volume_test_objects streets_left (player0))
            1
        )
        (begin
            (set player_location 4)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/4)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/4)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/4)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/4)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/4)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/4)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/4)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/4)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/4)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/4)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/4)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/4)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/4)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/4)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/4)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/4)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/4)
            )
            (sleep_until
                (!=
                    (volume_test_objects streets_left (player0))
                    1
                )
            )
        )
    )
    (if
        (=
            (volume_test_objects streets_right (player0))
            1
        )
        (begin
            (set player_location 5)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/5)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/5)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/5)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/5)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/5)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/5)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/5)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/5)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/5)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/5)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/5)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/5)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/5)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/5)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/5)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/5)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/5)
            )
            (sleep_until
                (!=
                    (volume_test_objects streets_right (player0))
                    1
                )
            )
        )
    )
    (if
        (=
            (volume_test_objects deathpit (player0))
            1
        )
        (begin
            (set player_location 6)
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/6)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/6)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/6)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/6)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/6)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/6)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/6)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/6)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/6)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/6)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/6)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/6)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/6)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/6)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/6)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/6)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/6)
            )
            (sleep_until
                (!=
                    (volume_test_objects deathpit (player0))
                    1
                )
            )
        )
    )
    (if
        (not
            (and
                (=
                    (volume_test_objects deathpit (player0))
                    1
                )
                (=
                    (volume_test_objects streets_right (player0))
                    1
                )
                (=
                    (volume_test_objects streets_left (player0))
                    1
                )
                (=
                    (volume_test_objects ammo_room (player0))
                    1
                )
                (=
                    (volume_test_objects base_upper_deck (player0))
                    1
                )
                (=
                    (volume_test_objects base_left (player0))
                    1
                )
                (=
                    (volume_test_objects base_right (player0))
                    1
                )
            )
        )
        (begin
            (if
                (> (ai_living_count elite_squad_a) 0)
                (ai_migrate elite_squad_a elite_squad_a/0)
            )
            (if
                (> (ai_living_count elite_squad_b) 0)
                (ai_migrate elite_squad_b elite_squad_b/0)
            )
            (if
                (> (ai_living_count elite_squad_c) 0)
                (ai_migrate elite_squad_c elite_squad_c/0)
            )
            (if
                (> (ai_living_count elite_killsquad_a) 0)
                (ai_migrate elite_killsquad_a elite_killsquad_a/0)
            )
            (if
                (> (ai_living_count elite_killsquad_b) 0)
                (ai_migrate elite_killsquad_b elite_killsquad_b/0)
            )
            (if
                (> (ai_living_count elite_killsquad_c) 0)
                (ai_migrate elite_killsquad_c elite_killsquad_c/0)
            )
            (if
                (> (ai_living_count elite_pack_a) 0)
                (ai_migrate elite_pack_a elite_pack_a/0)
            )
            (if
                (> (ai_living_count elite_pack_b) 0)
                (ai_migrate elite_pack_b elite_pack_b/0)
            )
            (if
                (> (ai_living_count mystic_a) 0)
                (ai_migrate mystic_a mystic_a/0)
            )
            (if
                (> (ai_living_count mystic_b) 0)
                (ai_migrate mystic_b mystic_b/0)
            )
            (if
                (> (ai_living_count brute_squad_a) 0)
                (ai_migrate brute_squad_a brute_squad_a/0)
            )
            (if
                (> (ai_living_count brute_squad_b) 0)
                (ai_migrate brute_squad_b brute_squad_b/0)
            )
            (if
                (> (ai_living_count brute_killsquad_a) 0)
                (ai_migrate brute_killsquad_a brute_killsquad_a/0)
            )
            (if
                (> (ai_living_count brute_killsquad_b) 0)
                (ai_migrate brute_killsquad_b brute_killsquad_b/0)
            )
            (if
                (> (ai_living_count brute_killsquad_c) 0)
                (ai_migrate brute_killsquad_c brute_killsquad_c/0)
            )
            (if
                (> (ai_living_count brute_pack_a) 0)
                (ai_migrate brute_pack_a brute_pack_a/0)
            )
            (if
                (> (ai_living_count brute_pack_b) 0)
                (ai_migrate brute_pack_b brute_pack_b/0)
            )
        )
    )
)


(script static void reset
    (player_add_equipment
        (unit (list_get (players) 0))
        empty
        1
    )
    (sleep 3)
    (player_add_equipment
        (unit (list_get (players) 0))
        balls
        1
    )
    (sleep 3)
    (player_add_equipment
        (unit (list_get (players) 0))
        empty
        1
    )
    (sleep 3)
    (player_add_equipment
        (unit (list_get (players) 0))
        empty
        1
    )
    (sleep 3)
)


(script static void camera
    (reset)
    (set debugging 1)
    (fade_out 0.000000 0.000000 0.000000 0)
    (garbage_collect_now)
    (rasterizer_decals_flush)
    (camera_control 1)
    (player_enable_input 0)
    (object_teleport
        (unit (list_get (players) 0))
        teleport
    )
    (cinematic_show_letterbox 1)
    (sleep 30)
    (fade_out 0.000000 0.000000 0.000000 0)
    (camera_set cam1 0)
    (set camera_mode 1)
    (fade_in 0.000000 0.000000 0.000000 30)
    (if
        (>= lives_count 0)
        (set respawning 1)
    )
    (if
        (= intro 1)
        (sound_looping_start rzs_halo\levels\s9_final\sounds\music\intro\all none 1.000000)
    )
)


(script startup define
    (camera)
    (set debugging 1)
)

(script continuous armor
    (sleep_until (= nickster 1))
    (if
        (= nickster 1)
        (begin
            (object_set_permutation
                (unit (list_get (players) 0))
                backpack
                mickey
            )
            (object_set_permutation
                (unit (list_get (players) 0))
                headgear
                romeo_up
            )
            (object_set_permutation
                (unit (list_get (players) 0))
                chest
                buck
            )
            (object_set_permutation
                (unit (list_get (players) 0))
                l_shoulder
                mickey
            )
            (object_set_permutation
                (unit (list_get (players) 0))
                r_shoulder
                romeo_down
            )
        )
    )
    (set nickster 0)
)

(script continuous never_die
    (sleep_until (= cheat_deathless_player 0))
    (set cheat_deathless_player 1)
)


(script continuous loadout_camera
    (sleep_until (= camera_mode 1))
    (if
        (= intro 1)
        (begin
            (camera_set cam1 0)
            (sleep 90)
            (camera_set cam2 1200)
            (sleep 1410)
            (camera_set cam1 1200)
            (sleep 1320)
        )
    )
    (if
        (= intro 0)
        (camera_set loadout_cam 0)
    )
)


(script continuous die_motherfucker
    (sleep_until
        (=
            (unit_get_health
                (unit (list_get (players) 0))
            )
            0.000000
        )
    )
    (set alive 0)
    (unit_set_desired_flashlight_state (player0) 0)
    (set firefight 0)
    (set lives_count (- lives_count 1.000000))
    (if
        (<= lives_count -1)
        (begin
            (player_enable_input 0)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\skyline\skyline)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\drums\drums)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\perc1\perc1)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\atmo_set\atmo)
            (set death 1)
            (fade_out 1.000000 0.000000 0.000000 30)
            (sleep 30)
            (object_teleport
                (unit (list_get (players) 0))
                end_point
            )
            (camera_control 1)
            (camera_set end 0)
            (fade_in 1.000000 0.000000 0.000000 30)
            (sound_looping_start rzs_halo\levels\s9_final\sounds\music\intro\all none 1.000000)
            (ai_erase_all)
            (sleep 90)
            (if
                (= wave_total 1)
                (cinematic_set_title recruit)
            )
            (if
                (and
                    (>= wave_total 2)
                    (<= wave_total 5)
                )
                (cinematic_set_title private)
            )
            (if
                (and
                    (>= wave_total 6)
                    (<= wave_total 15)
                )
                (cinematic_set_title corporal)
            )
            (if
                (and
                    (>= wave_total 16)
                    (<= wave_total 30)
                )
                (cinematic_set_title sergenant)
            )
            (if
                (and
                    (>= wave_total 31)
                    (<= wave_total 60)
                )
                (cinematic_set_title warrant_officer)
            )
            (if
                (and
                    (>= wave_total 61)
                    (<= wave_total 99)
                )
                (cinematic_set_title captain)
            )
            (if
                (>= wave_total 100)
                (begin
                    (cinematic_set_title general)
                    (sleep 30)
                )
            )
            (sleep 9000)
            (game_revert)
        )
    )
    (sleep 30)
    (if
        (>= lives_count 0)
        (begin
            (player_enable_input 0)
            (fade_out 0.000000 0.000000 0.000000 30)
            (sleep 30)
            (object_teleport
                (unit (list_get (players) 0))
                teleport
            )
            (ai 0)
            (set loadout_mode 1)
            (camera)
        )
    )
)


(script static void dont_drop_the_soap
    (unit_doesnt_drop_items (ai_actors grunt_patrol))
    (unit_doesnt_drop_items (ai_actors jackal_patrol))
    (unit_doesnt_drop_items (ai_actors elite_patrol_a))
    (unit_doesnt_drop_items (ai_actors elite_patrol_b))
    (unit_doesnt_drop_items (ai_actors jackal_grunt_patrol))
    (unit_doesnt_drop_items (ai_actors elite_squad_a))
    (unit_doesnt_drop_items (ai_actors elite_squad_b))
    (unit_doesnt_drop_items (ai_actors elite_squad_c))
    (unit_doesnt_drop_items (ai_actors elite_killsquad_a))
    (unit_doesnt_drop_items (ai_actors elite_killsquad_b))
    (unit_doesnt_drop_items (ai_actors elite_killsquad_c))
    (unit_doesnt_drop_items (ai_actors elite_pack_a))
    (unit_doesnt_drop_items (ai_actors elite_pack_b))
    (unit_doesnt_drop_items (ai_actors mystic_a))
    (unit_doesnt_drop_items (ai_actors mystic_b))
    (unit_doesnt_drop_items (ai_actors wraith))
    (unit_doesnt_drop_items (ai_actors ghosts))
    (unit_doesnt_drop_items (ai_actors elite_squad_c))
    (unit_doesnt_drop_items (ai_actors elite_support))
    (unit_doesnt_drop_items (ai_actors brute_patrol_a))
    (unit_doesnt_drop_items (ai_actors brute_patrol_b))
    (unit_doesnt_drop_items (ai_actors brute_squad_a))
    (unit_doesnt_drop_items (ai_actors brute_squad_b))
    (unit_doesnt_drop_items (ai_actors brute_killsquad_a))
    (unit_doesnt_drop_items (ai_actors brute_killsquad_b))
    (unit_doesnt_drop_items (ai_actors brute_killsquad_c))
    (unit_doesnt_drop_items (ai_actors brute_pack_a))
    (unit_doesnt_drop_items (ai_actors brute_pack_b))
    (unit_doesnt_drop_items (ai_actors banshee))
    (unit_doesnt_drop_items (ai_actors brute_sniper))
    (unit_doesnt_drop_items (ai_actors inv_elites))
    (unit_doesnt_drop_items (ai_actors test))
)


(script static void spawn_waves
    (if
        (= legendary_mode 0)
        (begin
            (if
                (= wave 5)
                (begin
                    (set player_tracking 1)
                    (if
                        (> wave_total 5)
                        (begin
                            (if
                                (and
                                    (= set 1)
                                    (> wave 2)
                                )
                                (set support 1)
                            )
                            (if
                                (> wave_total 15)
                                (set support 1)
                            )
                        )
                    )
                    (sleep 90)
                    (set support 0)
                    (begin_random
                        (set wave5_number 0)
                        (set wave5_number 1)
                        (set wave5_number 4)
                        (set wave5_number 5)
                    )
                    (sleep 30)
                    (dont_drop_the_soap)
                    (if
                        (= wave5_number 0)
                        (begin
                            (ai_place elite_pack_a)
                            (ai_magically_see_players elite_pack_a)
                            (ai_try_to_fight_player elite_pack_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_pack_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave5_number 1)
                        (begin
                            (ai_place elite_pack_b)
                            (ai_magically_see_players elite_pack_b)
                            (ai_try_to_fight_player elite_pack_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_pack_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave5_number 2)
                        (begin
                            (ai_place mystic_a)
                            (ai_magically_see_players mystic_a)
                            (ai_try_to_fight_player mystic_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count mystic_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave5_number 3)
                        (begin
                            (ai_place mystic_b)
                            (ai_magically_see_players mystic_b)
                            (ai_try_to_fight_player mystic_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count mystic_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave5_number 4)
                        (begin
                            (ai_place brute_pack_a)
                            (ai_magically_see_players brute_pack_a)
                            (ai_try_to_fight_player brute_pack_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_pack_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave5_number 5)
                        (begin
                            (ai_place brute_pack_b)
                            (ai_magically_see_players brute_pack_b)
                            (ai_try_to_fight_player brute_pack_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_pack_b) 0)
                            )
                        )
                    )
                )
            )
            (if
                (= wave 4)
                (begin
                    (set player_tracking 1)
                    (if
                        (> wave_total 5)
                        (begin
                            (if
                                (and
                                    (= set 1)
                                    (> wave 2)
                                )
                                (set support 1)
                            )
                            (if
                                (> wave_total 15)
                                (set support 1)
                            )
                        )
                    )
                    (sleep 90)
                    (set support 0)
                    (begin_random
                        (set wave4_number 0)
                        (set wave4_number 1)
                        (set wave4_number 2)
                        (set wave4_number 3)
                    )
                    (if
                        (= wave4_number 0)
                        (begin
                            (ai_place elite_pack_a)
                            (ai_magically_see_players elite_pack_a)
                            (ai_try_to_fight_player elite_pack_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_pack_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave4_number 1)
                        (begin
                            (ai_place elite_pack_b)
                            (ai_magically_see_players elite_pack_b)
                            (ai_try_to_fight_player elite_pack_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_pack_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave4_number 2)
                        (begin
                            (ai_place brute_pack_a)
                            (ai_magically_see_players brute_pack_a)
                            (ai_try_to_fight_player brute_pack_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_pack_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave4_number 3)
                        (begin
                            (ai_place brute_pack_b)
                            (ai_magically_see_players brute_pack_b)
                            (ai_try_to_fight_player brute_pack_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_pack_b) 0)
                            )
                        )
                    )
                )
            )
            (if
                (= wave 3)
                (begin
                    (set player_tracking 1)
                    (if
                        (> wave_total 5)
                        (begin
                            (if
                                (and
                                    (= set 1)
                                    (> wave 2)
                                )
                                (set support 1)
                            )
                            (if
                                (> wave_total 15)
                                (set support 1)
                            )
                        )
                    )
                    (sleep 90)
                    (set support 0)
                    (begin_random
                        (set wave3_number 0)
                        (set wave3_number 1)
                        (set wave3_number 2)
                        (set wave3_number 3)
                        (set wave3_number 4)
                        (set wave3_number 5)
                        (set wave3_number 6)
                        (set wave3_number 7)
                        (set wave3_number 8)
                        (set wave3_number 9)
                    )
                    (if
                        (= wave3_number 0)
                        (begin
                            (ai_place elite_squad_a)
                            (ai_magically_see_players elite_squad_a)
                            (ai_try_to_fight_player elite_squad_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_squad_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 1)
                        (begin
                            (ai_place elite_squad_b)
                            (ai_magically_see_players elite_squad_b)
                            (ai_try_to_fight_player elite_squad_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_squad_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 2)
                        (begin
                            (ai_place elite_killsquad_a)
                            (ai_magically_see_players elite_killsquad_a)
                            (ai_try_to_fight_player elite_killsquad_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_killsquad_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 3)
                        (begin
                            (ai_place elite_killsquad_b)
                            (ai_magically_see_players elite_killsquad_b)
                            (ai_try_to_fight_player elite_killsquad_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_killsquad_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 4)
                        (begin
                            (ai_place elite_killsquad_c)
                            (ai_magically_see_players elite_killsquad_c)
                            (ai_try_to_fight_player elite_killsquad_c)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_killsquad_c) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 5)
                        (begin
                            (ai_place brute_squad_a)
                            (ai_magically_see_players brute_squad_a)
                            (ai_try_to_fight_player brute_squad_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_squad_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 6)
                        (begin
                            (ai_place brute_squad_b)
                            (ai_magically_see_players brute_squad_b)
                            (ai_try_to_fight_player brute_squad_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_squad_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 7)
                        (begin
                            (ai_place brute_killsquad_a)
                            (ai_magically_see_players brute_killsquad_a)
                            (ai_try_to_fight_player brute_killsquad_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_killsquad_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 8)
                        (begin
                            (ai_place brute_killsquad_b)
                            (ai_magically_see_players brute_killsquad_b)
                            (ai_try_to_fight_player brute_killsquad_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_killsquad_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave3_number 9)
                        (begin
                            (ai_place brute_killsquad_c)
                            (ai_magically_see_players brute_killsquad_c)
                            (ai_try_to_fight_player brute_killsquad_c)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_killsquad_c) 0)
                            )
                        )
                    )
                )
            )
            (if
                (= wave 2)
                (begin
                    (set player_tracking 1)
                    (if
                        (> wave_total 5)
                        (begin
                            (if
                                (and
                                    (= set 1)
                                    (> wave 2)
                                )
                                (set support 1)
                            )
                            (if
                                (> wave_total 15)
                                (begin
                                    (set support 1)
                                    (set support_squads 1)
                                )
                            )
                        )
                    )
                    (sleep 90)
                    (set support 0)
                    (set support_squads 0)
                    (begin_random
                        (set wave2_number 0)
                        (set wave2_number 1)
                        (set wave2_number 2)
                        (set wave2_number 3)
                        (set wave2_number 4)
                        (set wave2_number 5)
                        (set wave2_number 6)
                        (set wave2_number 7)
                    )
                    (if
                        (= wave2_number 0)
                        (begin
                            (ai_place elite_squad_a)
                            (ai_magically_see_players elite_squad_a)
                            (ai_try_to_fight_player elite_squad_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_squad_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 1)
                        (begin
                            (ai_place elite_squad_b)
                            (ai_magically_see_players elite_squad_b)
                            (ai_try_to_fight_player elite_squad_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_squad_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 2)
                        (begin
                            (ai_place elite_patrol_a)
                            (ai_magically_see_players elite_patrol_a)
                            (ai_try_to_fight_player elite_patrol_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_patrol_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 3)
                        (begin
                            (ai_place elite_patrol_b)
                            (ai_magically_see_players elite_patrol_b)
                            (ai_try_to_fight_player elite_patrol_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_patrol_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 4)
                        (begin
                            (ai_place brute_squad_a)
                            (ai_magically_see_players brute_squad_a)
                            (ai_try_to_fight_player brute_squad_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_squad_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 5)
                        (begin
                            (ai_place brute_squad_b)
                            (ai_magically_see_players brute_squad_b)
                            (ai_try_to_fight_player brute_squad_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_squad_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 6)
                        (begin
                            (ai_place brute_patrol_a)
                            (ai_magically_see_players brute_patrol_a)
                            (ai_try_to_fight_player brute_patrol_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_patrol_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave2_number 7)
                        (begin
                            (ai_place brute_patrol_b)
                            (ai_magically_see_players brute_patrol_b)
                            (ai_try_to_fight_player brute_patrol_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_patrol_b) 0)
                            )
                        )
                    )
                )
            )
            (if
                (= wave 1)
                (begin
                    (set player_tracking 1)
                    (if
                        (> wave_total 5)
                        (begin
                            (if
                                (and
                                    (= set 1)
                                    (> wave 2)
                                )
                                (set support 1)
                            )
                            (if
                                (> wave_total 15)
                                (begin
                                    (set support 1)
                                    (set support_squads 1)
                                )
                            )
                        )
                    )
                    (sleep 90)
                    (set support 0)
                    (set support_squads 0)
                    (begin_random
                        (set wave1_number 0)
                        (set wave1_number 1)
                        (set wave1_number 2)
                        (set wave1_number 3)
                        (set wave1_number 4)
                        (set wave1_number 5)
                        (set wave1_number 6)
                    )
                    (if
                        (= wave1_number 0)
                        (begin
                            (ai_place elite_patrol_a)
                            (ai_magically_see_players elite_patrol_a)
                            (ai_try_to_fight_player elite_patrol_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_patrol_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave1_number 1)
                        (begin
                            (ai_place elite_patrol_b)
                            (ai_magically_see_players elite_patrol_b)
                            (ai_try_to_fight_player elite_patrol_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count elite_patrol_b) 0)
                            )
                        )
                    )
                    (if
                        (= wave1_number 2)
                        (begin
                            (ai_place jackal_patrol)
                            (ai_magically_see_players jackal_patrol)
                            (ai_try_to_fight_player jackal_patrol)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count jackal_patrol) 0)
                            )
                        )
                    )
                    (if
                        (= wave1_number 3)
                        (begin
                            (ai_place grunt_patrol)
                            (ai_magically_see_players grunt_patrol)
                            (ai_try_to_fight_player grunt_patrol)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count grunt_patrol) 0)
                            )
                        )
                    )
                    (if
                        (= wave1_number 4)
                        (begin
                            (ai_place jackal_grunt_patrol)
                            (ai_magically_see_players jackal_grunt_patrol)
                            (ai_try_to_fight_player jackal_grunt_patrol)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count jackal_grunt_patrol) 0)
                            )
                        )
                    )
                    (if
                        (= wave1_number 5)
                        (begin
                            (ai_place brute_patrol_a)
                            (ai_magically_see_players brute_patrol_a)
                            (ai_try_to_fight_player brute_patrol_a)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_patrol_a) 0)
                            )
                        )
                    )
                    (if
                        (= wave1_number 6)
                        (begin
                            (ai_place brute_patrol_b)
                            (ai_magically_see_players brute_patrol_b)
                            (ai_try_to_fight_player brute_patrol_b)
                            (dont_drop_the_soap)
                            (sleep_until
                                (= (ai_living_count brute_patrol_b) 0)
                            )
                        )
                    )
                )
            )
        )
    )
    (if
        (= legendary_mode 1)
        (begin
            (set support 1)
            (set player_tracking 1)
            (begin_random
                (set wave5_number 0)
                (set wave5_number 1)
                (set wave5_number 2)
                (set wave5_number 3)
                (set wave5_number 4)
                (set wave5_number 5)
                (set wave5_number 6)
                (set wave5_number 7)
                (set wave5_number 8)
                (set wave5_number 9)
                (set wave5_number 10)
                (set wave5_number 11)
            )
            (sleep 30)
            (set support 0)
            (if
                (= wave5_number 0)
                (begin
                    (ai_place elite_pack_a)
                    (ai_magically_see_players elite_pack_a)
                    (ai_try_to_fight_player elite_pack_a)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count elite_pack_a) 0)
                    )
                )
            )
            (if
                (= wave5_number 1)
                (begin
                    (ai_place elite_pack_b)
                    (ai_magically_see_players elite_pack_b)
                    (ai_try_to_fight_player elite_pack_b)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count elite_pack_b) 0)
                    )
                )
            )
            (if
                (= wave5_number 2)
                (begin
                    (ai_place mystic_a)
                    (ai_magically_see_players mystic_a)
                    (ai_try_to_fight_player mystic_a)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count mystic_a) 0)
                    )
                )
            )
            (if
                (= wave5_number 3)
                (begin
                    (ai_place mystic_b)
                    (ai_magically_see_players mystic_b)
                    (ai_try_to_fight_player mystic_b)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count mystic_b) 0)
                    )
                )
            )
            (if
                (= wave5_number 4)
                (begin
                    (ai_place elite_killsquad_a)
                    (ai_magically_see_players elite_killsquad_a)
                    (ai_try_to_fight_player elite_killsquad_a)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count elite_killsquad_a) 0)
                    )
                )
            )
            (if
                (= wave5_number 5)
                (begin
                    (ai_place elite_killsquad_b)
                    (ai_magically_see_players elite_killsquad_b)
                    (ai_try_to_fight_player elite_killsquad_b)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count elite_killsquad_b) 0)
                    )
                )
            )
            (if
                (= wave5_number 6)
                (begin
                    (ai_place elite_killsquad_c)
                    (ai_magically_see_players elite_killsquad_c)
                    (ai_try_to_fight_player elite_killsquad_c)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count elite_killsquad_c) 0)
                    )
                )
            )
            (if
                (= wave5_number 7)
                (begin
                    (ai_place brute_killsquad_a)
                    (ai_magically_see_players brute_killsquad_a)
                    (ai_try_to_fight_player brute_killsquad_a)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count brute_killsquad_a) 0)
                    )
                )
            )
            (if
                (= wave5_number 8)
                (begin
                    (ai_place brute_killsquad_b)
                    (ai_magically_see_players brute_killsquad_b)
                    (ai_try_to_fight_player brute_killsquad_b)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count brute_killsquad_b) 0)
                    )
                )
            )
            (if
                (= wave5_number 9)
                (begin
                    (ai_place brute_killsquad_c)
                    (ai_magically_see_players brute_killsquad_c)
                    (ai_try_to_fight_player brute_killsquad_c)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count brute_killsquad_c) 0)
                    )
                )
            )
            (if
                (= wave5_number 10)
                (begin
                    (ai_place brute_pack_a)
                    (ai_magically_see_players brute_pack_a)
                    (ai_try_to_fight_player brute_pack_a)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count brute_pack_a) 0)
                    )
                )
            )
            (if
                (= wave5_number 11)
                (begin
                    (ai_place brute_pack_b)
                    (ai_magically_see_players brute_pack_b)
                    (ai_try_to_fight_player brute_pack_b)
                    (dont_drop_the_soap)
                    (sleep_until
                        (= (ai_living_count brute_pack_b) 0)
                    )
                )
            )
        )
    )
    (set support 0)
    (set debugging 1)
    (garbage_collect_now)
    (rasterizer_decals_flush)
    (set player_tracking 0)
    (set variable 1)
)


(script continuous firefight_repeat
    (sleep_until (= block 0))
    (sleep_until (= firefight 1))
    (if
        (= intro 1)
        (begin
            (sound_impulse_start rzs_halo\levels\s9_v3\sounds\devices\cruiser_flyover none 1.000000)
            (object_create_anew cr)
            (device_set_position cr 1.000000)
            (sleep 1040)
            (sleep 30)
            (sound_looping_start rzs_halo\s9\assets\sounds\music\ff_begin\ff_begin none 1.000000)
            (sleep 45)
            (sound_impulse_start rzs_halo\s9\assets\sounds\ff_dia\survival_welcome3.wav none 1.000000)
            (sleep 90)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_timer_beep.wav none 1.000000)
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_timer_beep.wav none 1.000000)
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_timer_beep.wav none 1.000000)
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_respawn.wav none 1.000000)
            (set intro 0)
            (set firefight 1)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\ff_begin\ff_begin)
        )
    )
    (if
        (and
            (> wave_total 1)
            (= wave 1)
        )
        (begin
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_timer_beep.wav none 1.000000)
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_timer_beep.wav none 1.000000)
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_timer_beep.wav none 1.000000)
            (sleep 30)
            (sound_impulse_start rzs_halo\s9\assets\sounds\sfx\menu\player_respawn.wav none 1.000000)
        )
    )
    (if
        (= wave 5)
        (begin_random
            (set music 1)
            (set music 2)
            (set music 3)
            (set music 4)
            (set music 5)
            (set music 6)
            (set music 7)
        )
    )
    (if
        (= wave_total 1)
        (sound_looping_start rzs_halo\s9\assets\sounds\music\atmo_set\atmo none 1.000000)
    )
    (sleep 30)
    (if
        (and
            (= wave 5)
            (> music 0)
        )
        (begin
            (if
                (= music 1)
                (sound_looping_start rzs_halo\s9\assets\sounds\music\perc1\perc1 none 1.000000)
            )
            (if
                (= music 2)
                (sound_looping_start rzs_halo\s9\assets\sounds\music\drums\drums none 1.000000)
            )
            (if
                (= music 3)
                (sound_looping_start rzs_halo\s9\assets\sounds\music\skyline\skyline none 1.000000)
            )
            (if
                (= music 4)
                (sound_looping_start rzs_halo\sounds\music\reach\engaged_final\engaged_final none 1.000000)
            )
            (if
                (= music 5)
                (sound_looping_start rzs_halo\sounds\music\reach\drum_dum\drum_dun none 1.000000)
            )
            (if
                (= music 6)
                (sound_looping_start rzs_halo\sounds\music\reach\sound_looping\obstacle none 1.000000)
            )
            (if
                (= music 7)
                (sound_looping_start rzs_halo\sounds\music\reach\sound_looping\overture_doomed none 1.000000)
            )
        )
    )
    (spawn_waves)
    (set debugging 0)
    (sleep -1)
    (sleep_until (= death 0))
    (sleep 60)
    (if
        (and
            (= wave 5)
            (> music 0)
        )
        (begin
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\skyline\skyline)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\drums\drums)
            (sound_looping_stop rzs_halo\s9\assets\sounds\music\perc1\perc1)
            (sound_looping_stop rzs_halo\sounds\music\reach\engaged_final\engaged_final)
            (sound_looping_stop rzs_halo\sounds\music\reach\drum_dum\drum_dun)
            (sound_looping_stop rzs_halo\sounds\music\reach\sound_looping\overture_doomed)
            (sound_looping_stop rzs_halo\sounds\music\reach\sound_looping\obstacle)
            (set music 5)
        )
    )
    (if
        (= wave 1)
        (sound_looping_stop rzs_halo\s9\assets\sounds\music\atmo_set\atmo)
    )
    (if
        (= wave 5)
        (begin
            (object_create_anew_containing y)
            (unit_set_current_vitality
                (unit (list_get (players) 0))
                100.000000
                100.000000
            )
            (if
                (< lives_count 12)
                (set lives_count (+ lives_count 1.000000))
            )
            (sound_impulse_start rzs_halo\s9\assets\sounds\ff_dia\lives_added none 1.000000)
            (sleep 60)
            (sound_impulse_start rzs_halo\s9\assets\sounds\ff_dia\survival_awarded_weapon.wav none 1.000000)
            (set wave 0)
            (sleep 900)
        )
    )
    (if
        (= wave_total 30)
        (set legendary_mode 1)
    )
    (set wave (+ wave 1.000000))
    (set wave_total (+ wave_total 1.000000))
    (sound_impulse_start rzs_halo\s9\assets\sounds\ff_dia\survival_awarded_lives\testies none 1.000000)
    (sleep 30)
)


(script continuous wake_up
    (sleep_until (= variable 1))
    (wake firefight_repeat)
    (set variable 0)
)


(script continuous support
    (sleep_until (= support 1))
    (garbage_collect_now)
    (rasterizer_decals_flush)
    (if
        (or
            (=
                (vehicle_test_seat
                    g1
                    driver
                    (unit (list_get (players) 0))
                )
                1
            )
            (=
                (vehicle_test_seat
                    g2
                    driver
                    (unit (list_get (players) 0))
                )
                1
            )
            (=
                (vehicle_test_seat
                    w1
                    driver
                    (unit (list_get (players) 0))
                )
                1
            )
        )
        (begin
            (unit_set_enterable_by_player g1 0)
            (unit_set_enterable_by_player g2 0)
            (unit_set_enterable_by_player w1 0)
            (unit_exit_vehicle
                (unit (list_get (players) 0))
            )
        )
    )
    (sleep 60)
    (object_destroy w1)
    (object_destroy g1)
    (object_destroy g2)
    (unit_set_enterable_by_player g1 1)
    (unit_set_enterable_by_player g2 1)
    (unit_set_enterable_by_player w1 1)
    (unit_set_enterable_by_player b1 0)
    (unit_set_enterable_by_player b2 0)
    (begin_random
        (set a_support 0)
        (set a_support 1)
        (set a_support 2)
        (set a_support 4)
        (set a_support 5)
    )
    (if
        (= a_support 0)
        (begin
            (ai_place wraith)
            (object_create_anew w1)
            (vehicle_load_magic w1 "" (ai_actors wraith))
            (ai_magically_see_players wraith)
            (ai_try_to_fight_player wraith)
            (dont_drop_the_soap)
            (sleep_until
                (= (ai_living_count wraith) 0)
            )
        )
    )
    (if
        (= a_support 1)
        (begin
            (object_create_anew g1)
            (object_create_anew g2)
            (ai_place ghosts)
            (ai_magically_see_players ghosts)
            (ai_try_to_fight_player ghosts)
            (dont_drop_the_soap)
            (sleep_until
                (= (ai_living_count ghosts) 0)
            )
        )
    )
    (if
        (= a_support 2)
        (begin
            (ai_place hunters)
            (ai_magically_see_players hunters)
            (ai_try_to_fight_player hunters)
            (dont_drop_the_soap)
            (sleep_until
                (= (ai_living_count hunters) 0)
            )
        )
    )
    (if
        (= a_support 3)
        (begin
            (ai_place banshee)
            (object_create_anew b1)
            (object_create_anew b2)
            (ai_magically_see_players banshee)
            (ai_try_to_fight_player banshee)
            (dont_drop_the_soap)
            (sleep_until
                (= (ai_living_count banshee) 0)
            )
        )
    )
    (if
        (= a_support 4)
        (begin
            (ai_place inv_elites)
            (ai_magically_see_players inv_elites)
            (ai_try_to_fight_player inv_elites)
            (dont_drop_the_soap)
            (sleep_until
                (= (ai_living_count inv_elites) 0)
            )
        )
    )
    (if
        (= a_support 5)
        (begin
            (ai_place brute_sniper)
            (ai_magically_see_players brute_sniper)
            (ai_try_to_fight_player brute_sniper)
            (dont_drop_the_soap)
            (sleep_until
                (= (ai_living_count brute_sniper) 0)
            )
        )
    )
)


(script continuous elite_support
    (sleep_until (= support_squads 1))
    (set support_squads 0)
    (ai_place elite_support)
    (ai_magically_see_players elite_support)
    (ai_try_to_fight_player elite_support)
    (sleep_until
        (= (ai_living_count elite_support) 0)
    )
)

