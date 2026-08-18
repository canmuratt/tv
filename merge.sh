#!/usr/bin/env bash
set -e
SOURCES=(
  "https://iptv-org.github.io/iptv/countries/tr.m3u"
  "https://streams.uzunmuhalefet.com/lists/tr.m3u"
  "https://iptv-org.github.io/iptv/countries/at.m3u"
)
echo "#EXTM3U" > playlist.m3u
for url in "${SOURCES[@]}"; do
  curl -sL --max-time 60 "$url" | sed 's/\r$//' | grep -v '^#EXTM3U' >> playlist.m3u || echo "WARN: failed $url" >&2
done
echo "Channels: $(grep -c '^#EXTINF' playlist.m3u)"
