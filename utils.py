import subprocess
import time
import os
import httpx  # already installed via openai

def launch_furiosa_server(
    *,
    name: str,
    model: str,
    port: int,
    devices: str,
    image: str = "furiosaai/furiosa-llm:latest",
    wait_timeout: int = 600,
):
    """Launch a furiosa-llm server in a detached docker container and wait until ready."""
    
    subprocess.run(["docker", "rm", "-f", name], check=False, capture_output=True)
    
    cmd = [
        "docker", "run", "-d", "--rm",
        "--name", name,
        "--device", "/dev/rngd:/dev/rngd",
        "--security-opt", "seccomp=unconfined",
        "--env", f"HF_TOKEN={os.environ.get('HF_TOKEN', '')}",
        "-v", f"{os.path.expanduser('~')}/.cache/huggingface:/root/.cache/huggingface",
        "-p", f"{port}:{port}",
        image,
        "serve", model,
        "--port", str(port),
        "--devices", devices,
    ]
    result = subprocess.run(cmd, check=True, capture_output=True, text=True)
    container_id = result.stdout.strip()
    print(f"Started {name} ({container_id[:12]}) on port {port}")
    
    url = f"http://localhost:{port}/v1/models"
    deadline = time.time() + wait_timeout
    while time.time() < deadline:
        try:
            r = httpx.get(url, timeout=2)
            if r.status_code == 200:
                print(f"{name} ready at http://localhost:{port}")
                return container_id
        except httpx.RequestError:
            pass
        time.sleep(2)
    
    logs = subprocess.run(["docker", "logs", "--tail", "50", name],
                          capture_output=True, text=True).stdout
    raise TimeoutError(f"{name} did not become ready in {wait_timeout}s. Last logs:\n{logs}")


def stop_server(name: str):
    subprocess.run(["docker", "stop", name], check=False, capture_output=True)
    print(f"Stopped {name}")