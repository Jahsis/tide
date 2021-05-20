function _fake_tide_right_prompt
    set -l lastItem newline

    for item in $fake_tide_right_prompt_items
        if test "$item" = newline
            set_color $previousColor -b normal
            printf '%s' $fake_tide_right_prompt_suffix\n
        else
            set -l output (_fake_tide_item_$item)
            test -n "$output" || continue

            set -l colorName fake_tide_"$item"_bg_color
            set -l color $$colorName

            if test "$lastItem" = newline
                set_color $color -b normal
                printf '%s' $fake_tide_right_prompt_prefix
            else if test "$color" = "$previousColor"
                set_color $fake_                printf '%s' $fake_tide_right_prompt_separator_same_color
            else
                set_color $color -b $previousColor
                printf '%s' $fake_tide_right_prompt_separator_diff_color
            end

            set_color -b $color

            if test "$fake_tide_prompt_pad_items" = true -a "$item" != character
                printf '%s' " $output "
            else
                printf '%s' "$output"
            end

            set previousColor $color
        end
        set lastItem $item
    end

    if test "$lastItem" != newline
        set_color $previousColor -b normal
        printf '%s' $fake_tide_right_prompt_suffix
    end
end
