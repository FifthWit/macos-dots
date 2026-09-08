function remove-tiktok
    if test (count $argv) -ne 1
        echo "Usage: remove-tiktok <video-file>"
        return 1
    end
    
    set input $argv[1]
    
    if not test -f "$input"
        echo "Error: file not found: $input"
        return 1
    end
    
    set duration (ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input" 2>/dev/null)
    
    if test -z "$duration"
        echo "Error: could not read video duration"
        return 1
    end
    
    set remaining (math "$duration - 5")
    
    # -- must come BEFORE the pattern so -* isn't parsed as an option
        if string match -q -- '-*' "$remaining"
                echo "Error: video is $duration seconds, must be longer than 3s"
                return 1
        else if string match -qr -- '^0(\.0*)?$' "$remaining"
                echo "Error: video is exactly 3 seconds, nothing would remain"
                return 1
        end
    
        set dir (dirname "$input")
        set base (basename "$input")
        set ext (string match -r '\.[^.]*$' "$base" || echo '')
        set stem (string replace -r '\.[^.]*$' '' "$base")
        set tmpfile "$dir/$stem.tmp$ext"
    
        ffmpeg -hide_banner -loglevel error -i "$input" -t "$remaining" -c copy -y "$tmpfile"
        
        if test $status -ne 0
                echo "Error: ffmpeg failed, aborting"
                rm -f "$tmpfile"
                return 1
        end
    
        mv "$tmpfile" "$input"
        echo "Done: removed last 3s from $input"
end
