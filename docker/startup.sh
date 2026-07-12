#!/bin/bash

cp -rn /comfy_defaults/models/* /comfyUI/models/ 2>/dev/null || true
cp -rn /comfy_defaults/custom_nodes/* /comfyUI/custom_nodes/ 2>/dev/null || true

if [ ! -f "/comfyUI/.container_started" ]; then
    echo "First start: Running restore-dependencies"
    python custom_nodes/ComfyUI-Manager/cm-cli.py restore-dependencies
    touch /comfyUI/.container_started
else
    echo "Container restarted: Skipping restore-dependencies"
fi

exec python main.py --listen
