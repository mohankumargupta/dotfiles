set shell := ["sh", "-c"]
set windows-shell := ["powershell", "-c"]

@_menu:
    just --list yt-dlp

[no-cd]
download youtube_url:
    yt-dlp --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" {{ youtube_url }}

[no-cd]
download_720p youtube_url:
    yt-dlp -S vcodec:h264,fps,res:720,acodec:m4a {{ youtube_url }}

[no-cd]
download_1080p youtube_url:
    yt-dlp -S vcodec:h264,fps,res:1080,acodec:m4a {{ youtube_url }}
    
formats youtube_url:
    yt-dlp --list-formats {{ youtube_url }}

# timestamp in format 00:03:12
[no-cd]
download_section youtube_url timestamp_start timestamp_end:
    yt-dlp yt-dlp -S vcodec:h264,fps,res:720,acodec:m4a --download-sections "*{{ timestamp_start }}-{{ timestamp_end }}" --force-keyframes-at-cuts {{ youtube_url }}
    
[no-cd]
screenshot youtube_url timestamp file:
    ffmpeg -i $(yt-dlp -f "bv[width=1920][ext=mp4]" --get-url {{ youtube_url }}) -vframes 1 -q:v 2 -ss {{ timestamp }} {{ file }}


