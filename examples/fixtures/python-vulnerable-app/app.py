import hashlib
import subprocess

from flask import Flask, jsonify, request

app = Flask(__name__)

# Fake secret for scanner validation only. Do not use this value anywhere real.
DEMO_API_KEY = "secureflow_demo_fake_key_do_not_use_python"


@app.get("/")
def health():
    return jsonify(
        {
            "service": "secureflow-python-vulnerable-fixture",
            "demo_key_preview": DEMO_API_KEY[:12],
        }
    )


@app.post("/hash")
def hash_value():
    value = request.json.get("value", "secureflow")
    digest = hashlib.md5(value.encode()).hexdigest()
    return jsonify({"md5": digest})


@app.post("/run")
def run_command():
    command = request.json.get("command", "echo secureflow")
    result = subprocess.check_output(command, shell=True, text=True)
    return jsonify({"output": result})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
