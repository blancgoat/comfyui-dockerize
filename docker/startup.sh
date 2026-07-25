#!/bin/bash

cp -rn /comfy_defaults/models/* /comfyUI/models/ 2>/dev/null || true
cp -rn /comfy_defaults/custom_nodes/* /comfyUI/custom_nodes/ 2>/dev/null || true

mkdir -p /comfyUI/user

MANAGER_CONFIG=/comfyUI/user/__manager/config.ini
mkdir -p "$(dirname "$MANAGER_CONFIG")"
if [ ! -f "$MANAGER_CONFIG" ]; then
    printf '[default]\nnetwork_mode = personal_cloud\nsecurity_level = normal\n' > "$MANAGER_CONFIG"
elif grep -q '^[[:space:]]*network_mode[[:space:]]*=[[:space:]]*public' "$MANAGER_CONFIG"; then
    sed -i 's/^[[:space:]]*network_mode[[:space:]]*=.*/network_mode = personal_cloud/' "$MANAGER_CONFIG"
fi

# 마커는 반드시 컨테이너 파일시스템(마운트 밖)에 둡니다.
# 커스텀 노드의 pip 의존성은 site-packages에 설치되어 컨테이너와 수명을 같이 하므로,
# 컨테이너를 재생성하면 노드 디렉토리(바인드 마운트)만 남고 의존성은 사라집니다.
# 마커를 마운트 안에 두면 restore-dependencies를 건너뛰어 import 에러가 납니다.
if [ ! -f "/comfyUI/.container_started" ]; then
    echo "New container: Running restore-dependencies"
    cm-cli restore-dependencies
    touch /comfyUI/.container_started
else
    echo "Container restarted: Skipping restore-dependencies"
fi

exec python main.py --listen --enable-manager
