
set shell:= ["bash", "-c"]
set windows-shell := ["powershell", "-c"]

mod yt-dlp "justfile-ytdlp.just"

@_main:
    just --list

nix pkg:
    export NIXPKGS_ALLOW_UNFREE=1
    nix-env -iA nixpkgs.{{ pkg }}

[no-cd]
zeroclaw:
  zeroclaw agent


#[no-cd]
#zeroclaw message:
#	zeroclaw agent -m "{{ message }}"

#[no-cd]
#zeroclaw message="add device bmp180 to espforge":
#	RUST_LOG=trace zeroclaw agent -m "{{ message }}" 2>&1


#zeroclaw message="create a wokwi diagram from blink.yaml using wokwi-diagramjson skill"
#    RUST_LOG=trace zeroclaw agent -m "{{ message }}"   |tee boo.txt

[no-cd]
wokwicli:
    wokwi-cli . --timeout 5000 --expect-text "Goodbye"

[no-cd]
picoclaw message="add device bmp180 to espforge":
    rm -f ~/.picoclaw/workspace/sessions/*
    picoclaw agent -m "{{ message }}"

groqmodels:
    uv run --with=requests python groqmodels.py

[no-cd]
qwen message:
	qwen agent -m "{{ message }}"

vpn_up:
    wg-quick up mohan
    
vpn_down:
    wg-quick down mohan

[no-cd]
clip file:
    xclip -selection clipboard < "{{ file }}"

#[no-cd]
#screenshot youtube_url timestamp file:
#    ffmpeg -ss 00:{{ timestamp }} -i "$(yt-dlp -g -f bestvideo {{ youtube_url }})" -vframes 1 -q:v 2 {{ file }}

[no-cd]    
emacs:
    emacs -nw .

debuginit:
    emacs --debug-init

[no-cd]
screenshot youtube_url timestamp file:
    start="00:{{timestamp}}"; \
    end=$(python3 -c 'from datetime import datetime, timedelta; t = datetime.strptime("{{timestamp}}", "%M:%S"); print((t + timedelta(seconds=1)).strftime("%H:%M:%S"))'); \
    yt-dlp -f "bv*+ba/b" --merge-output-format mkv  --download-sections "*$start-$end" -o 'clip.%(ext)s' "{{youtube_url}}"; \
    ffmpeg -y -i clip.mkv -frames:v 1 "{{file}}"
    rm clip.mkv
    
